import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String uId;
  final String status;
  final String profilePic;
  final String phoneNumber;
  final bool isOnline;
  final List<String> groupId;
  final DateTime lastSeen;

  const UserEntity({
    required this.name,
    required this.uId,
    required this.status,
    required this.profilePic,
    required this.phoneNumber,
    required this.isOnline,
    required this.groupId,
    required this.lastSeen,
  });

  @override
  List<Object?> get props => [
    name,
    uId,
    status,
    profilePic,
    phoneNumber,
    isOnline,
    groupId,
    lastSeen,
  ];
}
