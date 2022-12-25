
import '../../../../core/usecase/base_use_case.dart';
import '../../repository/base_chat_repository.dart';

class GetNumberOfMessageNotSeenUseCase extends StreamBaseUseCase<int,String>{
  final BaseChatRepository _baseChatRepository;

  GetNumberOfMessageNotSeenUseCase(this._baseChatRepository);
  @override
  Stream<int> call(String parameters) {
    return _baseChatRepository.getNumOfMessageNotSeen(parameters);
  }
}