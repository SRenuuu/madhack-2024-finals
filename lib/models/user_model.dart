import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String id;
  final String email;
  final String role;

  UserProfile({
    required this.id,
    required this.email,
    required this.role,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      email: json['email'],
      role: json['role'],
    );
  }

  static UserProfile fromDocument(DocumentSnapshot doc) {
    final userData = doc.data() as Map<String, dynamic>;
    userData['id'] = doc.id;
    return UserProfile.fromJson(userData);
  }
}
