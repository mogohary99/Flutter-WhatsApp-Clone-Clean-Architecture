import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../../repository/base_auth_repository.dart';

class VerifyOtpUseCase extends BaseUseCase<void, VerifyOtpParameters> {
  final BaseAuthRepository baseFirebaseRepository;

  VerifyOtpUseCase(this.baseFirebaseRepository);

  @override
  Future<Either<Failure, void>> call(VerifyOtpParameters parameters)async {
    return await baseFirebaseRepository.verifyOtp(parameters);
  }
}

class VerifyOtpParameters extends Equatable {
  final String smsOtpCode;

  const VerifyOtpParameters({required this.smsOtpCode});

  @override
  List<Object> get props => [smsOtpCode];

}