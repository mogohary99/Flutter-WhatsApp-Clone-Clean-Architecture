import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter_clone/features/presentation/views/chat/components/message_content/time_sent_widget.dart';

import '../../../../../domain/entities/message.dart';

class VideoPlayerItem extends StatefulWidget {
  final Message message;
  final bool isMe;

  const VideoPlayerItem({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late CachedVideoPlayerController videoPlayerController;
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    videoPlayerController =
        CachedVideoPlayerController.network(widget.message.text)
          ..initialize().then((value) {
            videoPlayerController.setVolume(1);
          });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            children: [
              CachedVideoPlayer(videoPlayerController),
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () {
                    if (isPlay) {
                      videoPlayerController.pause();
                    } else {
                      videoPlayerController.play();
                    }
                    setState(() {
                      isPlay = !isPlay;
                    });
                  },
                  icon: Icon(
                    isPlay ? Icons.pause_circle : Icons.play_circle,
                    size: 40,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 4,
                child: TimeSentWidget(
                  message: widget.message,
                  isMe: widget.isMe,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
