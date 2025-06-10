import 'package:netflix/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<List<UserEntity>> getUsersByDeviceId(String deviceId);
}
