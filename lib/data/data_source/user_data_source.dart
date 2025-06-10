import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:netflix/data/models/user_model.dart';

class UserRemoteDataSource {
  final FirebaseFirestore firestore;

  UserRemoteDataSource(this.firestore);

  Future<List<UserModel>> getUsersByDeviceId(String deviceId) async {
    final snapshot =
        await firestore
            .collection('Users')
            .where('deviceId', isEqualTo: deviceId)
            .get();

    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }
}
