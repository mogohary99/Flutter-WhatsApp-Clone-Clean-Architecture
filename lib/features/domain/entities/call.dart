import 'package:equatable/equatable.dart';

class Call extends Equatable {
  final String callerId;
  final String callerName;
  final String callerPic;
  final String receiverId;
  final String receiverName;
  final String receiverPic;
  final String callId;
  final bool hasDialled;

  const Call({
    required this.callerId,
    required this.callerName,
    required this.callerPic,
    required this.receiverId,
    required this.receiverName,
    required this.receiverPic,
    required this.callId,
    required this.hasDialled,
  });

  @override
  List<Object?> get props => [
        callerId,
        callerName,
        callerPic,
        receiverId,
        receiverName,
        receiverPic,
        callId,
        hasDialled,
      ];
}
