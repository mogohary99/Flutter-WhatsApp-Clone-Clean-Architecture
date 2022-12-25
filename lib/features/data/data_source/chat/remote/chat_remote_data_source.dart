import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/enums/messge_type.dart';
import '../../../../../core/shared/message_replay.dart';
import '../../../../domain/usecases/chat/get_chat_messages_usecase.dart';
import '../../../../domain/usecases/chat/send_file_message_usecase.dart';
import '../../../../domain/usecases/chat/send_gif_message_usecase.dart';
import '../../../../domain/usecases/chat/send_text_message_usecase.dart';
import '../../../../domain/usecases/chat/set_chat_message_seen_usecase.dart';
import '../../../models/contact_chat_model.dart';
import '../../../models/message_model.dart';
import '../../../models/user_model.dart';

abstract class BaseChatRemoteDataSource {
  Future<void> sendTextMessage(TextMessageParameters parameters);

  Future<void> sendFileMessage(FileMessageParameters parameters);

  Future<void> sendGifMessage(GifMessageParameters parameters);

  Stream<List<MessageModel>> getChatMessages(
      GetChatMessagesParameters parameters);

  Stream<List<ContactChatModel>> getContactsChat(Map<String, dynamic> map);

  Future<void> setChatMessageSeen(SetChatMessageSeenParameters parameters);
  Stream<int> getNumOfMessageNotSeen(String senderId);
}

