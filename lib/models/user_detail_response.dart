import 'dart:convert';

UserDetailResponse userDetailResponseFromJson(String str) => UserDetailResponse.fromJson(json.decode(str));

String userDetailResponseToJson(UserDetailResponse data) => json.encode(data.toJson());

class UserDetailResponse {
  String status;
  Data data;

  UserDetailResponse({
    required this.status,
    required this.data,
  });

  factory UserDetailResponse.fromJson(Map<String, dynamic> json) => UserDetailResponse(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Profile profile;
  String id;
  String email;
  String role;
  String image;
  int v;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.profile,
    required this.id,
    required this.email,
    required this.role,
    required this.image,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    profile: Profile.fromJson(json["profile"]),
    id: json["_id"],
    email: json["email"],
    role: json["role"],
    image: json["image"],
    v: json["__v"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "profile": profile.toJson(),
    "_id": id,
    "email": email,
    "role": role,
    "image": image,
    "__v": v,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Profile {
  String name;
  String dob;
  String contact;
  List<String> socialLinks;
  List<String> skills;
  List<Qualification> qualifications;
  List<WorkExperience> workExperience;
  List<Education> education;

  Profile({
    required this.name,
    required this.dob,
    required this.contact,
    required this.socialLinks,
    required this.skills,
    required this.qualifications,
    required this.workExperience,
    required this.education,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    name: json["name"],
    dob: json["dob"],
    contact: json["contact"],
    socialLinks: List<String>.from(json["socialLinks"].map((x) => x)),
    skills: List<String>.from(json["skills"].map((x) => x)),
    qualifications: List<Qualification>.from(json["qualifications"].map((x) => Qualification.fromJson(x))),
    workExperience: List<WorkExperience>.from(json["workExperience"].map((x) => WorkExperience.fromJson(x))),
    education: List<Education>.from(json["education"].map((x) => Education.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "dob": dob,
    "contact": contact,
    "socialLinks": List<dynamic>.from(socialLinks.map((x) => x)),
    "skills": List<dynamic>.from(skills.map((x) => x)),
    "qualifications": List<dynamic>.from(qualifications.map((x) => x.toJson())),
    "workExperience": List<dynamic>.from(workExperience.map((x) => x.toJson())),
    "education": List<dynamic>.from(education.map((x) => x.toJson())),
  };
}

class Education {
  String institution;
  String degree;
  String field;
  DateTime startDate;
  DateTime endDate;
  String description;
  String id;

  Education({
    required this.institution,
    required this.degree,
    required this.field,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.id,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
    institution: json["institution"],
    degree: json["degree"],
    field: json["field"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    description: json["description"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "institution": institution,
    "degree": degree,
    "field": field,
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "description": description,
    "_id": id,
  };
}

class Qualification {
  String qualification;
  DateTime date;
  String description;
  String id;

  Qualification({
    required this.qualification,
    required this.date,
    required this.description,
    required this.id,
  });

  factory Qualification.fromJson(Map<String, dynamic> json) => Qualification(
    qualification: json["qualification"],
    date: DateTime.parse(json["date"]),
    description: json["description"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "qualification": qualification,
    "date": date.toIso8601String(),
    "description": description,
    "_id": id,
  };
}

class WorkExperience {
  String position;
  String company;
  DateTime startDate;
  DateTime endDate;
  bool isCurrent;
  String description;
  String id;

  WorkExperience({
    required this.position,
    required this.company,
    required this.startDate,
    required this.endDate,
    required this.isCurrent,
    required this.description,
    required this.id,
  });

  factory WorkExperience.fromJson(Map<String, dynamic> json) => WorkExperience(
    position: json["position"],
    company: json["company"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    isCurrent: json["isCurrent"],
    description: json["description"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "position": position,
    "company": company,
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "isCurrent": isCurrent,
    "description": description,
    "_id": id,
  };
}
