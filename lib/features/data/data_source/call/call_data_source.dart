import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '/features/data/models/call_model.dart';

import '../../../domain/usecases/call/end_call_usecase.dart';
import '../../../domain/usecases/call/make_call_usecase.dart';
import '../../models/user_model.dart';

abstract class BaseCallDataSource {
  Future<void> makeCall(MakeCallParameters parameters);
  Future<void> endCall(EndCallParameters parameters);
  Stream<DocumentSnapshot> callStream();
}

class CallDataSource extends BaseCallDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  CallDataSource(this._firestore, this._auth);

  Future<UserModel> _currentUser() async {
    var userDataMap =
    await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
    UserModel user = UserModel.fromMap(userDataMap.data()!);
    return user;
  }

  @override
  Stream<DocumentSnapshot> callStream() =>
      _firestore.collection('call').doc(_auth.currentUser!.uid).snapshots();

  @override
  Future<void> endCall(EndCallParameters parameters) async {
    await _firestore.collection('call').doc(parameters.callerId).delete();
    await _firestore.collection('call').doc(parameters.receiverId).delete();
  }

  @override
  Future<void> makeCall(MakeCallParameters parameters)async {
    String callId = const Uuid().v1();
    UserModel currentUser = await _currentUser();
    CallModel senderCallData = CallModel(
      callerId: currentUser.uId,
      callerName: currentUser.name,
      callerPic: currentUser.profilePic,
      receiverId: parameters.receiverId,
      receiverName: parameters.receiverName,
      receiverPic: parameters.receiverPic,
      callId: callId,
      hasDialled: true,
    );

    CallModel receiverCallData = CallModel(
      callerId: currentUser.uId,
      callerName: currentUser.name,
      callerPic: currentUser.profilePic,
      receiverId: parameters.receiverId,
      receiverName: parameters.receiverName,
      receiverPic: parameters.receiverPic,
      callId: callId,
      hasDialled: false,
    );

    await _firestore
        .collection('call')
        .doc(senderCallData.callerId)
        .set(senderCallData.toMap());
    await _firestore
        .collection('call')
        .doc(senderCallData.receiverId)
        .set(receiverCallData.toMap());
  }
}
