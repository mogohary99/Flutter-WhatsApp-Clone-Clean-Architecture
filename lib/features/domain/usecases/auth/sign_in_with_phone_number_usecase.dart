import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../../repository/base_auth_repository.dart';

class SignInWithPhoneNumberUseCase extends BaseUseCase<void, SignInWithPhoneNumberParameters> {
  final BaseAuthRepository baseFirebaseRepository;

  SignInWithPhoneNumberUseCase(this.baseFirebaseRepository);
  @override
  Future<Either<Failure, void>> call(SignInWithPhoneNumberParameters parameters) async{
   return await baseFirebaseRepository.signInWithPhoneNumber(parameters);
  }

}

class SignInWithPhoneNumberParameters extends Equatable {
  final String phoneNumber;

  const SignInWithPhoneNumberParameters({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}