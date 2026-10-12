import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chatwit_flutter/core/client.dart';
import 'package:chatwit_flutter/screens/feed_screen.dart';

class PhotoSetupScreen extends StatefulWidget {
  const PhotoSetupScreen({super.key});

  @override
  State<PhotoSetupScreen> createState() => _PhotoSetupScreenState();
}

class _PhotoSetupScreenState extends State<PhotoSetupScreen> {
  bool _isLoading = false;
  Uint8List? _imageBytes;
  Uint8List? _backgroundBytes;
  final TextEditingController _bioController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  Future<void> _pickBackgroundImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _backgroundBytes = bytes;
      });
    }
  }

  Future<String?> _uploadImageToS3(String path, Uint8List bytes) async {
    try {
      final uploadDescription = await client.file.getUploadDescription(path);
      if (uploadDescription != null) {
        final uploader = FileUploader(uploadDescription);
        final byteData = ByteData.sublistView(bytes);
        await uploader.uploadByteData(byteData);
        final verified = await client.file.verifyUpload(path);
        if (verified) return path;
      }
    } catch (e) {
      debugPrint('Upload error: $e');
    }
    return null;
  }

  Future<void> _saveAndContinue() async {
    setState(() => _isLoading = true);
    try {
      // 1. Upload profile photo
      if (_imageBytes != null) {
        final path =
            'profiles/avatars/${DateTime.now().millisecondsSinceEpoch}.jpg';
        final uploadedPath = await _uploadImageToS3(path, _imageBytes!);
        if (uploadedPath != null) {
          await client.userRegistration.updateProfileImageUrl(uploadedPath);
          // Also update auth profile for backward compatibility
          final byteData = ByteData.sublistView(_imageBytes!);
          await client.userProfileEdit.setUserImage(byteData);
        }
      }

      // 2. Upload background photo
      if (_backgroundBytes != null) {
        final path =
            'profiles/backgrounds/${DateTime.now().millisecondsSinceEpoch}.jpg';
        final uploadedPath = await _uploadImageToS3(path, _backgroundBytes!);
        if (uploadedPath != null) {
          await client.userRegistration.updateBackgroundUrl(uploadedPath);
        }
      }

      // 3. Save bio
      final bio = _bioController.text.trim();
      if (bio.isNotEmpty) {
        await client.userRegistration.updateBio(bio);
      }

      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const FeedScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save profile: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Setup"),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Text(
                    "Almost there! Add photos and bio so people know who you are.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 32),
                  // Background Image Picker
                  GestureDetector(
                    onTap: _pickBackgroundImage,
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                        image: _backgroundBytes != null
                            ? DecorationImage(
                                image: MemoryImage(_backgroundBytes!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _backgroundBytes == null
                          ? const Center(
                              child: Icon(
                                Icons.add_photo_alternate,
                                size: 40,
                                color: Color(0xFF6B7280),
                              ),
                            )
                          : const Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.black54,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Profile Image Picker
                  GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: _imageBytes != null
                              ? MemoryImage(_imageBytes!)
                              : null,
                          child: _imageBytes == null
                              ? const Icon(
                                  Icons.add_a_photo,
                                  size: 30,
                                  color: Color(0xFF6B7280),
                                )
                              : null,
                        ),
                        if (_imageBytes != null)
                          const Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: Color(0xFF374151),
                              child: Icon(
                                Icons.edit,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _bioController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: "Bio",
                      hintText: "Tell us about yourself...",
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _saveAndContinue,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Continue to Feed"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const FeedScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text("Skip for now"),
                  ),
                ],
              ),
            ),
    );
  }
}
