import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../../repository/base_auth_repository.dart';

class SignOutUseCase extends BaseUseCase<void,NoParameters>{
  final BaseAuthRepository baseFirebaseRepository;

  SignOutUseCase(this.baseFirebaseRepository);
  @override
  Future<Either<Failure, void>> call(NoParameters parameters)async {
    return await baseFirebaseRepository.signOut();
  }

}