import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream to listen for user changes (optional)
  Stream<User?> get userStream => _auth.authStateChanges();

  // User sign-up logic
  Future<UserCredential?> signUp(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      // Handle sign-up errors
      Get.snackbar('Error', e.message!);
      return null;
    }
  }

  // User sign-in logic
  Future<UserCredential?> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      // Handle sign-in errors
      Get.snackbar('Error', e.message!);
      return null;
    }
  }

  // User sign-out logic
  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAllNamed('/login'); // Navigate to login screen after sign-out
  }

  // Check if user is logged in (optional)
  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  // Get current user (optional)
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
