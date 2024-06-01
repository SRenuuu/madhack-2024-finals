class JobPostingResponse {
  final String title;
  final String description;
  final String?
      requirements; // Make requirements nullable as it might not be present in the response
  final String?
      responsibilities; // Make responsibilities nullable as it might not be present in the response
  final String location;
  final String salaryRange;
  final String employerId;

  const JobPostingResponse({
    required this.title,
    required this.description,
    this.requirements,
    this.responsibilities,
    required this.location,
    required this.salaryRange,
    required this.employerId,
  });

  factory JobPostingResponse.fromJson(Map<String, dynamic> json) {
    return JobPostingResponse(
      title: json['title'] as String,
      description: json['description'] as String,
      requirements: json['requirements'] as String?,
      responsibilities: json['responsibilities'] as String?,
      location: json['location'] as String,
      salaryRange: json['salaryRange'] as String,
      employerId: json['employer'] as String,
    );
  }
}
