// controllers/home_controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import '../models/event_posting_model.dart';
import '../services/firestore_service.dart';
import '../widgets/event_card.dart';

class HomeController extends GetxController {
  final FirestoreService firestoreService = Get.find<FirestoreService>();

  final TextEditingController searchController = TextEditingController();

  final RxBool isFeaturedEventsLoading = false.obs;
  final RxBool isOrgsLoading = false.obs;
  final RxList<dynamic> featuredEvents = RxList<dynamic>([]);

  final AdvancedDrawerController drawerController = AdvancedDrawerController();

  @override
  void onInit() {
    super.onInit();
    fetchFeaturedEvents();
  }

  Future<void> fetchFeaturedEvents() async {
    isFeaturedEventsLoading.value = true;
    try {
      final featuredEventsData =
          await firestoreService.getDocuments<EventPosting>(
        EventPosting.fromDocument,
        'events',
        null,
        (query) => query.orderBy('start_date',
            descending: true), // Specify ordering if needed
      );
      featuredEvents.clear();
      featuredEvents.addAll(featuredEventsData);
      print(featuredEvents);
    } catch (e) {
      print(e);
    } finally {
      isFeaturedEventsLoading.value = false;
    }
  }

  void handleDrawerToggle() {
    drawerController.toggleDrawer();
  }

  final RxList<String> skills = [
    'Communication',
    'Time Management',
    'Adaptability',
    'Problem Solving',
    'Teamwork',
    'Compassion',
    'Friendliness',
    'Enthusiasm',
  ].obs;

  final RxList<String> selectedSkills = <String>[].obs;

  final List<String> timeCommitments = [
    '6-12 Months',
    'Less than 3 months',
    '3-6 months',
    'More then 12 months'
  ];
  final RxList<String> selectedTimeCommitments = <String>[].obs;

  void addSkillTag(String tag) {
    selectedSkills.add(tag);
  }

  void removeSkillTag(String tag) {
    selectedSkills.remove(tag);
  }

  void addTimeCommitmentTag(String tag) {
    selectedTimeCommitments.add(tag);
  }

  void removeTimeCommitmentTag(String tag) {
    selectedTimeCommitments.remove(tag);
  }

  final TextEditingController filterLocationController =
  TextEditingController();

}

class ImageCategory {
  final IconData icon;
  final String categoryName;

  const ImageCategory({required this.icon, required this.categoryName});
}
