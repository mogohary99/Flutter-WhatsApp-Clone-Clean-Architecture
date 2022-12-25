import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_flutter_clone/core/shared/message_replay.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../../repository/base_chat_repository.dart';

class SendTextMessageUseCase extends BaseUseCase<void, TextMessageParameters> {
  final BaseChatRepository _baseChatRepository;

  SendTextMessageUseCase(this._baseChatRepository);

  @override
  Future<Either<Failure, void>> call(TextMessageParameters parameters) async {
    return await _baseChatRepository.sendTextMessage(parameters);
  }
}

class TextMessageParameters extends Equatable {
  final String text;
  final String receiverId;
  final MessageReplay? messageReplay;

  //final UserModel senderUser;

  const TextMessageParameters({
    required this.receiverId,
    required this.text,
    this.messageReplay,
  });

  @override
  List<Object?> get props => [
        text,
        receiverId,
        messageReplay,
        //senderUser,
      ];
}
