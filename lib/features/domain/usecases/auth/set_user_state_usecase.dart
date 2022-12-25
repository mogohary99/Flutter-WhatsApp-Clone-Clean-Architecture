import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../../repository/base_auth_repository.dart';

class SetUserStateUseCase extends BaseUseCase<void , bool>{
  final BaseAuthRepository _baseAuthRepository;

  SetUserStateUseCase(this._baseAuthRepository);
  @override
  Future<Either<Failure, void>> call(bool parameters) async{
    return await _baseAuthRepository.setUserState(parameters);
  }

}