import '../models/update_user_details_request.dart';
import '../models/user_detail_response.dart';

UpdateUserDetailRequest mapToUpdateUserDetailRequest(UserDetailResponse userDetailResponse) {
  List<QualificationUpdate> qualifications = List<QualificationUpdate>.empty(growable: true);
  List<WorkExperienceUpdate> workExperiences = List<WorkExperienceUpdate>.empty(growable: true);
  List<EducationUpdate> educations = List<EducationUpdate>.empty(growable: true);

  for (var element in userDetailResponse.data.profile.qualifications) {
    qualifications.add(QualificationUpdate(qualification: element.qualification, date: element.date, description: element.description));
  }

  for (var element in userDetailResponse.data.profile.workExperience) {
    workExperiences.add(WorkExperienceUpdate(position: element.position, company: element.company, startDate: element.startDate, endDate: element.endDate, isCurrent: element.isCurrent, description: element.description));
  }

  for (var element in userDetailResponse.data.profile.education) {
    educations.add(EducationUpdate(institution: element.institution, degree: element.degree, field: element.field, startDate: element.startDate, endDate: element.endDate, description: element.description));
  }

  return UpdateUserDetailRequest(
    name: userDetailResponse.data.profile.name,
    dob: DateTime.parse(userDetailResponse.data.profile.dob),
    contact: userDetailResponse.data.profile.contact,
    socialLinks: userDetailResponse.data.profile.socialLinks,
    skills: userDetailResponse.data.profile.skills,
    qualifications: qualifications,
    workExperience: workExperiences,
    education: educations,
  );
}

DateTime createDateTimeWithFixedDate(String dateString) {
  DateTime baseDateTime = DateTime.parse(dateString).copyWith(hour: 0, minute: 0, second: 0, microsecond: 0);
  DateTime now = DateTime.now();

  return DateTime(
      baseDateTime.year,
      baseDateTime.month,
      baseDateTime.day,
      now.hour,
      now.minute,
      now.second,
      now.microsecond);
}