class ChatRemoteDataSource extends BaseChatRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final FirebaseStorage firebaseStorage;

  ChatRemoteDataSource(this._firestore, this._auth, this.firebaseStorage);

  Future<UserModel> _currentUser() async {
    var userDataMap =
        await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
    UserModel user = UserModel.fromMap(userDataMap.data()!);
    return user;
  }

  @override
  Future<void> sendTextMessage(TextMessageParameters parameters) async {
    UserModel receiverUserData;
    var timeSent = DateTime.now();
    var messageId = const Uuid().v1();
    var userDataMap =
        await _firestore.collection('users').doc(parameters.receiverId).get();
    receiverUserData = UserModel.fromMap(userDataMap.data()!);
    UserModel senderUser = await _currentUser();

    /// this is bad to call sender user here i will refactor it.
    _saveDataToContactsSubCollection(
      senderUser,
      receiverUserData,
      parameters.text,
      timeSent,
    );
    _saveMessageToMessageSubCollection(
      senderId: senderUser.uId,
      receiverId: parameters.receiverId,
      text: parameters.text,
      timeSent: timeSent,
      messageId: messageId,
      messageType: MessageType.text,
      messageReplay: parameters.messageReplay,
      senderUserName: senderUser.name,
    );
  }

  void _saveDataToContactsSubCollection(
    UserModel senderUserData,
    UserModel receiverUserData,
    String text,
    DateTime timeSent,
  ) async {
    // users -> receiver user id => chats -> current user id -> set data
    ContactChatModel receiverChatContact = ContactChatModel(
      name: senderUserData.name,
      profilePic: senderUserData.profilePic,
      contactId: senderUserData.uId,
      lastMessage: text,
      timeSent: timeSent,
      phoneNumber: senderUserData.phoneNumber,
    );
    await _firestore
        .collection('users')
        .doc(receiverUserData.uId)
        .collection('chats')
        .doc(senderUserData.uId)
        .set(receiverChatContact.toMAp());

    // users -> current user id => chats -> receiver user id -> set data
    ContactChatModel senderChatContact = ContactChatModel(
      name: receiverUserData.name,
      profilePic: receiverUserData.profilePic,
      contactId: receiverUserData.uId,
      lastMessage: text,
      timeSent: timeSent,
      phoneNumber: receiverUserData.phoneNumber,
    );
    await _firestore
        .collection('users')
        .doc(senderUserData.uId)
        .collection('chats')
        .doc(receiverUserData.uId)
        .set(senderChatContact.toMAp());
  }

  void _saveMessageToMessageSubCollection({
    required String senderId,
    required String receiverId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required MessageType messageType,
    required MessageReplay? messageReplay,
    required String senderUserName,
  }) async {
    MessageModel message = MessageModel(
      senderId: senderId,
      receiverId: receiverId,
      text: text,
      messageId: messageId,
      timeSent: timeSent,
      isSeen: false,
      messageType: messageType,
      repliedMessage: messageReplay == null ? '' : messageReplay.message,
      senderName: senderUserName,
      repliedTo: messageReplay == null
          ? ''
          : messageReplay.isMe
              ? senderUserName
              : messageReplay.repliedTo,
      repliedMessageType:
          messageReplay == null ? MessageType.text : messageReplay.messageType,
    );
    // users -> sender id -> chats -> receiver id -> messages ->message id ->store message
    await _firestore
        .collection('users')
        .doc(senderId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());
    // users -> receiver id -> chats -> sender id -> messages ->message id ->store message
    await _firestore
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(senderId)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());
  }

  @override
  Future<void> sendFileMessage(FileMessageParameters parameters) async {
    DateTime timeSent = DateTime.now();
    String messageId = const Uuid().v1();
    UserModel senderUser = await _currentUser();
    var fileUrl = await _storeFileToFirebase(
      'chat/${parameters.messageType.type}/${senderUser.uId}/${parameters.receiverId}/$messageId}',
      parameters.file,
    );
    UserModel receiverUserData;

    var userDataMap =
        await _firestore.collection('users').doc(parameters.receiverId).get();
    receiverUserData = UserModel.fromMap(userDataMap.data()!);

    String contactMessage;
    switch (parameters.messageType) {
      case MessageType.image:
        contactMessage = '📷 Photo';
        break;
      case MessageType.video:
        contactMessage = '🎥 Video';
        break;
      case MessageType.audio:
        contactMessage = '🎙️ Audio';
        break;
      case MessageType.gif:
        contactMessage = 'Gif';
        break;
      default:
        contactMessage = 'Other';
    }

    _saveDataToContactsSubCollection(
      senderUser,
      receiverUserData,
      contactMessage,
      timeSent,
    );
    _saveMessageToMessageSubCollection(
      senderId: senderUser.uId,
      receiverId: parameters.receiverId,
      text: fileUrl,
      timeSent: timeSent,
      messageId: messageId,
      messageType: parameters.messageType,
      messageReplay: parameters.messageReplay,
      senderUserName: senderUser.name
    );
  }

  Future<String> _storeFileToFirebase(String path, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(path).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Future<void> sendGifMessage(GifMessageParameters parameters) async {
    UserModel receiverUserData;
    var timeSent = DateTime.now();
    var messageId = const Uuid().v1();
    var userDataMap =
        await _firestore.collection('users').doc(parameters.receiverId).get();
    receiverUserData = UserModel.fromMap(userDataMap.data()!);
    UserModel senderUser = await _currentUser();
    _saveDataToContactsSubCollection(
      senderUser,
      receiverUserData,
      'Gif',
      timeSent,
    );
    _saveMessageToMessageSubCollection(
      senderId: senderUser.uId,
      receiverId: parameters.receiverId,
      text: parameters.gifUrl,
      timeSent: timeSent,
      messageId: messageId,
      messageType: MessageType.gif,
      senderUserName: senderUser.name,
      messageReplay: parameters.messageReplay
    );
  }

  @override
  Stream<List<MessageModel>> getChatMessages(
      GetChatMessagesParameters parameters) {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('chats')
        .doc(parameters.receiverId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<MessageModel> messages = [];
      for (var document in event.docs) {
        messages.add(MessageModel.fromMap(document.data()));
      }
      return messages;
    });
  }

  @override
  Stream<List<ContactChatModel>> getContactsChat(Map<String, dynamic> map) {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('chats')
        .orderBy('timeSent', descending: true)
        .snapshots()
        .asyncMap((event) async{
      List<ContactChatModel> contacts = [];
      for (var document in event.docs) {
        ContactChatModel contactChat =
            ContactChatModel.fromMap(document.data());
        var userData = await _firestore
            .collection('users')
            .doc(contactChat.contactId)
            .get();
        var user = UserModel.fromMap(userData.data()!);
        contacts.add(
          ContactChatModel(
            name: map.containsKey(contactChat.contactId)
                ? map[contactChat.contactId]['name']
                : user.name,
            profilePic: user.profilePic,
            contactId: user.uId,
            lastMessage: contactChat.lastMessage,
            timeSent: contactChat.timeSent,
            phoneNumber: contactChat.phoneNumber,
          ),
        );
      }
      return contacts;
    });
  }

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId){
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('chats')
        .doc(senderId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      int num= 0;
      for (var document in event.docs) {
        MessageModel message = MessageModel.fromMap(document.data());
        if(message.senderId == senderId){
          if(!message.isSeen){
            num++;
          }
        }
      }
      return num;
    });
  }

  @override
  Future<void> setChatMessageSeen(
      SetChatMessageSeenParameters parameters) async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('chats')
        .doc(parameters.receiverId)
        .collection('messages')
        .doc(parameters.messageId)
        .update({
      'isSeen': true,
    });
    // users -> receiver id -> chats -> sender id -> messages ->message id ->store message
    await _firestore
        .collection('users')
        .doc(parameters.receiverId)
        .collection('chats')
        .doc(_auth.currentUser!.uid)
        .collection('messages')
        .doc(parameters.messageId)
        .update({
      'isSeen': true,
    });
  }
}
