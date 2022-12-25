import '../../domain/entities/contact_chat.dart';

class ContactChatModel extends ContactChat {
  const ContactChatModel({
    required super.name,
    required super.profilePic,
    required super.contactId,
    required super.lastMessage,
    required super.timeSent,
    required super.phoneNumber,
  });

  Map<String, dynamic> toMAp() => {
        'name': name,
        'profilePic': profilePic,
        'contactId': contactId,
        'lastMessage': lastMessage,
        'timeSent': timeSent.millisecondsSinceEpoch,
        'phoneNumber' : phoneNumber,
      };

  factory ContactChatModel.fromMap(Map<String, dynamic> map) =>
      ContactChatModel(
        name: map['name'],
        profilePic: map['profilePic'],
        contactId: map['contactId'],
        lastMessage: map['lastMessage'],
        timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
        phoneNumber: map['phoneNumber'],
      );
}
