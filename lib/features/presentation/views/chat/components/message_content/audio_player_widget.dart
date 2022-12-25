import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter_clone/core/utils/constants/assets_manager.dart';
import 'package:whatsapp_flutter_clone/features/domain/entities/message.dart';
import 'package:whatsapp_flutter_clone/features/presentation/views/chat/components/message_content/time_sent_widget.dart';

class AudioPlayerWidget extends StatefulWidget {
  final Message message;
  final bool isMe;

  const AudioPlayerWidget({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration? totalDuration;
  Duration? newTiming;

  bool isPlaying = false;

  void initAudio() {
    debugPrint("Audio Initialized");
    audioPlayer.play(UrlSource(widget.message.text));
    audioPlayer.getDuration().then((value) {
      debugPrint(value.toString());
    });
    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        newTiming = event;
      });
    });
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      totalDuration = updatedDuration;
    });
  }

  void pauseAudio() {
    audioPlayer.pause();
  }

 void stopAudio() {
    audioPlayer.stop();
  }

  void seekAudio(Duration durationToSeek) {
    audioPlayer.seek(durationToSeek);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 55,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: Image.asset(AppImage.genericProfileImage,),
                ),
                const Positioned(
                  bottom: 0,
                  right: 0,
                  child: Icon(
                    Icons.mic,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (isPlaying) {
                pauseAudio();
                setState(() {
                  isPlaying = !isPlaying;
                });
              } else {
                if (newTiming.toString() == "null") {
                  initAudio();
                } else {
                  audioPlayer.resume();
                }
                setState(() {
                  isPlaying = !isPlaying;
                });
              }
            },
            child: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow_rounded,
              size: 40,
              color: Colors.black54,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 35,
                  child: Slider(
                    value: newTiming == null
                        ? 0
                        : newTiming!.inMilliseconds.toDouble(),
                    min: 0,
                    max: totalDuration == null
                        ? 20
                        : totalDuration!.inMilliseconds.toDouble(),
                    activeColor: Colors.grey,

                    inactiveColor: Colors.black38,
                    onChanged: (value) {
                      setState(() {
                        seekAudio(Duration(milliseconds: value.toInt()));
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (newTiming.toString() == "null")
                          ? "0:00"
                          : newTiming.toString().split('.').first,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    TimeSentWidget(
                        message: widget.message,
                        isMe: widget.isMe,
                        textColor: Colors.grey)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
