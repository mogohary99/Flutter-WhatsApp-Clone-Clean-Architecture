import 'package:flutter/material.dart';

import '/core/extensions/extensions.dart';
import '/core/extensions/time_extension.dart';
import '../../../../../domain/entities/message.dart';

class TimeSentWidget extends StatelessWidget {
  const TimeSentWidget({
  super.key,
  required this.message,
  required this.isMe,
  required this.textColor,
  });

  final Message message;
  final bool isMe;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4, bottom: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message.timeSent.amPmMode,
            style:  TextStyle(
              fontSize: 13,
              color: textColor,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          if (isMe)
            Icon(
              Icons.done_all,
              size: 20,
              color: message.isSeen ? context.colorScheme.onTertiary : textColor,
            ),
        ],
      ),
    );
  }
}