import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_flutter_clone/core/extensions/extensions.dart';

import '../../../../../../core/functions/navigator.dart';
import '../../../../../../core/shared/message_replay.dart';
import '../../../../../../core/utils/constants/font_manager.dart';
import '../../../../../../core/utils/routes/routes_manager.dart';
import '../../../../controllers/chat_cubit/chat_cubit.dart';
import 'attchment_pop_up.dart';
import '../message/message_replay_preview.dart';

class BottomChatField extends StatelessWidget {
  final TextEditingController messageController;
  final FocusNode focusNode;
  final Function(String) onTextFieldValueChanged;
  final bool isShowEmoji;
  final VoidCallback toggleEmojiKeyboard;
  final String receiverId;

  const BottomChatField({
    super.key,
    required this.messageController,
    required this.focusNode,
    required this.onTextFieldValueChanged,
    required this.isShowEmoji,
    required this.toggleEmojiKeyboard,
    required this.receiverId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 65,
      margin: const EdgeInsets.only(
        right: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        children: [
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              MessageReplay? messageReplay =
                  ChatCubit.get(context).messageReplay;
              if (messageReplay == null) {
                return const SizedBox();
              }
              return MessageReplayPreview(
                messageReplay: messageReplay,
              );
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 35,
                child: IconButton(
                  onPressed: toggleEmojiKeyboard,
                  color: Colors.grey,
                  iconSize: 25,
                  icon: Icon(
                    isShowEmoji
                        ? Icons.keyboard
                        : Icons.emoji_emotions_outlined,
                  ),
                ),
              ),
              Flexible(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: double.infinity,
                    maxWidth: double.infinity,
                    minHeight: 25,
                    maxHeight: 135,
                  ),
                  child: Scrollbar(
                    child: TextField(
                      onChanged: onTextFieldValueChanged,
                      /*
                      onChanged: (val) {
                        if (val.isNotEmpty) {
                          setState(() {
                            isShownSendButton = true;
                          });
                        } else {
                          setState(() {
                            isShownSendButton = false;
                          });
                        }
                      },

                       */
                      controller: messageController,
                      cursorColor: context.colorScheme.secondary,
                      focusNode: focusNode,
                      cursorHeight: 30,
                      cursorWidth: 3,
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      style: TextStyle(
                        fontSize: 20,
                        //color: AppColors.blackLight,
                        color: context.colorScheme.onTertiaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Message',
                        hintStyle: TextStyle(
                          color: Colors.grey,
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
              ),
              const AttchementPopUp(),
              if (messageController.text.isEmpty)
                IconButton(
                  onPressed: () {
                    navigateTo(context, Routes.cameraRoute, arguments: {
                      'uId': receiverId,
                    });
                  },
                  color: Colors.grey,
                  iconSize: 26,
                  icon: const Icon(Icons.camera_alt_rounded),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
