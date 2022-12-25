import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '/core/extensions/extensions.dart';
import '/core/extensions/time_extension.dart';
import '../../../../../../core/functions/date_converter.dart';
import '../../../../../domain/entities/message.dart';
import '../../../../controllers/chat_cubit/chat_cubit.dart';
import 'sender_message_card.dart';
import 'my_message_card.dart';

class MessagesList extends StatefulWidget {
  final String receiverId;

  const MessagesList({
    super.key,
    required this.receiverId,
  });

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  late ScrollController messageController = ScrollController();


  void scrollToBottom() {
    final bottomOffset = messageController.position.maxScrollExtent;
    messageController.animateTo(
      bottomOffset,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isFirst = false;
    return Expanded(
      child: StreamBuilder<List<Message>>(
        stream: ChatCubit.get(context).getChatMessages(widget.receiverId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          //to scroll  to bottom
          SchedulerBinding.instance.addPostFrameCallback((_) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });
          return ListView.builder(
            controller: messageController,
            itemCount: snapshot.data?.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 5),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              var message = snapshot.data![index];
              ////////////////////////////////////////////
              isFirst = false;
              var priviesMessage =
                  (index > 0) ? snapshot.data![index - 1] : null;
              //check to make message small bubble for first message
              if (index == 0 ||
                  message.senderId != priviesMessage!.senderId ||
                  !message.timeSent.isSameDay(priviesMessage.timeSent)) {
                isFirst = true;
              }
              /////////////////////////////////////////////
              //set chat message seen
              if (!message.isSeen &&
                  message.receiverId != widget.receiverId) {
                ChatCubit.get(context).setChatMessageSeen(
                  receiverId: widget.receiverId,
                  messageId: message.messageId,
                );
              }
              return Column(
                children: [
                  if (index == 0 ||
                      !DateConverter.isSameDay(
                        message.timeSent,
                        snapshot.data![index - 1].timeSent,
                      ))
                    ChatTimeCard(dateTime: message.timeSent),
                  if (message.receiverId == widget.receiverId)
                    MyMessageCard(
                      message: message,
                      isFirst: isFirst,
                    ),
                  if (message.receiverId != widget.receiverId)
                    SenderMessageCard(
                      message: message,
                      isFirst: isFirst,
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class ChatTimeCard extends StatelessWidget {
  final DateTime dateTime;

  const ChatTimeCard({
    super.key,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        margin: const EdgeInsets.all(5),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8,),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          dateTime.chatDayTime,
          style: context.displaySmall,
        ),
      ),
    );
  }
}
