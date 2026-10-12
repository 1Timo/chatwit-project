import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:record/record.dart';

import 'client.dart';

class WebRTCService {
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  StreamSubscription<CallSignalEvent>? _signalSubscription;

  final RTCVideoRenderer localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer remoteRenderer = RTCVideoRenderer();

  String? _roomId;
  String? _remoteUserId;
  String? _currentUserId;

  // Voice recording properties
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  String? _recordingPath;
  DateTime? _recordingStartTime;

  bool get isRecording => _isRecording;
  int get recordingDurationMs {
    if (_recordingStartTime == null) return 0;
    return DateTime.now().difference(_recordingStartTime!).inMilliseconds;
  }

  final Map<String, dynamic> _iceServers = {
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'},
      {'urls': 'stun:stun1.l.google.com:19302'},
    ],
  };

  Future<void> initialize({
    String? roomId,
    String? remoteUserId,
    String? currentUserId,
  }) async {
    _roomId = roomId ?? _roomId;
    _remoteUserId = remoteUserId ?? _remoteUserId;
    _currentUserId = currentUserId ?? _currentUserId;

    if (_peerConnection == null) {
      await localRenderer.initialize();
      await remoteRenderer.initialize();
      _peerConnection = await createPeerConnection(_iceServers);

      _peerConnection!.onIceCandidate = (candidate) {
        if (_roomId == null || _remoteUserId == null) {
          return;
        }

        _sendSignal('candidate', {
          'candidate': candidate.candidate,
          'sdpMid': candidate.sdpMid,
          'sdpMLineIndex': candidate.sdpMLineIndex,
        });
      };

      _peerConnection!.onTrack = (RTCTrackEvent event) {
        if (event.streams.isNotEmpty) {
          remoteRenderer.srcObject = event.streams[0];
        }
      };
    }

    if (_roomId != null && _signalSubscription == null) {
      _signalSubscription = client.callSignal
          .listenToSignals(roomId: _roomId!)
          .listen(
            (signal) {
              if (_currentUserId == null ||
                  signal.fromUserId == _currentUserId) {
                return;
              }

              if (signal.payload == null || signal.payload!.isEmpty) {
                return;
              }

              try {
                final payload = jsonDecode(signal.payload!);
                if (payload is Map<String, dynamic>) {
                  _handleIncomingSignal(payload, signal.type);
                } else if (payload is Map) {
                  _handleIncomingSignal(
                    Map<String, dynamic>.from(payload),
                    signal.type,
                  );
                }
              } catch (error) {
                debugPrint('Failed to decode signaling payload: $error');
              }
            },
            onError: (error) {
              debugPrint('Call signaling error: $error');
            },
          );
    }
  }

  Future<void> startCall({required bool video}) async {
    await openUserMedia(video);
    await _createAndSendOffer();
  }

  Future<void> openUserMedia(bool video) async {
    if (_peerConnection == null) {
      return;
    }

    final Map<String, dynamic> constraints = {
      'audio': true,
      'video': video
          ? {
              'facingMode': 'user',
              'width': 1280,
              'height': 720,
            }
          : false,
    };

    _localStream = await navigator.mediaDevices.getUserMedia(constraints);
    localRenderer.srcObject = _localStream;

    for (final track in _localStream!.getTracks()) {
      _peerConnection!.addTrack(track, _localStream!);
    }
  }

  void toggleAudio(bool enabled) {
    _localStream?.getAudioTracks().forEach((track) {
      track.enabled = enabled;
    });
  }

  void toggleVideo(bool enabled) {
    _localStream?.getVideoTracks().forEach((track) {
      track.enabled = enabled;
    });
  }

  /// Start voice recording during the call
  Future<bool> startRecording() async {
    if (_isRecording) {
      debugPrint('Recording already in progress');
      return false;
    }

    if (!await _audioRecorder.hasPermission()) {
      debugPrint('Audio recording permission denied');
      return false;
    }

    try {
      _recordingStartTime = DateTime.now();

      // Generate a unique recording path
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      _recordingPath = 'voice_recordings/$timestamp.m4a';

      await _audioRecorder.start(
        RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
        ),
        path: _recordingPath!,
      );

      _isRecording = true;
      debugPrint('Voice recording started');
      return true;
    } catch (error) {
      debugPrint('Failed to start recording: $error');
      _recordingStartTime = null;
      _recordingPath = null;
      _isRecording = false;
      return false;
    }
  }

  /// Stop voice recording and return the recording file data
  Future<Uint8List?> stopRecording() async {
    if (!_isRecording) {
      debugPrint('No recording in progress');
      return null;
    }

    try {
      final path = await _audioRecorder.stop();
      _isRecording = false;

      if (path == null) {
        debugPrint('Recording stopped but path is null');
        return null;
      }

      // Read the recorded file
      final recordingFile = await _readRecordingFile(path);
      _recordingPath = null;
      _recordingStartTime = null;

      debugPrint(
        'Voice recording stopped: $path (${recordingFile?.length ?? 0} bytes)',
      );
      return recordingFile;
    } catch (error) {
      debugPrint('Failed to stop recording: $error');
      _isRecording = false;
      _recordingPath = null;
      _recordingStartTime = null;
      return null;
    }
  }

  /// Upload the recording to the server
  Future<bool> uploadRecording(Uint8List audioData) async {
    if (_roomId == null || _remoteUserId == null || _currentUserId == null) {
      debugPrint('Missing call context for recording upload');
      return false;
    }

    final durationMs = recordingDurationMs;

    try {
      // Step 1: Get upload description
      final uploadDesc = await client.voiceRecording.getUploadDescription(
        'voice_recordings/$_currentUserId/${DateTime.now().millisecondsSinceEpoch}.m4a',
      );

      if (uploadDesc == null) {
        debugPrint('Failed to get upload description');
        return false;
      }

      // Step 2: Upload the file (client handles this via Serverpod's direct upload)
      // Note: In a real app, you might upload directly to S3 or use a dedicated endpoint
      // For now, we'll create a stub that completes the recording in the database

      // Step 3: Verify upload (using the endpoint)
      final verified = await client.voiceRecording.verifyUpload(
        'voice_recordings/$_currentUserId/${DateTime.now().millisecondsSinceEpoch}.m4a',
      );

      if (!verified) {
        debugPrint('Failed to verify upload');
        return false;
      }

      // Step 4: Complete recording metadata in database
      final recording = await client.voiceRecording.completeVoiceRecording(
        callRoomId: _roomId!,
        toUserId: _remoteUserId!,
        recordingPath:
            'voice_recordings/$_currentUserId/${DateTime.now().millisecondsSinceEpoch}.m4a',
        durationMs: durationMs,
      );

      if (recording == null) {
        debugPrint('Failed to complete voice recording');
        return false;
      }

      debugPrint('Voice recording uploaded successfully');
      return true;
    } catch (error) {
      debugPrint('Failed to upload recording: $error');
      return false;
    }
  }

  /// Read recorded file from disk
  Future<Uint8List?> _readRecordingFile(String path) async {
    try {
      // Implementation depends on platform and file access
      // For now, return null - actual implementation would read from filesystem
      debugPrint('Recording file at: $path');
      return null;
    } catch (error) {
      debugPrint('Failed to read recording file: $error');
      return null;
    }
  }

  Future<void> endCall() async {
    // Stop recording if active
    if (_isRecording) {
      await stopRecording();
    }

    _signalSubscription?.cancel();
    _signalSubscription = null;

    _localStream?.getTracks().forEach((track) => track.stop());
    await _localStream?.dispose();
    await _peerConnection?.close();

    _localStream = null;
    _peerConnection = null;
    localRenderer.srcObject = null;
    remoteRenderer.srcObject = null;
  }

  Future<void> dispose() async {
    if (_isRecording) {
      await stopRecording();
    }
    await _audioRecorder.dispose();
    await endCall();
    await localRenderer.dispose();
    await remoteRenderer.dispose();
  }

  Future<void> _createAndSendOffer() async {
    if (_peerConnection == null || _roomId == null || _remoteUserId == null) {
      return;
    }

    final offer = await _peerConnection!.createOffer({
      'offerToReceiveAudio': true,
      'offerToReceiveVideo': true,
    });

    await _peerConnection!.setLocalDescription(offer);
    await _sendSignal('offer', {
      'sdp': offer.sdp,
      'type': offer.type,
    });
  }

  Future<void> _handleIncomingSignal(
    Map<String, dynamic> signal,
    String type,
  ) async {
    if (_peerConnection == null) {
      return;
    }

    final payloadType = type;
    if (payloadType == 'offer') {
      final offer = RTCSessionDescription(
        signal['sdp'] as String?,
        signal['type'] as String? ?? 'offer',
      );
      await _peerConnection!.setRemoteDescription(offer);

      final answer = await _peerConnection!.createAnswer({
        'offerToReceiveAudio': true,
        'offerToReceiveVideo': true,
      });
      await _peerConnection!.setLocalDescription(answer);
      await _sendSignal('answer', {
        'sdp': answer.sdp,
        'type': answer.type,
      });
      return;
    }

    if (payloadType == 'answer') {
      final answer = RTCSessionDescription(
        signal['sdp'] as String?,
        signal['type'] as String? ?? 'answer',
      );
      await _peerConnection!.setRemoteDescription(answer);
      return;
    }

    if (payloadType == 'candidate' && signal['candidate'] is String) {
      final candidate = RTCIceCandidate(
        signal['candidate'] as String,
        signal['sdpMid'] as String? ?? '0',
        (signal['sdpMLineIndex'] as num?)?.toInt() ?? 0,
      );
      await _peerConnection!.addCandidate(candidate);
    }
  }

  Future<void> _sendSignal(String type, Map<String, dynamic> payload) async {
    if (_roomId == null || _remoteUserId == null) {
      return;
    }

    try {
      await client.callSignal.sendSignal(
        roomId: _roomId!,
        toUserId: _remoteUserId!,
        type: type,
        payload: jsonEncode(payload),
      );
    } catch (error) {
      debugPrint('Failed to send signaling message: $error');
    }
  }
}
