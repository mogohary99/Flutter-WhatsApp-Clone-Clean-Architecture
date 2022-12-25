import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../../repository/base_auth_repository.dart';

class GetCurrentUidUseCase extends BaseUseCase<String, NoParameters>{
  final BaseAuthRepository baseFirebaseRepository;

  GetCurrentUidUseCase(this.baseFirebaseRepository);
  @override
  Future<Either<Failure, String>> call(NoParameters parameters) async{
    return await baseFirebaseRepository.getCurrentUid();
  }

}