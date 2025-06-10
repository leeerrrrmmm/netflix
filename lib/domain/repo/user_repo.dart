import 'package:netflix/domain/entity/user_entity.dart';

abstract class UserRepo {
  Future<UserEntity?> getUserByUid(String uid);

  Future<List<UserEntity?>> getUsersByDeviceId(String deviceId);
}
