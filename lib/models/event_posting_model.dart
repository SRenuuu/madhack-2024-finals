import 'package:cloud_firestore/cloud_firestore.dart';

class EventPosting {
  final String id;
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
  final List<String>? tags;
  final bool? isFeatured;
  final int? appliedCount;

  EventPosting({
    required this.id,
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
    this.tags,
    this.isFeatured,
    this.appliedCount,
  });

  factory EventPosting.fromJson(Map<String, dynamic> json) {

    return EventPosting(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
      notes: json['notes'],
      startDate: json['start_date'].toDate(),
      endDate: json['end_date'].toDate(),
      image: json['image'],
      organizerPhone: json['organizer_phone'],
      organizerEmail: json['organizer_email'],
      deadline: json['deadline'].toDate(),
      registrationLink: json['registration_link'],
      skills: List<String>.from(json['skills']),
      tags: List<String>.from(json['tags']),
      isFeatured: json['is_featured'],
      appliedCount: json['applied_count'],
    );
  }

  static EventPosting fromDocument(QueryDocumentSnapshot doc) {
    print(doc.data());
    final eventData = doc.data() as Map<String, dynamic>;
    eventData['id'] = doc.id;
    return EventPosting.fromJson(eventData);
  }
}
