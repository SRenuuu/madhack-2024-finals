import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../models/employer_job_response.dart';
import '../../services/api_service.dart';
import '../../services/auth_service.dart';
import '../../widgets/job_card.dart';

class EmployerHomeController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  final ApiService api = Get.find<ApiService>();
  final TextEditingController searchController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isRecommendedJobPostsLoading = false.obs;
  final RxBool isRecentJobPostsLoading = false.obs;
  final RxBool isJobTagsLoading = false.obs;

  final RxList<String> jobTagsList = RxList<String>([]);
  final RxList<JobPosting> recentJobPosts = RxList<JobPosting>([]);
  final RxList<JobPosting> mostPopularJobPosts = RxList<JobPosting>([]);

  Future<void> fetchRecentJobPostings() async {
    isRecentJobPostsLoading.value = true;

    Response? response = await api.sendGetRequest(
      true,
      "/job/filter/employer",
    );

    List<EmployerJobResponse> jobPosting = response?.body["data"]
        .map<EmployerJobResponse>((job) => EmployerJobResponse.fromJson(job))
        .toList();

    recentJobPosts.value = jobPosting.toList().map((e) {
      return JobPosting(
        id: e.id,
        title: e.title,
        location: e.location,
        description: e.description,
        image:
            "https://foyr.com/learn/wp-content/uploads/2021/08/modern-office-design.png",
        salaryValue:
            '${e.salaryRange.currency} ${e.salaryRange.high.round().toString()}',
        salaryFrequency: "Mo",
        tags: e.tags.length == 1
            ? e.tags[0]
                .split(",")
                .take(2)
                .map((e) => e.replaceAll("[", "").replaceAll("]", ""))
                .toList()
                .reversed
                .toList()
            : e.tags,
        isSaved: true,
      );
    }).toList();

    isRecentJobPostsLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
