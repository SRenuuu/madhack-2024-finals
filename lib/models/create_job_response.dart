// {"status":"success","message":"job created"}

class CreateJobResponse {
  CreateJobResponse({
    required this.status,
    required this.message,
  });

  final String status;
  final String message;

  factory CreateJobResponse.fromJson(Map<String, dynamic> json) =>
      CreateJobResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
