import 'dart:convert';

SignUpRequest signupRequestFromJson(String str) =>
    SignUpRequest.fromJson(json.decode(str));

String loginRequestToJson(SignUpRequest data) => json.encode(data.toJson());

class SignUpRequest {
  String name;
  String email;
  String password;
  String confirmPassword = "";
  String role = "";

  SignUpRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.role = "jobApplicant",
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => SignUpRequest(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        confirmPassword: json["confirm_password"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "confirm_password": confirmPassword,
        "role": role,
      };
}
