import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../domain/entities/contact_chat.dart';
import '../../domain/entities/message.dart';
import '../../domain/repository/base_chat_repository.dart';
import '../../domain/usecases/chat/get_chat_messages_usecase.dart';
import '../../domain/usecases/chat/send_file_message_usecase.dart';
import '../../domain/usecases/chat/send_gif_message_usecase.dart';
import '../../domain/usecases/chat/send_text_message_usecase.dart';
import '../../domain/usecases/chat/set_chat_message_seen_usecase.dart';
import '../data_source/chat/remote/chat_remote_data_source.dart';

class ChatRepository extends BaseChatRepository {
  final BaseChatRemoteDataSource _remoteDataSource;
  //final BaseSelectContactRepository _selectContactRepository;

  ChatRepository(this._remoteDataSource);

  @override
  Stream<List<Message>> getChatMessages(GetChatMessagesParameters parameters) {
   return _remoteDataSource.getChatMessages(parameters);
  }

  @override
  Stream<List<ContactChat>> getContactsChat(Map<String,dynamic> map) {
    return  _remoteDataSource.getContactsChat(map);
  }

  @override
  Future<Either<Failure, void>> sendFileMessage(FileMessageParameters parameters)async {
    final result = await _remoteDataSource.sendFileMessage(parameters);
    try{
      return Right(result);
    }on FirebaseException catch(failure){
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> sendTextMessage(TextMessageParameters parameters) async {
    final result = await _remoteDataSource.sendTextMessage(parameters);
    try{
      return Right(result);
    }on FirebaseException catch(failure){
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> setChatMessageSeen(SetChatMessageSeenParameters parameters)async {
    final result = await _remoteDataSource.setChatMessageSeen(parameters);
    try{
      return Right(result);
    }on FirebaseException catch(failure){
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> sendGifMessage(GifMessageParameters parameters)async {

    final result = await _remoteDataSource.sendGifMessage(parameters);
    try{
      return Right(result);
    }on FirebaseException catch(failure){
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    return _remoteDataSource.getNumOfMessageNotSeen(senderId);
  }
}
