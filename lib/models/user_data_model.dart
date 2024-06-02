class UserData {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String? role;

  UserData({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.role,
  });

  // Factory constructor to create a UserData instance from a map
  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      uid: map['uid']?? '',
      email: map['email'],
      displayName: map['displayName'],
      photoUrl: map['photoUrl'],
      role: map['role'],
    );
  }

  // Method to convert a UserData instance to a map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'role': role,
    };
  }
}
