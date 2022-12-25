import 'package:flutter/material.dart';

import '../../../../../../core/enums/messge_type.dart';
import '../../../../controllers/chat_cubit/chat_cubit.dart';

class ReplayMessageCard extends StatelessWidget {
  final bool showCloseButton;
  final MessageType repliedMessageType;
  final String text;
  final bool isMe;
  final String repliedTo;

  //final MessageReplay messageReplay;

  const ReplayMessageCard({
    super.key,
    this.showCloseButton = false,
    required this.repliedMessageType,
    required this.text,
    required this.isMe, required this.repliedTo,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        padding: const EdgeInsets.only(
          left: 10,
          right: 5,
          top: 5,
          bottom: 8,
        ),
        decoration: BoxDecoration(
          //color: Color(0xffF5F7F6),
          color: Colors.black.withOpacity(0.03),
          border: Border(
            left: BorderSide(
              color: isMe ? Colors.teal : Colors.deepPurple,
              width: 5,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    isMe ? 'You' : repliedTo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe ? Colors.teal : Colors.deepPurple,
                    ),
                  ),
                ),
                if (showCloseButton)
                  GestureDetector(
                    onTap: () {
                      ChatCubit.get(context).cancelReplay();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 16,
                    ),
                  )
              ],
            ),
            const SizedBox(height: 8),
            ReplayMessageContent(
              repliedMessageType: repliedMessageType,
              text: text,
            ),
          ],
        ),
      ),
    );
  }
}

class ReplayMessageContent extends StatelessWidget {
  //final MessageReplay messageReplay;
  final MessageType repliedMessageType;
  final String text;

  const ReplayMessageContent({
    super.key,
    required this.repliedMessageType,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    switch (repliedMessageType) {
      case MessageType.text:
        return Text(
          text,
          style: const TextStyle(color: Colors.black38, fontSize: 14),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        );
      case MessageType.image:
        return Row(
          children: const [
            Icon(Icons.image,color: Colors.black38,),
            SizedBox(width: 4,),
            Text(
              'Photo',
              style: TextStyle(color: Colors.black38, fontSize: 14),
            ),
          ],
        );
      case MessageType.gif:
        return Row(
          children: const [
            Icon(Icons.gif),
            Text(
              'GIF',
              style: TextStyle(color: Colors.black38, fontSize: 14),
            ),
          ],
        );
      case MessageType.video:
        return Row(
          children: const [
            Icon(Icons.videocam),
            Text(
              'Video',
              style: TextStyle(color: Colors.black38, fontSize: 14),
            ),
          ],
        );
      case MessageType.audio:
        return Row(
          children: const [
            Icon(
              Icons.mic,
              size: 18,
              color: Colors.black38,
            ),
            Text(
              'Voice message',
              style: TextStyle(color: Colors.black38, fontSize: 14),
            ),
          ],
        );
      default:
        return Text(
          text,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        );
    }
  }
}
