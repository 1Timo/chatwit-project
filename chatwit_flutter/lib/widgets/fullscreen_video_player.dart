import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:gal/gal.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;
  final String? videoUrl; // Add optional URL for saving

  const FullScreenVideoPlayer({
    super.key,
    required this.controller,
    this.videoUrl,
  });

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  bool _showUI = true;
  late VideoPlayerController _controller;
  bool _isControllerInitialized = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _initAndPlay();
    _enterFullScreen();
  }

  void _initAndPlay() async {
    if (!_controller.value.isInitialized) {
      await _controller.initialize();
    }
    await _controller.play();
    if (mounted) {
      setState(() {
        _isControllerInitialized = true;
      });
    }
  }

  void _enterFullScreen() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void _exitFullScreen() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    _exitFullScreen();
    super.dispose();
  }

  void _toggleUI() {
    setState(() {
      _showUI = !_showUI;
    });
  }

  Future<void> _saveVideo() async {
    final String? source =
        widget.videoUrl ??
        (_controller.dataSource.startsWith('http')
            ? _controller.dataSource
            : null);

    if (source == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cannot save local/preview video")),
      );
      return;
    }

    if (_isSaving) return;
    setState(() => _isSaving = true);

    try {
      if (Platform.isAndroid) {
        await Permission.storage.request();
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Saving video..."),
          duration: Duration(seconds: 1),
        ),
      );

      final uri = Uri.parse(source);

      if (uri.scheme == 'http' || uri.scheme == 'https') {
        final response = await http.get(uri);
        final bytes = response.bodyBytes;

        final tempDir = await getTemporaryDirectory();
        final file = File(
          '${tempDir.path}/temp_video_${DateTime.now().millisecondsSinceEpoch}.mp4',
        );
        await file.writeAsBytes(bytes);

        await Gal.putVideo(file.path);
      } else {
        final String path = uri.scheme == 'file' ? uri.toFilePath() : source;
        await Gal.putVideo(path);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Video saved to gallery")),
        );
      }
    } catch (e) {
      debugPrint("Error saving video: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save video: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _toggleUI,
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! > 20) {
            Navigator.pop(context);
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: _isControllerInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : const CircularProgressIndicator(),
            ),

            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: _showUI ? 1.0 : 0.0,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 80,
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
                        leading: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                        actions: [
                          if (_showUI)
                            _isSaving
                                ? const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
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
                                      if (value == 'save') _saveVideo();
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

                  Center(
                    child: IconButton(
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_filled,
                        size: 80,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                    ),
                  ),

                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                          colors: const VideoProgressColors(
                            playedColor: Color(0xFF374151),
                            bufferedColor: Colors.white24,
                            backgroundColor: Colors.white10,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Swipe down to exit fullscreen",
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
