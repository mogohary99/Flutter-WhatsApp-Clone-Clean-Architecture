import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

import '/core/extensions/extensions.dart';
import '../../../../../domain/entities/message.dart';
import '../../../../controllers/chat_cubit/chat_cubit.dart';
import 'first_message_small_curved_bubble.dart';
import '../message_content/message_content.dart';
import 'message_replay_card.dart';

class MyMessageCard extends StatelessWidget {
  final Message message;
  final bool isFirst;

  const MyMessageCard({
    super.key,
    required this.message,
    required this.isFirst,
  });

  @override
  Widget build(BuildContext context) {
    final isReplying = message.repliedMessage.isNotEmpty;
    return SwipeTo(
      onRightSwipe: () {
        ChatCubit.get(context).onMessageSwipe(
          message: message.text,
          isMe: true,
          messageType: message.messageType,
          repliedTo: message.senderName,
        );
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(top: 5, right: isFirst ? 5 : 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: context.width(0.8),
                  maxHeight: 400,
                ),
                child: Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(0),
                  color: context.colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(10),
                      bottomLeft: const Radius.circular(10),
                      bottomRight: const Radius.circular(10),
                      topRight:
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
                            isMe: message.repliedTo == message.senderName,
                            repliedTo: message.repliedTo,
                          ),
                        ),
                      MessageContent(
                        message: message,
                        isMe: true,
                      ),
                    ],
                  ),
                ),
              ),
              if (isFirst)
                const FirstMessageSmallCurvedBubble(
                  isMe: true,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
