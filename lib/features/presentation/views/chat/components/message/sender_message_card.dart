import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../../../../core/extensions/extensions.dart';
import '../../../../../domain/entities/message.dart';
import '../../../../controllers/chat_cubit/chat_cubit.dart';
import '../message_content/message_content.dart';
import 'first_message_small_curved_bubble.dart';
import 'message_replay_card.dart';

class SenderMessageCard extends StatelessWidget {
  final Message message;
  final bool isFirst;

  const SenderMessageCard({
    super.key,
    required this.message,
    required this.isFirst,
  });

  @override
  Widget build(BuildContext context) {
    final isReplying = message.repliedMessage.isNotEmpty;
    return SwipeTo(
      onLeftSwipe: () {
        ChatCubit.get(context).onMessageSwipe(
          message: message.text,
          isMe: false,
          messageType: message.messageType,
          repliedTo: message.senderName,
        );
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(
            top: 2.5,
            left: isFirst ? 5 : 15,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (isFirst) const FirstMessageSmallCurvedBubble(isMe: false),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: context.width(0.8),
                  maxHeight: 400,
                ),
                child: Card(
                  elevation: 0,
                  margin: const EdgeInsets.all(0),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: const Radius.circular(10),
                      bottomLeft: const Radius.circular(10),
                      bottomRight: const Radius.circular(10),
                      topLeft:
                          isFirst ? Radius.zero : const Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (isReplying)
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ReplayMessageCard(
                            text: message.repliedMessage,
                            repliedMessageType: message.repliedMessageType,
                            isMe: message.repliedTo != message.senderName,
                            repliedTo: message.repliedTo,
                          ),
                        ),
                      MessageContent(message: message, isMe: false),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
