import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class BaseFirebaseStorageRemoteDataSource{
  Future<String> storeFileToFirebase(String path, File file);
}

class FirebaseStorageRemoteDataSource extends BaseFirebaseStorageRemoteDataSource{
  final FirebaseStorage firebaseStorage;

  FirebaseStorageRemoteDataSource(this.firebaseStorage);

  @override
  Future<String> storeFileToFirebase(String path, File file) async{
    UploadTask uploadTask =firebaseStorage.ref().child(path).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

}