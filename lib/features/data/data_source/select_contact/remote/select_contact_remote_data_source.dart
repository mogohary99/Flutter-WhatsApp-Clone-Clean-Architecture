import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/contact.dart';

import '/features/data/models/user_model.dart';


abstract class BaseSelectContactsRemoteDataSource {
  Future<void> getAllContacts(List<Contact> contacts);

  Future<Map<String, dynamic>> contactsOnWhatsApp();

  Future<List<Contact>> contactsNotOnWhatsApp();

// Future<String> getContactName(ContactNameParameters parameters);
}

class SelectContactsRemoteDataSource
    extends BaseSelectContactsRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth _auth;

  SelectContactsRemoteDataSource(this.firestore, this._auth);

  List<Contact> _contactsNotOnWhatsApp = [];

  Map<String, dynamic> contactsOnWhatsAppMap = {};

  @override
  Future<List<Contact>> contactsNotOnWhatsApp() async => _contactsNotOnWhatsApp;

  @override
  Future<Map<String, dynamic>> contactsOnWhatsApp() async =>
      contactsOnWhatsAppMap;

  @override
  Future<void> getAllContacts(List<Contact> contacts) async {
    _contactsNotOnWhatsApp = [];
    //contactsOnWhatsAppMap = {};
    Map<String, dynamic> allContacts;
    var userCollection = await firestore.collection('users').get();
    String phoneNum;
    bool numFound = false;
    for (int i = 0; i < contacts.length; i++) {
      numFound = false;
      phoneNum = contacts[i].phones.isNotEmpty
          ? contacts[i].phones[0].number.replaceAll(' ', '')
          : '';
    /*
      if (userCollection.docs
          .where((element) => element.data().containsValue(phoneNum))
          .isNotEmpty) {
        print(phoneNum);
      }
      */
      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        if (phoneNum == userData.phoneNumber &&
            userData.uId != _auth.currentUser!.uid) {
          contactsOnWhatsAppMap.addAll({
            userData.uId : {
              'uId': userData.uId,
              'profilePic': userData.profilePic,
              'status': userData.status,
              'name': contacts[i].displayName,
            }
          });
          numFound = true;
          break;
        }
      }
      if (!numFound) _contactsNotOnWhatsApp.add(contacts[i]);
    }
  }
/*
  @override
  Future<String> getContactName(ContactNameParameters parameters) async {
      if (contactsOnWhatsAppMap.containsKey(parameters.uId)) {
        return contactsOnWhatsAppMap[parameters.uId]['name'];
      }
    var user = await firestore.collection('users').doc(parameters.uId).get();
    var userData = UserModel.fromMap(user.data()!);
    return userData.phoneNumber;
  }

 */
}
