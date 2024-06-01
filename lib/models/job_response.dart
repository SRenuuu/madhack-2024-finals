class JobResponse {
  JobResponse({
    required this.salaryRange,
    required this.id,
    required this.title,
    required this.description,
    required this.requirements,
    required this.responsibilities,
    required this.location,
    required this.tags,
    required this.employer,
    // required this.createdAt,
    // required this.updatedAt,
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
  Employer? employer;

  // DateTime createdAt;
  // DateTime updatedAt;
  int v;

  factory JobResponse.fromJson(Map<String, dynamic> json) => JobResponse(
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
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}

class Employer {
  Employer({
    required this.profile,
    required this.id,
    required this.email,
  });

  Profile? profile;
  String? id;
  String? email;

  factory Employer.fromJson(Map<String, dynamic>? json) => Employer(
        profile: json?["profile"] != null
            ? Profile.fromJson(json?["profile"])
            : null,
        id: json?["_id"],
        email: json?["email"],
      );
}

class Profile {
  Profile({
    required this.name,
  });

  String name;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        name: json["name"],
      );
}

class SalaryRange {
  SalaryRange({
    required this.low,
    required this.high,
    required this.currency,
  });

  double low;
  double high;
  String currency;

  factory SalaryRange.fromJson(Map<String, dynamic> json) => SalaryRange(
        low: json["low"].toDouble(),
        high: json["high"].toDouble(),
        currency: json["currency"],
      );
}
