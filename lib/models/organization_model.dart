import 'package:cloud_firestore/cloud_firestore.dart';

class Organization {
  final String id;
  final String name;
  final String image;

  Organization({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  static Organization fromDocument(QueryDocumentSnapshot doc) {
    final eventData = doc.data() as Map<String, dynamic>;
    eventData['id'] = doc.id;
    return Organization.fromJson(eventData);
  }
}
