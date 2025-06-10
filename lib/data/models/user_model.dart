import 'package:netflix/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    required super.email,
    required super.name,
    required super.photoUrl,
    required super.profiles,
    required super.deviceId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['displayName'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      profiles:
          (json['profiles'] as List<dynamic>?)
              ?.map((e) => e['name'] as String)
              .toList() ??
          [],
      deviceId: json['deviceId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'displayName': name,
      'email': email,
      'photoUrl': photoUrl,
      'profiles': profiles,
      'deviceId': deviceId,
    };
  }
}
