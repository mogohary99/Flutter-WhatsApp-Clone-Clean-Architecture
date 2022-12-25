import 'package:whatsapp_flutter_clone/core/enums/messge_type.dart';
import 'package:whatsapp_flutter_clone/features/domain/entities/message.dart';

class MessageModel extends Message {
  const MessageModel({
    required super.senderId,
    required super.receiverId,
    required super.text,
    required super.messageId,
    required super.timeSent,
    required super.isSeen,
    required super.messageType,
    required super.repliedMessage,
    required super.repliedTo,
    required super.repliedMessageType,
    required super.senderName,
  });

  Map<String, dynamic> toMap() => {
        'senderId': senderId,
        'receiverId': receiverId,
        'text': text,
        'messageId': messageId,
        'timeSent': timeSent.millisecondsSinceEpoch,
        'isSeen': isSeen,
        'messageType': messageType.type,
        'repliedMessage': repliedMessage,
        'repliedTo': repliedTo,
        'repliedMessageType': repliedMessageType.type,
        'senderName': senderName,
      };

  factory MessageModel.fromMap(Map<String, dynamic> map) => MessageModel(
        senderId: map['senderId'],
        receiverId: map['receiverId'],
        text: map['text'],
        messageId: map['messageId'],
        timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
        isSeen: map['isSeen'],
        messageType: (map['messageType'] as String).toEnum(),
        repliedMessage: map['repliedMessage'],
        repliedTo: map['repliedTo'],
        repliedMessageType: (map['repliedMessageType'] as String).toEnum(),
        senderName: map['senderName'],
      );
}
