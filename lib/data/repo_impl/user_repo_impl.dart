import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:netflix/data/data_source/user_data_source.dart';
import 'package:netflix/data/models/user_model.dart';
import 'package:netflix/domain/entity/user_entity.dart';
import 'package:netflix/domain/repo/user_repo.dart';

class UserRepoImpl extends UserRepo {
  final FirebaseFirestore firebaseFirestore;
  final UserRemoteDataSource userRemoteDataSource;

  UserRepoImpl({
    required this.firebaseFirestore,
    required this.userRemoteDataSource,
  });

  @override
  Future<UserEntity?> getUserByUid(String uid) async {
    final doc = await firebaseFirestore.collection('Users').doc(uid).get();

    if (doc.exists) {
      final data = doc.data()!;
      return UserModel.fromJson(data);
    } else {
      return null;
    }
  }

  @override
  Future<List<UserEntity>> getUsersByDeviceId(String deviceId) {
    return userRemoteDataSource.getUsersByDeviceId(deviceId);
  }
}
