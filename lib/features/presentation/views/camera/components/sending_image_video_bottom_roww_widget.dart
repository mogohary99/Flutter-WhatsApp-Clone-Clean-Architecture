import 'package:flutter/material.dart';

import '/core/extensions/extensions.dart';
import '../../../../../core/utils/constants/font_manager.dart';

class SendingImageVideoBottomRowWidget extends StatelessWidget {
  const SendingImageVideoBottomRowWidget({
  super.key, required this.onSendButtonTaped,
  });

  final VoidCallback onSendButtonTaped;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0XFF1F2C34),
              borderRadius: BorderRadius.circular(26),
            ),
            child: TextField(
              // controller: _messageController,
              cursorColor: context.colorScheme.secondary,
              // focusNode: focusNode,
              cursorHeight: 30,
              cursorWidth: 3,
              maxLines: null,
              textInputAction: TextInputAction.done,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              textAlignVertical: TextAlignVertical.bottom,
              decoration: const InputDecoration(
                filled: true,
                //fillColor: Colors,
                hintText: 'Add caption...',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeightManager.regular,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: context.colorScheme.secondary,
            child: GestureDetector(
              onTap: onSendButtonTaped,
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
