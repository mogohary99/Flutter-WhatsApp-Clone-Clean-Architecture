import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/base_use_case.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/auth/get_cached_local_current_uid_usecase.dart';
import '../../../domain/usecases/auth/get_current_user_usecase.dart';
import '../../../domain/usecases/auth/get_user_by_id_usecase.dart';
import '../../../domain/usecases/auth/save_userdata_to_firebase_usecase.dart';
import '../../../domain/usecases/auth/set_user_state_usecase.dart';
import '../../../domain/usecases/auth/signout_usecase.dart';
import '../../../domain/usecases/auth/sign_in_with_phone_number_usecase.dart';
import '../../../domain/usecases/auth/update_profile_pic_usecase.dart';
import '../../../domain/usecases/auth/verify_otp_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInWithPhoneNumberUseCase _signInWithPhoneNumberUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final SaveUserDataToFirebaseUseCase _saveUserDataToFirebaseUseCase;
  final SignOutUseCase _signOutUseCase;
  final GetCachedLocalCurrentUidUseCase _cachedLocalCurrentUid;
  final GetUserByIdUseCase _getUserByIdUseCase;
  final SetUserStateUseCase _setUserStateUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final UpdateProfilePicUseCase _updateProfilePicUseCase;

  AuthCubit(
    this._signInWithPhoneNumberUseCase,
    this._verifyOtpUseCase,
    this._saveUserDataToFirebaseUseCase,
    this._signOutUseCase,
    this._cachedLocalCurrentUid,
    this._getUserByIdUseCase,
    this._setUserStateUseCase,
    this._getCurrentUserUseCase,
    this._updateProfilePicUseCase,
  ) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  Country? country;

  void setCountry(Country myCountry) {
    country = myCountry;
    emit(SetCountrySuccessState());
  }

  Future<void> signInWithPhoneNumber({required String phoneNumber}) async {
    emit(SignInLoadingState());
    final result = await _signInWithPhoneNumberUseCase(
      SignInWithPhoneNumberParameters(
        phoneNumber: phoneNumber,
      ),
    );
    result.fold(
      (l) {
        emit(SignInErrorState());
      },
      (r) => emit(SignInSuccessState()),
    );
  }

  Future<void> verifyOtp({required String smsOtpCode}) async {
    emit(VerifyOtpLoadingState());
    final result = await _verifyOtpUseCase(
      VerifyOtpParameters(
        smsOtpCode: smsOtpCode,
      ),
    );
    result.fold(
      (l) => emit(VerifyOtpErrorState()),
      (r) => emit(VerifyOtpSuccessState()),
    );
  }

  Future<void> saveUserDataToFirebase({
    required String name,
    File? profilePic,
  }) async {
    emit(SaveUserDataToFirebaseLoadingState());
    final result = await _saveUserDataToFirebaseUseCase(UserDataParameters(
      name: name,
      profilePic: profilePic,
    ));
    result.fold(
      (l) => emit(SaveUserDataToFirebaseErrorState()),
      (r) => emit(SaveUserDataToFirebaseSuccessState()),
    );
  }

  Future<void> signOut() async {
    emit(SignOutLoadingState());
    final result = await _signOutUseCase(const NoParameters());
    result.fold(
      (l) => emit(SignOutErrorState()),
      (r) => emit(SignOutSuccessState()),
    );
  }

  UserEntity? userEntity;

  Future<void> getCurrentUser() async {
    emit(GetCurrentUserLoadingState());
    final result = await _getCurrentUserUseCase(const NoParameters());
    result.fold(
      (l) => emit(GetCurrentUserErrorState()),
      (r) {
        userEntity = r;
        emit(GetCurrentUserSuccessState());
      },
    );
  }

  Future<void> getCachedCurrentUid() async {
    final result = await _cachedLocalCurrentUid(const NoParameters());
    result.fold(
      (l) => emit(GetCurrentLocalErrorState()),
      (r) => emit(GetCurrentLocalSuccessState(r)),
    );
  }

  Stream<UserEntity> getUserById(String uId) {
    return _getUserByIdUseCase(uId);
  }

  Future<void> setUserState(bool isOnline) async {
    final result = await _setUserStateUseCase(isOnline);
    result.fold(
      (l) => emit(SetUserStateErrorState()),
      (r) => emit(SetUserStateSuccessState()),
    );
  }

  Future<void> updateProfilePic(String path) async {
    emit(UpdateProfilePicLoadingState());
    final result = await _updateProfilePicUseCase(path);
    result.fold(
      (l) => emit(UpdateProfilePicErrorState()),
      (r) => emit(UpdateProfilePicSuccessState()),
    );
  }
}
