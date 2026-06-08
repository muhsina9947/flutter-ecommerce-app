import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth =
      FirebaseAuth.instance;

  static User? get currentUser =>
      _auth.currentUser;

  // SAFE USER ID
  static String? get userId =>
      _auth.currentUser?.uid;

  // SIGN OUT
  static Future<void> signOut() async {
    await _auth.signOut();
  }
}