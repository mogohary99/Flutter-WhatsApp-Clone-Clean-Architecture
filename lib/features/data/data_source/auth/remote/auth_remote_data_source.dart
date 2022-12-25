import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/utils/constants/strings_manager.dart';
import '../../../../domain/usecases/auth/sign_in_with_phone_number_usecase.dart';
import '../../../../domain/usecases/auth/verify_otp_usecase.dart';
import '../../../../domain/usecases/auth/save_userdata_to_firebase_usecase.dart';
import '../../../models/user_model.dart';

abstract class BaseAuthRemoteDataSource {
  Future<void> signInWithPhoneNumber(
      SignInWithPhoneNumberParameters parameters);

  Future<void> verifyOtp(VerifyOtpParameters parameters);

  Future<void> saveUserDataToFirebase(UserDataParameters parameters);

  Future<String> getCurrentUid();

  Future<void> signOut();

  Future<UserModel> getCurrentUser();

  Stream<UserModel> getUserById(String uId);

  Future<void> setUserState(bool isOnline);
  Future<void> updateProfilePic(String path);
}

class AuthRemoteDataSource extends BaseAuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;

  String _verificationId = '';

  AuthRemoteDataSource({
    required this.auth,
    required this.firestore,
    required this.firebaseStorage,
  });

  @override
  Future<String> getCurrentUid() async => auth.currentUser!.uid;

  @override
  Future<void> signOut() async => await auth.signOut();

  @override
  Future<void> signInWithPhoneNumber(
      SignInWithPhoneNumberParameters parameters) async {
    await auth.verifyPhoneNumber(
      phoneNumber: parameters.phoneNumber,
      verificationCompleted: (AuthCredential credential) async {
        await auth.signInWithCredential(credential);
        if (kDebugMode) {
          print("phone verified : Token ${credential.token}");
        }
      },
      verificationFailed: (e) {
        throw Exception(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        //_verificationId = verificationId;
        if (kDebugMode) {
          print("time out :$verificationId");
        }
      },
      timeout: const Duration(minutes: 1),
    );
  }

  @override
  Future<void> verifyOtp(VerifyOtpParameters parameters) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: parameters.smsOtpCode,
    );
    await auth.signInWithCredential(credential);
  }

  @override
  Future<void> saveUserDataToFirebase(UserDataParameters parameters) async {
    String uId = await getCurrentUid();

    String photoUrl = '';
    if (parameters.profilePic != null) {
      photoUrl = await _storeFileToFirebase(
        'profilePic/$uId',
        parameters.profilePic!,
      );
    }

    var user = UserModel(
      name: parameters.name,
      uId: uId,
      status: AppStrings.heyThere,
      profilePic: photoUrl,
      phoneNumber: auth.currentUser!.phoneNumber!,
      isOnline: true,
      groupId: const [],
      lastSeen: DateTime.now(),
    );
    var userDoc = await firestore.collection('users').doc(uId).get();
    if (userDoc.exists) {
      await firestore.collection('users').doc(uId).update(user.toMap());
    } else {
      await firestore.collection('users').doc(uId).set(user.toMap());
    }
  }

  Future<String> _storeFileToFirebase(String path, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(path).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> _deleteFileFromFirebase(String path)async{
    return await firebaseStorage.refFromURL(path).delete();
  }

  @override
  Future<UserModel> getCurrentUser() async {
    var userData =
        await firestore.collection('users').doc(await getCurrentUid()).get();
    UserModel user = UserModel.fromMap(userData.data()!);
    return user;
  }

  @override
  Stream<UserModel> getUserById(String uId) {
    print('doneee');
    return firestore.collection('users').doc(uId).snapshots().map(
          (event){
            return UserModel.fromMap(event.data()!);
          },
        );
  }

  @override
  Future<void> setUserState(bool isOnline) async {
    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      'isOnline': isOnline,
      'lastSeen': DateTime.now().millisecondsSinceEpoch,
    });
  }

  @override
  Future<void> updateProfilePic(String path)async {
    String uId = auth.currentUser!.uid;
    //firstly delete previus image
    var userData = await firestore.collection('users').doc(uId).get();
    UserModel user = UserModel.fromMap(userData.data()!);
    if(user.profilePic.isNotEmpty){
      await _deleteFileFromFirebase(user.profilePic);
    }
    //then upload new image
    String photoUrl = await _storeFileToFirebase(
      'profilePic/$uId',
      File(path),
    );
    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      'profilePic': photoUrl,
    });
  }
}
