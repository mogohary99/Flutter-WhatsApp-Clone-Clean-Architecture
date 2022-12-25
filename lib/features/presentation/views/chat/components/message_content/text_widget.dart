import 'package:flutter/material.dart';

import '/features/presentation/views/chat/components/message_content/time_sent_widget.dart';
import '/core/extensions/extensions.dart';
import '../../../../../domain/entities/message.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
  super.key,
  required this.message,
  required this.isMe,
  });

  final Message message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      alignment: WrapAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message.text,
            style: context.displaySmall,
            overflow: TextOverflow.visible,
          ),
        ),
        TimeSentWidget(
          message: message,
          isMe: isMe,
          textColor: Colors.grey,
        ),
      ],
    );
  }
}