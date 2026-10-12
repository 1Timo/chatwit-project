import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:chatwit_flutter/core/webrtc_service.dart';

class CallScreen extends StatefulWidget {
  final WebRTCService webRTCService;
  final String userName;
  final bool isVideoCall;
  final String roomId;
  final String remoteUserId;
  final String currentUserId;

  const CallScreen({
    super.key,
    required this.webRTCService,
    required this.userName,
    required this.isVideoCall,
    required this.roomId,
    required this.remoteUserId,
    required this.currentUserId,
  });

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool _isAudioMuted = false;
  bool _isVideoMuted = false;
  bool _isRecording = false;
  late Timer _recordingTimer;

  @override
  void initState() {
    super.initState();
    _startCall();
    // Update UI every second to show recording time
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_isRecording && mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _recordingTimer.cancel();
    super.dispose();
  }

  Future<void> _startCall() async {
    await widget.webRTCService.initialize(
      roomId: widget.roomId,
      remoteUserId: widget.remoteUserId,
      currentUserId: widget.currentUserId,
    );
    await widget.webRTCService.startCall(video: widget.isVideoCall);
    if (mounted) setState(() {});
  }

  void _toggleAudio() {
    setState(() {
      _isAudioMuted = !_isAudioMuted;
      widget.webRTCService.toggleAudio(!_isAudioMuted);
    });
  }

  void _toggleVideo() {
    setState(() {
      _isVideoMuted = !_isVideoMuted;
      widget.webRTCService.toggleVideo(!_isVideoMuted);
    });
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      // Stop recording
      final audioData = await widget.webRTCService.stopRecording();
      setState(() {
        _isRecording = false;
      });

      // Upload the recording if we got data
      if (audioData != null) {
        final uploaded = await widget.webRTCService.uploadRecording(audioData);
        if (uploaded && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Recording saved')),
          );
        }
      }
    } else {
      // Start recording
      final success = await widget.webRTCService.startRecording();
      setState(() {
        _isRecording = success;
      });

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recording started')),
        );
      }
    }
  }

  Future<void> _endCall() async {
    // Stop recording if active
    if (_isRecording) {
      final audioData = await widget.webRTCService.stopRecording();
      setState(() {
        _isRecording = false;
      });

      // Upload the recording if we got data
      if (audioData != null) {
        await widget.webRTCService.uploadRecording(audioData);
      }
    }

    await widget.webRTCService.endCall();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (widget.isVideoCall)
            RTCVideoView(
              widget.webRTCService.remoteRenderer,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            ),
          if (widget.isVideoCall)
            Positioned(
              top: 40,
              right: 20,
              child: Container(
                width: 120,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: RTCVideoView(
                    widget.webRTCService.localRenderer,
                    mirror: true,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  ),
                ),
              ),
            ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  widget.userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Calling...',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                if (_isRecording)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Recording: ${_formatDuration(widget.webRTCService.recordingDurationMs)}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildControlButton(
                        icon: _isAudioMuted ? Icons.mic_off : Icons.mic,
                        color: _isAudioMuted ? Colors.red : Colors.white24,
                        onPressed: _toggleAudio,
                      ),
                      if (widget.isVideoCall)
                        _buildControlButton(
                          icon: _isVideoMuted
                              ? Icons.videocam_off
                              : Icons.videocam,
                          color: _isVideoMuted ? Colors.red : Colors.white24,
                          onPressed: _toggleVideo,
                        ),
                      _buildControlButton(
                        icon: _isRecording
                            ? Icons.stop_circle
                            : Icons.fiber_manual_record,
                        color: _isRecording ? Colors.red : Colors.grey,
                        onPressed: _toggleRecording,
                      ),
                      _buildControlButton(
                        icon: Icons.call_end,
                        color: Colors.red,
                        onPressed: _endCall,
                        isLarge: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    bool isLarge = false,
  }) {
    return CircleAvatar(
      radius: isLarge ? 35 : 28,
      backgroundColor: color,
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: isLarge ? 32 : 24),
        onPressed: onPressed,
      ),
    );
  }

  String _formatDuration(int milliseconds) {
    final seconds = (milliseconds / 1000).toInt();
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}
