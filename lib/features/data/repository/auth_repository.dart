import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/features/data/models/user_model.dart';
import '/features/domain/entities/user.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';
import '../../domain/repository/base_auth_repository.dart';
import '../../domain/usecases/auth/save_userdata_to_firebase_usecase.dart';
import '../../domain/usecases/auth/sign_in_with_phone_number_usecase.dart';
import '../../domain/usecases/auth/verify_otp_usecase.dart';
import '../data_source/auth/local/auth_local_data_source.dart';
import '../data_source/auth/remote/auth_remote_data_source.dart';

class AuthRepository extends BaseAuthRepository {
  final BaseAuthRemoteDataSource remoteDataSource;
  final BaseAuthLocalDataSource localDataSource;

  AuthRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, void>> signInWithPhoneNumber(
    SignInWithPhoneNumberParameters parameters,
  ) async {
    final result = await remoteDataSource.signInWithPhoneNumber(parameters);
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> verifyOtp(
      VerifyOtpParameters parameters) async {
    final result = await remoteDataSource.verifyOtp(parameters);
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserDataToFirebase(
      UserDataParameters parameters) async {
    final result = await remoteDataSource.saveUserDataToFirebase(parameters);
    localDataSource.setUserLoggedIn(await remoteDataSource.getCurrentUid());
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, String>> getCurrentUid() async {
    final result = await remoteDataSource.getCurrentUid();
    //final result = await _getUid();
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    final result = await remoteDataSource.signOut();
    await localDataSource.removeUser(localDataSource.getUser()!);
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, String>> getCachedLocalCurrentUid() async {
    final result = await localDataSource.getUser();
    try {
      return Right(result!);
    } on CachedException catch (failure) {
      return Left(CachedFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    final result = await remoteDataSource.getCurrentUser();
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> setUserState(bool isOnline) async {
    final result = await remoteDataSource.setUserState(isOnline);
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Stream<UserEntity> getUserById(String uId) {
    return remoteDataSource.getUserById(uId);
  }

  @override
  Future<Either<Failure, void>> updateProfilePic(String path) async {
    final result = await remoteDataSource.updateProfilePic(path);
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }
}
