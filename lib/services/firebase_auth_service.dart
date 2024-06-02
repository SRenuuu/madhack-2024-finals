import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/user_data_model.dart';
import '../models/user_model.dart';

class FirebaseAuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rxn<User?> _firebaseUser = Rxn<User?>();

  String? get user => _firebaseUser.value?.email;

  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserData?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(user.uid).get();
        UserProfile userProfile = UserProfile.fromDocument(doc);
        String? role = userProfile.role;

        // Construct UserData object
        UserData userData = UserData(
          uid: user.uid,
          email: user.email,
          displayName: user.displayName,
          photoUrl: user.photoURL,
          role: role,
        );

        return userData;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<UserData?> register(String email, String password, String customRole) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        // Create a UserProfile document in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'role': customRole, // Default role, adjust as needed
          // Add other fields as necessary
        });

        // Fetch the newly created user's details
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(user.uid).get();
        UserProfile userProfile = UserProfile.fromDocument(doc);
        String? role = userProfile.role;

        // Construct UserData object
        UserData userData = UserData(
          uid: user.uid,
          email: user.email,
          displayName: user.displayName,
          photoUrl: user.photoURL,
          role: role,
        );

        return userData;
      }
    } catch (e) {
      print(e.toString());
      throw e; // Rethrow the exception to handle it in the calling function
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    Get.toNamed('/login');
  }

  // implement isLoggedIn
  bool isLoggedIn() {
    print(_auth.currentUser);
    return _auth.currentUser != null;
  }

  // implement getRole method
  Future<String?> getRole() async {
    if (_auth.currentUser != null) {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      UserProfile userProfile = UserProfile.fromDocument(doc);
      return userProfile.role;
    }
    return null;
  }

  Future<String?> getName() async {
    final currentUser = _auth.currentUser;
    print(currentUser);
    if (currentUser != null) {
      print(currentUser.displayName);
      return currentUser.displayName;
    }
    return null;
  }

  Future<String?> getEmail() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      return currentUser.email;
    }
    return null;
  }
}
