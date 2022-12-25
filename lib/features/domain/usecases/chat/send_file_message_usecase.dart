import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_flutter_clone/core/enums/messge_type.dart';
import 'package:whatsapp_flutter_clone/core/error/failure.dart';
import 'package:whatsapp_flutter_clone/core/shared/message_replay.dart';
import 'package:whatsapp_flutter_clone/core/usecase/base_use_case.dart';
import 'package:whatsapp_flutter_clone/features/domain/repository/base_chat_repository.dart';

class SendFileMessageUseCase extends BaseUseCase<void, FileMessageParameters> {
  final BaseChatRepository _baseChatRepository;

  SendFileMessageUseCase(this._baseChatRepository);

  @override
  Future<Either<Failure, void>> call(FileMessageParameters parameters) async {
    return await _baseChatRepository.sendFileMessage(parameters);
  }
}

class FileMessageParameters extends Equatable {
  final String receiverId;
  final MessageType messageType;
  final File file;
  final MessageReplay? messageReplay;

  const FileMessageParameters({
    required this.receiverId,
    required this.messageType,
    required this.file,
    this.messageReplay,
  });

  @override
  List<Object?> get props => [
        receiverId,
        messageType,
        file,
    messageReplay,
      ];
}
