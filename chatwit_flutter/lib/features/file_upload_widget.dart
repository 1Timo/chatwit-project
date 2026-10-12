import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:chatwit_flutter/core/client.dart';

class FileUploadWidget extends StatefulWidget {
  const FileUploadWidget({super.key});

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  bool _isUploading = false;

  Future<void> _pickAndUploadFile() async {
    // 1. Let the user select a file
    final file = await FilePicker.pickFile(type: FileType.any);

    if (file != null) {
      setState(() {
        _isUploading = true;
      });

      // S3 compatible path (no leading slash)
      String path = 'uploads/${file.name}';

      try {
        // 2. Request the upload description from your custom post endpoint
        var uploadDescription = await client.post.getUploadDescription(path);

        if (uploadDescription != null) {
          // Convert file bytes to ByteData
          final bytes = await file.readAsBytes();
          final byteData = ByteData.sublistView(bytes);

          // 3. Initialize the FileUploader and upload the data directly to S3
          var uploader = FileUploader(uploadDescription);
          await uploader.uploadByteData(byteData);

          // 4. Verify with the server that S3 received the file successfully
          var success = await client.post.verifyUpload(path);

          if (success) {
            debugPrint('File uploaded to S3 and verified successfully!');
          } else {
            debugPrint('Upload verification failed.');
          }
        }
      } catch (e) {
        debugPrint('Error uploading file to S3: $e');
      } finally {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isUploading ? null : _pickAndUploadFile,
      child: _isUploading
          ? const CircularProgressIndicator()
          : const Text('Upload File to S3'),
    );
  }
}
