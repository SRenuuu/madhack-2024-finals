// controllers/home_controller.dart
import 'package:flutter_app/models/organization_model.dart';
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
  final RxBool isYourEventsLoading = false.obs;
  final RxBool isOrgsLoading = false.obs;
  final RxList<dynamic> featuredEvents = RxList<dynamic>([]);
  final RxList<dynamic> yourEvents = RxList<dynamic>([]);
  final RxList<dynamic> orgs = RxList<dynamic>([]);

  final AdvancedDrawerController drawerController = AdvancedDrawerController();

  @override
  void onInit() {
    super.onInit();
    fetchFeaturedEvents();
    fetchOrgs();
    fetchYourEvents();
  }

  Future<void> fetchFeaturedEvents() async {
    isFeaturedEventsLoading.value = true;
    try {
      final featuredEventsData =
          await firestoreService.getDocuments<EventPosting>(
        EventPosting.fromDocument,
        'events',
        {
          'is_featured': true,
        },
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

  Future<void> fetchYourEvents() async {
    isYourEventsLoading.value = true;
    try {
      final yourEventsData = await firestoreService.getDocuments<EventPosting>(
        EventPosting.fromDocument,
        'events',
        null,
        (query) => query.orderBy('start_date', descending: true),
      );
      yourEvents.clear();
      yourEvents.addAll(yourEventsData);
      print(yourEvents);
    } catch (e) {
      print(e);
    } finally {
      isYourEventsLoading.value = false;
    }
  }

  Future<void> fetchOrgs() async {
    isOrgsLoading.value = true;
    try {
      final orgsData = await firestoreService.getDocuments<Organization>(
        Organization.fromDocument,
        'organizations',
        null,
        null,
      );
      orgs.clear();
      orgs.addAll(orgsData);
      print(orgs);
    } catch (e) {
      print(e);
    } finally {
      isOrgsLoading.value = false;
    }
  }

  void handleDrawerToggle() {
    drawerController.toggleDrawer();
  }
}
