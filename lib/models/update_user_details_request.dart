// To parse this JSON data, do
//
//     final updateUserDetailRequest = updateUserDetailRequestFromJson(jsonString);

import 'dart:convert';

UpdateUserDetailRequest updateUserDetailRequestFromJson(String str) => UpdateUserDetailRequest.fromJson(json.decode(str));

String updateUserDetailRequestToJson(UpdateUserDetailRequest data) => json.encode(data.toJson());

class UpdateUserDetailRequest {
  String name;
  DateTime dob;
  String contact;
  List<String> socialLinks;
  List<String> skills;
  List<QualificationUpdate> qualifications;
  List<WorkExperienceUpdate> workExperience;
  List<EducationUpdate> education;

  UpdateUserDetailRequest({
    required this.name,
    required this.dob,
    required this.contact,
    required this.socialLinks,
    required this.skills,
    required this.qualifications,
    required this.workExperience,
    required this.education,
  });

  factory UpdateUserDetailRequest.fromJson(Map<String, dynamic> json) => UpdateUserDetailRequest(
    name: json["name"],
    dob: DateTime.parse(json["dob"]),
    contact: json["contact"],
    socialLinks: List<String>.from(json["socialLinks"].map((x) => x)),
    skills: List<String>.from(json["skills"].map((x) => x)),
    qualifications: List<QualificationUpdate>.from(json["qualifications"].map((x) => QualificationUpdate.fromJson(x))),
    workExperience: List<WorkExperienceUpdate>.from(json["workExperience"].map((x) => WorkExperienceUpdate.fromJson(x))),
    education: List<EducationUpdate>.from(json["education"].map((x) => EducationUpdate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "contact": contact,
    "socialLinks": List<dynamic>.from(socialLinks.map((x) => x)),
    "skills": List<dynamic>.from(skills.map((x) => x)),
    "qualifications": List<dynamic>.from(qualifications.map((x) => x.toJson())),
    "workExperience": List<dynamic>.from(workExperience.map((x) => x.toJson())),
    "education": List<dynamic>.from(education.map((x) => x.toJson())),
  };
}

class EducationUpdate {
  String institution;
  String degree;
  String field;
  DateTime startDate;
  DateTime endDate;
  String description;

  EducationUpdate({
    required this.institution,
    required this.degree,
    required this.field,
    required this.startDate,
    required this.endDate,
    required this.description,
  });

  factory EducationUpdate.fromJson(Map<String, dynamic> json) => EducationUpdate(
    institution: json["institution"],
    degree: json["degree"],
    field: json["field"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "institution": institution,
    "degree": degree,
    "field": field,
    "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "description": description,
  };
}

class QualificationUpdate {
  String qualification;
  DateTime date;
  String description;

  QualificationUpdate({
    required this.qualification,
    required this.date,
    required this.description,
  });

  factory QualificationUpdate.fromJson(Map<String, dynamic> json) => QualificationUpdate(
    qualification: json["qualification"],
    date: DateTime.parse(json["date"]),
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "qualification": qualification,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "description": description,
  };
}

class WorkExperienceUpdate {
  String position;
  String company;
  DateTime startDate;
  DateTime endDate;
  bool isCurrent;
  String description;

  WorkExperienceUpdate({
    required this.position,
    required this.company,
    required this.startDate,
    required this.endDate,
    required this.isCurrent,
    required this.description,
  });

  factory WorkExperienceUpdate.fromJson(Map<String, dynamic> json) => WorkExperienceUpdate(
    position: json["position"],
    company: json["company"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    isCurrent: json["isCurrent"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "position": position,
    "company": company,
    "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "isCurrent": isCurrent,
    "description": description,
  };
}
