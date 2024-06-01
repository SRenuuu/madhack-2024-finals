import 'package:flutter/material.dart';
import 'package:flutter_app/services/api_service.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/services/resume_upload_service.dart';
import 'package:flutter_app/views/auth/login_view.dart';
import 'package:flutter_app/views/auth/signup_view.dart';
import 'package:flutter_app/views/employer/employer_signup_view.dart';
import 'package:flutter_app/views/employer/home_view.dart';
import 'package:flutter_app/views/employer/job_listing_view.dart';
import 'package:flutter_app/views/home/home_view.dart';
import 'package:flutter_app/views/home/search_filters_view.dart';
import 'package:flutter_app/views/job_listing_view.dart';
import 'package:flutter_app/views/job_posting/job_post_form_view.dart';
import 'package:flutter_app/views/profile/about_me_view.dart';
import 'package:flutter_app/views/profile/all_work_experience.dart';
import 'package:flutter_app/views/profile/education_view.dart';
import 'package:flutter_app/views/profile/profile_view.dart';
import 'package:flutter_app/views/profile/qualification_view.dart';
import 'package:flutter_app/views/profile/skills_view.dart';
import 'package:flutter_app/views/profile/work_experience_view.dart';
import 'package:flutter_app/views/resume_upload_view.dart';
import 'package:flutter_app/views/root_view.dart';
import 'package:flutter_app/views/saved_jobs_view.dart';
import 'package:flutter_app/views/splash_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'theme/app_theme.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put<GetConnect>(GetConnect());
    Get.put(AuthService());
    Get.put(ApiService());
    Get.put(ResumeUploadService());

    return GetMaterialApp(
        title: 'WorkWise - Job Search',
        theme: AppTheme.getTheme(),
        home: const SplashView(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/root': (context) => const RootView(),
          '/login': (context) => const LoginView(),
          '/sign_up': (context) => const SignUpView(),
          '/home': (context) => const HomeView(),
          '/job': (context) => JobListingPage(),
          '/profile': (context) => const UserProfilePage(),
          '/search-filters': (context) => const SearchFiltersView(),
        '/user-profile': (context) => const UserPersonalDetailPage(),
        '/user-experience': (context) => const WorkExperiencePage(),
        '/resume': (context) => const ResumeUploadView(),
        // '/job_post': (context) => const JobPostFormView(),
        '/about-me': (context) => const UserPersonalDetailPage(),
        '/work-experience': (context) => const WorkExperiencePage(),
        '/education': (context) => const EducationPage(),
        '/qualification': (context) => const QualificationPage(),
        '/skills': (context) => const SkillsPage(),
        '/all-experiences': (context) => const AllWorkExperiencePage(),
        '/saved-jobs': (context) => const SavedJobsView(),

        // Employer Routes
        '/employer_sign_up': (context) => const EmployerSignUpView(),
        '/employer-home': (context) => const EmployerHomeView(),
        '/create-job': (context) => const JobPostFormView(),
        '/employer-job': (context) => EmployerJobListingPage(),
      },
    );
  }
}
