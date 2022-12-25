import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_chat_state.dart';

class BottomChatCubit extends Cubit<BottomChatState> {
  BottomChatCubit() : super(BottomChatInitial());

  static BottomChatCubit get(context) => BlocProvider.of(context);

  bool isShownSendButton = false;
  bool isShowEmoji = false;
  bool isRecording = false;

  void showEmojiContainer() {
    isShowEmoji = true;
    emit(ShowEmojiContainerState());
  }

  void hideEmojiContainer() {
    isShowEmoji = false;
    emit(HideEmojiContainerState());
  }

  void toggleEmojiKeyboard(FocusNode focusNode) {
    if (isShowEmoji) {
      hideEmojiContainer();
      focusNode.requestFocus();
    } else {
      focusNode.unfocus();
      showEmojiContainer();
    }
  }

  void onTextFieldValChanged(String val) {
    if (val.trim().isNotEmpty) {
      isShownSendButton = true;
      emit(IsShowSendButtonTrueState());
    } else {
      isShownSendButton = false;
      emit(IsShowSendButtonFalseState());
    }
  }
}
