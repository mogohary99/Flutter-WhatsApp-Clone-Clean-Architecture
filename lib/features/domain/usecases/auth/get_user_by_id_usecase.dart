import '../../../../core/usecase/base_use_case.dart';
import '../../entities/user.dart';
import '../../repository/base_auth_repository.dart';

class GetUserByIdUseCase extends StreamBaseUseCase<UserEntity, String> {
  final BaseAuthRepository _baseAuthRepository;

  GetUserByIdUseCase(this._baseAuthRepository);

  @override
  Stream<UserEntity> call(String parameters) {
    return _baseAuthRepository.getUserById(parameters);
  }
}
