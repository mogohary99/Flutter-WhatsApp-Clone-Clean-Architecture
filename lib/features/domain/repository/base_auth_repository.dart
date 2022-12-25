import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../entities/user.dart';
import '../usecases/auth/save_userdata_to_firebase_usecase.dart';
import '../usecases/auth/sign_in_with_phone_number_usecase.dart';
import '../usecases/auth/verify_otp_usecase.dart';

abstract class BaseAuthRepository{
  Future<Either<Failure, void>> signInWithPhoneNumber(SignInWithPhoneNumberParameters parameters);
  Future<Either<Failure, void>> verifyOtp(VerifyOtpParameters parameters);
  Future<Either<Failure,void>> saveUserDataToFirebase(UserDataParameters parameters);
  Future<Either<Failure,String>> getCurrentUid();
  Future<Either<Failure,String>> getCachedLocalCurrentUid();
  Future<Either<Failure,void>> signOut();
  Future<Either<Failure,UserEntity>> getCurrentUser();
  Stream<UserEntity> getUserById(String uId);
  Future<Either<Failure,void>> setUserState(bool isOnline);
  Future<Either<Failure,void>> updateProfilePic(String path);
}