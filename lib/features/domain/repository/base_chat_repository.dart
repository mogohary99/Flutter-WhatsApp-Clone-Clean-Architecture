import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../entities/contact_chat.dart';
import '../entities/message.dart';
import '../usecases/chat/get_chat_messages_usecase.dart';
import '../usecases/chat/send_file_message_usecase.dart';
import '../usecases/chat/send_gif_message_usecase.dart';
import '../usecases/chat/send_text_message_usecase.dart';
import '../usecases/chat/set_chat_message_seen_usecase.dart';

abstract class BaseChatRepository{
  Future<Either<Failure,void>> sendTextMessage(TextMessageParameters parameters);
  Future<Either<Failure,void>> sendFileMessage(FileMessageParameters parameters);
  Future<Either<Failure,void>> sendGifMessage(GifMessageParameters parameters);
  Stream<List<ContactChat>> getContactsChat(Map<String,dynamic> map);
  Stream<List<Message>> getChatMessages(GetChatMessagesParameters parameters);
  Future<Either<Failure,void>> setChatMessageSeen(SetChatMessageSeenParameters parameters);
  Stream<int> getNumOfMessageNotSeen(String senderId);
}