import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../../repository/base_auth_repository.dart';

class GetCachedLocalCurrentUidUseCase extends BaseUseCase<String , NoParameters>{
  final BaseAuthRepository baseFirebaseRepository;

  GetCachedLocalCurrentUidUseCase(this.baseFirebaseRepository);
  @override
  Future<Either<Failure, String>> call(NoParameters parameters)async {
    return await baseFirebaseRepository.getCachedLocalCurrentUid();
  }

}