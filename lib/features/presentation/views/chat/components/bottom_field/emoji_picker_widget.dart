import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

import '/core/extensions/extensions.dart';


class EmojiPickerWidget extends StatelessWidget {
  final TextEditingController messageController;
  final VoidCallback onGifButtonTap;

  const EmojiPickerWidget({
    super.key,
    required this.onGifButtonTap,
    required this.messageController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          EmojiPicker(
            onEmojiSelected: (category, emoji) {
              //messageController.text = messageController.text + emoji.emoji;
            },
            onBackspacePressed: () {
              messageController.text.trimRight();
            },
            textEditingController: messageController,
            config: Config(
              columns: 8,
              iconColorSelected: context.colorScheme.secondary,
              indicatorColor: context.colorScheme.secondary,
              backspaceColor: Colors.black26,
            ),
          ),
          Container(
            height: 40,
            width: double.infinity,
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: onGifButtonTap,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    child: const Icon(
                      Icons.gif,
                      size: 30,
                      color: Colors.black26,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
