import 'dart:convert';

CreateJobRequest createJobRequestFromJson(String str) =>
    CreateJobRequest.fromJson(json.decode(str));

String createJobRequestToJson(CreateJobRequest data) =>
    json.encode(data.toJson());

class CreateJobRequest {
  CreateJobRequest({
    this.title,
    this.description,
    this.requirements,
    this.responsibilities,
    this.location,
    this.salaryRange,
    this.tags,
  });

  final String? title;
  final String? description;
  final List<String>? requirements;
  final List<String>? responsibilities;
  final String? location;
  final SalaryRange? salaryRange;
  final List<String>? tags;

  factory CreateJobRequest.fromJson(Map<String, dynamic> json) =>
      CreateJobRequest(
        title: json["title"],
        description: json["description"],
        requirements: List<String>.from(json["requirements"].map((x) => x)),
        responsibilities:
            List<String>.from(json["responsibilities"].map((x) => x)),
        location: json["location"],
        salaryRange: SalaryRange.fromJson(json["salaryRange"]),
        tags: List<String>.from(json["tags"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "requirements": List<dynamic>.from(requirements!.map((x) => x)),
        "responsibilities": List<dynamic>.from(responsibilities!.map((x) => x)),
        "location": location,
        "salaryRange": salaryRange!.toJson(),
        "tags": List<dynamic>.from(tags!.map((x) => x)).toString(),
      };

  String toString() {
    return "CreateJobRequest(title: $title, description: $description, requirements: $requirements, responsibilities: $responsibilities, location: $location, salaryRange: $salaryRange, tags: $tags)";
  }
}

class SalaryRange {
  SalaryRange({
    this.low,
    this.high,
    this.currency,
  });

  final double? low;
  final double? high;
  final String? currency;

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

  String toString() {
    return "SalaryRange(low: $low, high: $high, currency: $currency)";
  }
}
