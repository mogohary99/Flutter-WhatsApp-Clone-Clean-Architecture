import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../../entities/contact_chat.dart';
import '../../repository/base_chat_repository.dart';

class GetContactsChatUseCase extends StreamBaseUseCase<List<ContactChat>,Map<String,dynamic> >{
  final BaseChatRepository _baseChatRepository;

  GetContactsChatUseCase(this._baseChatRepository);
  @override
  Stream<List<ContactChat>> call(Map<String,dynamic>  parameters) {
    return _baseChatRepository.getContactsChat(parameters);
  }
}