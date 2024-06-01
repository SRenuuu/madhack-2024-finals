import 'package:flutter_app/models/user_detail_response.dart';

class WorkExperienceViewArguments {
  final bool isNew;
  final WorkExperience? workExperience;
  final UserDetailResponse? userDetailResponse;

  WorkExperienceViewArguments({required this.isNew, required this.userDetailResponse, this.workExperience});
}