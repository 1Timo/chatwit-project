import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:chatwit_flutter/core/image_utils.dart';

class FullScreenImageViewer extends StatefulWidget {
  final String imageUrl;
  final String tag;

  const FullScreenImageViewer({
    super.key,
    required this.imageUrl,
    this.tag = 'hero-image',
  });

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  bool _showUI = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _toggleUI() {
    setState(() {
      _showUI = !_showUI;
    });
  }

  Future<void> _saveImage() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);

    try {
      if (Platform.isAndroid) {
        await Permission.storage.request();
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Saving image..."),
          duration: Duration(seconds: 1),
        ),
      );

      if (widget.imageUrl.startsWith('http')) {
        final response = await http.get(Uri.parse(widget.imageUrl));
        final tempDir = await getTemporaryDirectory();
        final file = File(
          '${tempDir.path}/temp_image_${DateTime.now().millisecondsSinceEpoch}.jpg',
        );
        await file.writeAsBytes(response.bodyBytes);
        await Gal.putImage(file.path);
      } else {
        String path = widget.imageUrl;
        if (path.startsWith('file://')) {
          path = Uri.parse(path).toFilePath();
        }
        await Gal.putImage(path);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Image saved to gallery")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save image: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Widget _buildImage() {
    if (widget.imageUrl.startsWith('http')) {
      return ChatwitImage.image(
        widget.imageUrl,
        fit: BoxFit.contain,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image, color: Colors.white, size: 100),
      );
    } else {
      String path = widget.imageUrl;
      if (path.startsWith('file://')) {
        try {
          path = Uri.parse(path).toFilePath();
        } catch (e) {
          path = path.replaceFirst('file://', '');
        }
      }
      return Image.file(
        File(path),
        fit: BoxFit.contain,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image, color: Colors.white, size: 100),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GestureDetector(
            onTap: _toggleUI,
            onVerticalDragUpdate: (details) {
              if (details.primaryDelta! > 20) Navigator.pop(context);
            },
            child: Center(
              child: Hero(
                tag: widget.tag,
                child: InteractiveViewer(
                  minScale: 1.0,
                  maxScale: 5.0,
                  child: _buildImage(),
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _showUI ? 1.0 : 0.0,
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black54, Colors.transparent],
                ),
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                elevation: 0,
                title: _showUI
                    ? const Text("Image", style: TextStyle(fontSize: 16))
                    : null,
                actions: [
                  if (_showUI)
                    _isSaving
                        ? const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          )
                        : PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert),
                            onSelected: (value) {
                              if (value == 'save') _saveImage();
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'save',
                                child: ListTile(
                                  leading: Icon(Icons.download),
                                  title: Text("Save"),
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                ),
                              ),
                            ],
                          ),
                ],
              ),
            ),
          ),
          if (_showUI)
            const Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Swipe down to close",
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
