class UserEntity {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final List<String> profiles;
  final String deviceId;
  UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.profiles,
    required this.deviceId,
  });
}
