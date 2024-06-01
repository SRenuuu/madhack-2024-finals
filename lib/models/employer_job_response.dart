// {
// "salaryRange": {
// "low": 15500,
// "high": 223500,
// "currency": "LKR"
// },
// "_id": "65f5b5d2c695cf1b709005b3",
// "title": "Software Engineer",
// "description": "We are looking for a junior web developer...",
// "requirements": [
// "Clean code"
// ],
// "responsibilities": [
// "Software Engineering"
// ],
// "location": "LatLng(-33.8688, 151.2093)",
// "tags": [
// "[Remote, Full Time, Software Engineering]"
// ],
// "employer": {
// "profile": {
// "name": "Test Employer"
// },
// "_id": "65f59f00363a9721b4ea8aae",
// "email": "emp@gmail.com"
// },
// "createdAt": "2024-03-16T15:08:02.551Z",
// "updatedAt": "2024-03-16T15:08:02.551Z",
// "__v": 0
// }

class EmployerJobResponse {
  EmployerJobResponse({
    required this.salaryRange,
    required this.id,
    required this.title,
    required this.description,
    required this.requirements,
    required this.responsibilities,
    required this.location,
    required this.tags,
    required this.employer,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  SalaryRange salaryRange;
  String id;
  String title;
  String description;
  List<String> requirements;
  List<String> responsibilities;
  String location;
  List<String> tags;
  Employer employer;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory EmployerJobResponse.fromJson(Map<String, dynamic> json) =>
      EmployerJobResponse(
        salaryRange: SalaryRange.fromJson(json["salaryRange"]),
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        requirements: List<String>.from(json["requirements"].map((x) => x)),
        responsibilities:
            List<String>.from(json["responsibilities"].map((x) => x)),
        location: json["location"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        employer: Employer.fromJson(json["employer"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "salaryRange": salaryRange.toJson(),
        "_id": id,
        "title": title,
        "description": description,
        "requirements": List<dynamic>.from(requirements.map((x) => x)),
        "responsibilities": List<dynamic>.from(responsibilities.map((x) => x)),
        "location": location,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "employer": employer.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Employer {
  Employer({
    required this.profile,
    required this.id,
    required this.email,
  });

  Profile profile;
  String id;
  String email;

  factory Employer.fromJson(Map<String, dynamic> json) => Employer(
        profile: Profile.fromJson(json["profile"]),
        id: json["_id"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "profile": profile.toJson(),
        "_id": id,
        "email": email,
      };
}

class Profile {
  Profile({
    required this.name,
  });

  String name;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class SalaryRange {
  SalaryRange({
    required this.low,
    required this.high,
    required this.currency,
  });

  int low;
  int high;
  String currency;

  factory SalaryRange.fromJson(Map<String, dynamic> json) => SalaryRange(
        low: json["low"],
        high: json["high"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "low": low,
        "high": high,
        "currency": currency,
      };
}
