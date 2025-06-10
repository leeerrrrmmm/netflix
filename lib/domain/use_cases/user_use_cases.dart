import 'package:netflix/data/repo_impl/user_repo_impl.dart';
import 'package:netflix/domain/entity/user_entity.dart';

class GetUserByUidUseCase {
  final UserRepoImpl userRepoImpl;

  GetUserByUidUseCase({required this.userRepoImpl});

  Future<UserEntity?> getUserByUid(String uid) async {
    return userRepoImpl.getUserByUid(uid);
  }

  Future<List<UserEntity?>> fetchUsersByDeviceId(String deviceId) async {
    return userRepoImpl.getUsersByDeviceId(deviceId);
  }
}
