import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:netflix/core/utils/device_utils.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final DeviceUtils deviceUtils = DeviceUtils();

  // get cur user
  User? getCurUser() {
    return _auth.currentUser;
  }

  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String name,
    String password,
  ) async {
    try {
      final deviceId = await deviceUtils.getDeviceId();

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user?.updateDisplayName(name);
      await userCredential.user?.reload();

      final user = _auth.currentUser;

      await _firebaseFirestore.collection('Users').doc(user!.uid).set({
        'uid': user.uid,
        'email': user.email,
        'displayName': user.displayName,
        'notifications': false,
        'deviceId': deviceId,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception('Register Error: ${e.code}');
    } catch (e) {
      throw Exception('Was happend an Error: $e');
    }
  }

  Future<UserCredential> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = _auth.currentUser;

      await _firebaseFirestore.collection('Users').doc(user!.uid).update({
        'lastLogin': FieldValue.serverTimestamp(),
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception('Register Error: ${e.code}');
    } catch (e) {
      throw Exception('Register Error: $e');
    }
  }

  Future<UserCredential?> registerGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) return null;

      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      final User? user = userCredential.user;

      if (user == null) {
        throw Exception('Ошибка регистрации');
      }

      final userDoc =
          await _firebaseFirestore.collection('Users').doc(user.uid).get();

      if (!userDoc.exists) {
        await _firebaseFirestore.collection('Users').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'displayName': user.displayName,
          'photoUrl': user.photoURL,
          'phoneNumber': user.phoneNumber,

          'createdAt': FieldValue.serverTimestamp(),
          'lastLogin': FieldValue.serverTimestamp(),
          'notifications': false,
        });
      }

      return userCredential;
    } catch (e) {
      throw Exception('Google register error: $e');
    }
  }

  Future<UserCredential?> loginWuthGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) return null;

      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      final userDoc =
          await _firebaseFirestore
              .collection('Users')
              .doc(userCredential.user!.uid)
              .get();

      if (!userDoc.exists) {
        throw Exception('User was not found. Please, try again');
      }

      return userCredential;
    } catch (e) {
      throw Exception('Login with google error: $e');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
