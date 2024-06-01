import 'package:cloud_firestore/cloud_firestore.dart';

class EventPosting {
  final String name;
  final String location;
  final String description;
  final String notes;
  final DateTime startDate;
  final DateTime endDate;
  final String image;
  final String organizerPhone;
  final String organizerEmail;
  final DateTime deadline;
  final String registrationLink;
  final List<String> skills;
  final String? tag;
  final bool? isFeatured;
  final int? appliedCount;

  EventPosting({
    required this.name,
    required this.location,
    required this.description,
    required this.notes,
    required this.startDate,
    required this.endDate,
    required this.image,
    required this.organizerPhone,
    required this.organizerEmail,
    required this.deadline,
    required this.registrationLink,
    required this.skills,
    this.tag,
    this.isFeatured,
    this.appliedCount,
  });

  factory EventPosting.fromJson(Map<String, dynamic> json) {
    return EventPosting(
      name: json['name'],
      location: json['location'],
      description: json['description'],
      notes: json['notes'],
      startDate: json['start_date'].toDate(),
      endDate: json['end_date'].toDate(),
      image: "",
      organizerPhone: json['organizer_phone'],
      organizerEmail: json['organizer_email'],
      deadline: json['deadline'].toDate(),
      registrationLink: json['registration_link'],
      skills: List<String>.from(json['skills']),
      tag: json['tag'],
      isFeatured: json['is_featured'],
      appliedCount: json['applied_count'],
    );
  }

  static EventPosting fromDocument(QueryDocumentSnapshot doc) {
    return EventPosting.fromJson(doc.data() as Map<String, dynamic>);
  }
}
