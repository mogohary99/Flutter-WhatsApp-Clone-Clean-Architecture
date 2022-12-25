import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_flutter_clone/core/error/failure.dart';
import 'package:whatsapp_flutter_clone/core/shared/message_replay.dart';
import 'package:whatsapp_flutter_clone/features/domain/repository/base_chat_repository.dart';

import '../../../../core/usecase/base_use_case.dart';

class SendGifMessageUseCase extends BaseUseCase<void, GifMessageParameters> {
  final BaseChatRepository _baseChatRepository;

  SendGifMessageUseCase(this._baseChatRepository);

  @override
  Future<Either<Failure, void>> call(GifMessageParameters parameters) async {
    return await _baseChatRepository.sendGifMessage(parameters);
  }
}

class GifMessageParameters extends Equatable {
  final String receiverId;
  final String gifUrl;
  final MessageReplay? messageReplay;

  const GifMessageParameters({
    required this.receiverId,
    required this.gifUrl,
    this.messageReplay,
  });

  @override
  List<Object?> get props => [
        receiverId,
        gifUrl,
    messageReplay,
      ];
}
