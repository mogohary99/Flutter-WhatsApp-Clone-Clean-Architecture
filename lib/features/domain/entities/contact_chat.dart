import 'package:equatable/equatable.dart';

class ContactChat extends Equatable {
  final String name;
  final String profilePic;
  final String contactId;
  final String lastMessage;
  final DateTime timeSent;
  final String phoneNumber;

  const ContactChat({
    required this.name,
    required this.profilePic,
    required this.contactId,
    required this.lastMessage,
    required this.timeSent,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [
        name,
        profilePic,
        contactId,
        lastMessage,
        timeSent,
    phoneNumber,
      ];
}
