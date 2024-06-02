import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/api_service.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/services/firebase_auth_service.dart';
import 'package:flutter_app/services/firebase_service.dart';
import 'package:flutter_app/services/firestore_service.dart';
import 'package:flutter_app/views/auth/login_view.dart';
import 'package:flutter_app/views/auth/signup_view.dart';
import 'package:flutter_app/views/chat/chat_contacts.dart';
import 'package:flutter_app/views/employer/employer_signup_view.dart';
import 'package:flutter_app/views/event_listing_view.dart';
import 'package:flutter_app/views/home/home_view.dart';
import 'package:flutter_app/views/home/search_filters_view.dart';
import 'package:flutter_app/views/home/org_home_view.dart';
import 'package:flutter_app/views/organizations/ManageApplicationHomePage.dart';
import 'package:flutter_app/views/organizations/create_event.dart';
import 'package:flutter_app/views/organizations/create_event_step_three.dart';
import 'package:flutter_app/views/organizations/create_event_step_two.dart';
import 'package:flutter_app/views/organizations/received_application.dart';
import 'package:flutter_app/views/profile/profile_view.dart';
import 'package:flutter_app/views/root_view.dart';
import 'package:flutter_app/views/events_view.dart';
import 'package:flutter_app/views/splash_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'theme/app_theme.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put<GetConnect>(GetConnect());
    Get.put(FirebaseService());
    Get.put(FirebaseAuthService());
    Get.put(AuthService());
    Get.put(ApiService());

    Get.put(FirestoreService());

    return GetMaterialApp(
      title: 'Volunify',
      theme: AppTheme.getTheme(),
      home: const SplashView(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/root': (context) => const RootView(),
        '/login': (context) => const LoginView(),
        '/sign_up': (context) => const SignUpView(),
        '/home': (context) => const HomeView(),
        '/event': (context) => EventListingView(),
        '/profile': (context) => const UserProfilePage(),
        '/search-filters': (context) => const SearchFiltersView(),
        '/events': (context) => const EventsView(),

        '/employer_sign_up': (context) => const EmployerSignUpView(),

        // Organizations Routes
        '/organizer-home': (context) => const OrganizerHomeView(),
        '/create-event': (context) => const CreateEventStepOnePage(),
        '/create-event-step-2': (context) => const CreateEventStepTwoPage(),
        '/create-event-step-3': (context) => const CreateEventStepThreePage(),

        //    Chat routes
        '/chat': (context) => ChatListPage(),
        '/manage-application': (context) => const Manageapplicationhomepage(),
        '/manage-application-received': (context) =>
            const ReceivedApplication(),
      },
    );
  }
}
