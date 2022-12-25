import '../../domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.name,
    required super.uId,
    required super.status,
    required super.profilePic,
    required super.phoneNumber,
    required super.isOnline,
    required super.groupId,
    required super.lastSeen,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'status': status,
      'profilePic': profilePic,
      'phoneNumber': phoneNumber,
      'isOnline': isOnline,
      'groupId': groupId,
      'lastSeen': lastSeen.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      uId: map['uId'] ?? '',
      status: map['status'] ?? '',
      profilePic: map['profilePic'] ?? '',
      phoneNumber: map['phoneNumber'],
      isOnline: map['isOnline'] ?? false,
      groupId: List<String>.from(map['groupId']),
      lastSeen: DateTime.fromMillisecondsSinceEpoch(map['lastSeen']),
    );
  }
}
