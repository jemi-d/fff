import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  // final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  // bool isRecording = false;
  // String? _audioFilePath;

  @override
  void initState() {
    // _initRecorder();
    _initAudio();
    super.initState();
  }

  Future<void> _initAudio() async {
    try {
      // await _audioPlayer.setUrl(
      //     "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3");
      await _audioPlayer.setAsset("assets/audio/hb_song.mp3");

      _audioPlayer.durationStream.listen((duration) {
        setState(() {
          _duration = duration ?? Duration.zero;
        });
      });

      _audioPlayer.positionStream.listen((position) {
        setState(() {
          _position = position;
        });
      });

      _audioPlayer.playerStateStream.listen((state) {
        setState(() {
          isPlaying = state.playing;
        });
      });
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  void _togglePlayPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
  }

  void _seekAudio(Duration position) {
    _audioPlayer.seek(position);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Audio Player & Recorder")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     ElevatedButton(
        //       onPressed: isRecording ? _stopRecording : _startRecording,
        //       child: Text(isRecording ? "Stop Recording" : "Start Recording"),
        //     ),
        //     SizedBox(height: 20),
        //     ElevatedButton(
        //       onPressed: isPlaying ? _stopAudio : _playAudio,
        //       child: Text(isPlaying ? "Stop Audio" : "Play Audio"),
        //     ),
        //     SizedBox(height: 20),
        //     if (_audioFilePath != null) Text("Saved: $_audioFilePath"),
        //   ],
        // ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, size: 50),
                onPressed: _togglePlayPause,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await _audioPlayer.stop();
                  setState(() {
                    isPlaying = false;
                  });
                },
                child: Text("Stop"),
              ),
              SizedBox(height: 20),
              Slider(
                min: 0,
                max: _duration.inSeconds.toDouble(),
                value: _position.inSeconds.toDouble(),
                onChanged: (value) => _seekAudio(Duration(seconds: value.toInt())),
              ),
              Text(
                "${_position.inMinutes}:${_position.inSeconds.remainder(60).toString().padLeft(2, '0')} / "
                    "${_duration.inMinutes}:${_duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _recorder.closeRecorder();
    _audioPlayer.dispose();
    super.dispose();
  }

// Future<void> _initRecorder() async {
//   await _recorder.openRecorder();
//   await Permission.microphone.request();
//   await Permission.storage.request();
// }
//
// Future<void> _startRecording() async {
//   Directory directory = await getApplicationDocumentsDirectory();
//   String filePath = "${directory.path}/audio_record.m4a";
//
//   setState(() {
//     _audioFilePath = filePath;
//   });
//
//   await _recorder.startRecorder(toFile: filePath);
//   setState(() {
//     isRecording = true;
//   });
// }
//
// Future<void> _stopRecording() async {
//   await _recorder.stopRecorder();
//   setState(() {
//     isRecording = false;
//   });
// }
//
// Future<void> _playAudio() async {
//   if (_audioFilePath == null) return;
//
//   await _audioPlayer.setFilePath(_audioFilePath!);
//   _audioPlayer.play();
//   setState(() {
//     isPlaying = true;
//   });
//
//   _audioPlayer.playerStateStream.listen((state) {
//     if (state.processingState == ProcessingState.completed) {
//       setState(() {
//         isPlaying = false;
//       });
//     }
//   });
// }
//
// Future<void> _stopAudio() async {
//   await _audioPlayer.stop();
//   setState(() {
//     isPlaying = false;
//   });
// }

}
