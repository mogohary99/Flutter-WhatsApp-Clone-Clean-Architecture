import 'package:equatable/equatable.dart';

import '../../../core/enums/messge_type.dart';

class Message extends Equatable {
  final String senderId;
  final String receiverId;
  final String senderName;
  final String text;
  final String messageId;
  final DateTime timeSent;
  final bool isSeen;
  final MessageType messageType;
  //replay message
  final String repliedMessage;
  final String repliedTo;
  final MessageType repliedMessageType;

  const Message({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.messageId,
    required this.timeSent,
    required this.isSeen,
    required this.messageType,
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedMessageType,
    required this.senderName,
  });

  @override
  List<Object?> get props => [
    senderId,
    receiverId,
    text,
    messageId,
    timeSent,
    isSeen,
    messageType,
    repliedMessage,
    repliedTo,
    repliedMessageType,
    senderName,
  ];
}
