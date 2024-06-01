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
        EventPosting.fromJson,
        'events',
        {},
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
}
