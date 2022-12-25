import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_flutter_clone/core/error/failure.dart';
import 'package:whatsapp_flutter_clone/core/usecase/base_use_case.dart';
import 'package:whatsapp_flutter_clone/features/domain/repository/base_chat_repository.dart';

class SetChatMessageSeenUseCase extends BaseUseCase<void,SetChatMessageSeenParameters>{
  final BaseChatRepository _baseChatRepository;

  SetChatMessageSeenUseCase(this._baseChatRepository);
  @override
  Future<Either<Failure, void>> call(SetChatMessageSeenParameters parameters)async {
    return await _baseChatRepository.setChatMessageSeen(parameters);
  }

}

class SetChatMessageSeenParameters extends Equatable{
  final String receiverId;
  final String messageId;

  const SetChatMessageSeenParameters({required this.receiverId, required this.messageId});

  @override
  List<Object?> get props => [receiverId,messageId,];
}