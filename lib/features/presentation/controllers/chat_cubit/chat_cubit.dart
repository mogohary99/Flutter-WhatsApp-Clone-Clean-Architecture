import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/messge_type.dart';
import '../../../../core/shared/message_replay.dart';
import '../../../domain/entities/contact_chat.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/usecases/chat/get_chat_messages_usecase.dart';
import '../../../domain/usecases/chat/get_contacts_chat_usecase.dart';
import '../../../domain/usecases/chat/get_num_of_message_not_seen_usecase.dart';
import '../../../domain/usecases/chat/send_file_message_usecase.dart';
import '../../../domain/usecases/chat/send_gif_message_usecase.dart';
import '../../../domain/usecases/chat/send_text_message_usecase.dart';
import '../../../domain/usecases/chat/set_chat_message_seen_usecase.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SendTextMessageUseCase _sendTextMessageUseCase;
  final GetContactsChatUseCase _getContactsChatUseCase;
  final GetChatMessagesUseCase _getChatMessagesUseCase;
  final SetChatMessageSeenUseCase _setChatMessageSeenUseCase;
  final SendGifMessageUseCase _sendGifMessageUseCase;
  final SendFileMessageUseCase _sendFileMessageUseCase;
  final GetNumberOfMessageNotSeenUseCase _getNumberOfMessageNotSeenUseCase;

  // final GetContactNameUseCase _getContactNameUseCase;

  ChatCubit(
    this._sendTextMessageUseCase,
    this._getContactsChatUseCase,
    this._getChatMessagesUseCase,
    this._setChatMessageSeenUseCase,
    this._sendGifMessageUseCase,
    this._sendFileMessageUseCase,
    this._getNumberOfMessageNotSeenUseCase,
  ) : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

  MessageReplay? messageReplay;

  void onMessageSwipe({
    required String message,
    required bool isMe,
    required MessageType messageType,
    required String repliedTo,
  }) {
    emit(MessageSwipeLoadingState());
    messageReplay = MessageReplay(
      message: message,
      isMe: isMe,
      messageType: messageType,
      repliedTo: repliedTo,
    );
    emit(MessageSwipeState());
  }

  void cancelReplay() {
    messageReplay = null;
    emit(CancelReplayState());
  }

  //////////////////////////////////////////////////////////////
  ///sending messages
  Future<void> sendTextMessage({
    required String text,
    required String receiverId,
  }) async {
    emit(SendMessageLoadingState());
    final result = await _sendTextMessageUseCase(
      TextMessageParameters(
        text: text,
        receiverId: receiverId,
        messageReplay: messageReplay,
      ),
    );
    messageReplay = null;
    result.fold(
      (l) => emit(SendMessageErrorState()),
      (r) => emit(SendMessageSuccessState()),
    );
  }

  Future<void> sendGifMessage({
    required String receiverId,
    required String gifUrl,
  }) async {
    final result = await _sendGifMessageUseCase(
      GifMessageParameters(
        receiverId: receiverId,
        gifUrl: gifUrl,
        messageReplay: messageReplay,
      ),
    );
    messageReplay = null;
    result.fold(
      (l) => emit(SendMessageErrorState()),
      (r) => emit(SendMessageSuccessState()),
    );
  }

  Future<void> sendFileMessage({
    required String receiverId,
    required MessageType messageType,
    required File file,
  }) async {
    final result = await _sendFileMessageUseCase(
      FileMessageParameters(
        receiverId: receiverId,
        messageType: messageType,
        file: file,
        messageReplay: messageReplay,
      ),
    );
    messageReplay = null;
    result.fold(
      (l) => emit(SendMessageErrorState()),
      (r) => emit(SendMessageSuccessState()),
    );
  }

  //////////////////////////////////////////////////////////////

  ///get messages
  Stream<List<ContactChat>> getContactsChat(Map<String, dynamic> map) {
    return _getContactsChatUseCase(map);
  }

  Stream<List<Message>> getChatMessages(String receiverId) {
    return _getChatMessagesUseCase(
      GetChatMessagesParameters(
        receiverId: receiverId,
      ),
    );
  }

  //////////////////////////////////////////////////////////////

  ///set message seen
  Future<void> setChatMessageSeen({
    required String receiverId,
    required String messageId,
  }) async {
    final result = await _setChatMessageSeenUseCase(
      SetChatMessageSeenParameters(
        receiverId: receiverId,
        messageId: messageId,
      ),
    );
    result.fold(
      (l) => null,
      (r) => null,
    );
  }

  ///get num of messages not seen
  Stream<int> numOfMessageNotSeen(String senderId) =>
      _getNumberOfMessageNotSeenUseCase(senderId);
}
