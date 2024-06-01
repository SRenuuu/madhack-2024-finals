import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/job_response.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../widgets/job_card.dart';

class HomeController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  final ApiService apiService = Get.find<ApiService>();

  // Home View
  final TextEditingController searchController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isRecommendedJobPostsLoading = false.obs;
  final RxBool isMostPopularJobPostsLoading = false.obs;
  final RxBool isJobTagsLoading = false.obs;

  final RxList<String> jobTagsList = RxList<String>([]);
  final RxList<JobPosting> recommendedJobPosts = RxList<JobPosting>([]);
  final RxList<JobPosting> mostPopularJobPosts = RxList<JobPosting>([]);

  Future<void> fetchJobTags() async {
    isJobTagsLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    jobTagsList.value = [
      "Software Engineer",
      "Data Scientist",
      "UX/UI Designer"
    ];
    isJobTagsLoading.value = false;
  }

  Future<void> fetchRecentJobPostings() async {
    isRecommendedJobPostsLoading.value = true;

    Response? response = await apiService.sendGetRequest(
      true,
      "/job/all",
    );

    List<JobResponse> jobPosting = response?.body["data"]
        .map<JobResponse>((job) => JobResponse.fromJson(job))
        .toList();

    print(jobPosting);

    recommendedJobPosts.value = jobPosting.toList().reversed.map((e) {
      print(e.tags);
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

    isRecommendedJobPostsLoading.value = false;
  }

  Future<void> fetchRecommendedJobPosts() async {
    try {
      final response = await apiService.sendGetRequest(
        true,
        "job/all",
      );

      // print(response.body);

      if (response == null) {
        throw Exception('Failed to load job posts');
      }

      isRecommendedJobPostsLoading.value = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      recommendedJobPosts.value = [];
    }
  }

  Future<void> fetchMostPopularJobPosts() async {
    isMostPopularJobPostsLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    mostPopularJobPosts.value = [
      JobPosting(
        id: "1",
        title: "Junior Web Developer",
        location: "CodeSphere - Colombo, Sri Lanka",
        description: "We are looking for a junior web developer...",
        image:
            "https://foyr.com/learn/wp-content/uploads/2021/08/modern-office-design.png",
        salaryValue: "\$8K",
        salaryFrequency: "Mo",
        tags: ["Remote", "Full Time", "New"],
        isSaved: true,
      ),
      JobPosting(
        id: "2",
        title: "Junior Web Developer",
        location: "CodeSphere - Colombo, Sri Lanka",
        description: "We are looking for a junior web developer...",
        image:
            "https://foyr.com/learn/wp-content/uploads/2021/08/modern-office-design.png",
        salaryValue: "\$8K",
        salaryFrequency: "Mo",
        tags: ["Remote", "Full Time", "New"],
        isSaved: true,
      ),
      JobPosting(
        id: "3",
        title: "Junior Web Developer",
        location: "CodeSphere - Colombo, Sri Lanka",
        description: "We are looking for a junior web developer...",
        image:
            "https://foyr.com/learn/wp-content/uploads/2021/08/modern-office-design.png",
        salaryValue: "\$8K",
        salaryFrequency: "Mo",
        tags: ["Remote", "Full Time", "New"],
        isSaved: true,
      ),
    ];
    isMostPopularJobPostsLoading.value = false;
  }

  // Search Filters view
  final TextEditingController filterLocationController =
      TextEditingController();

  Rx<String> selectedIndustry = 'Information Technology'.obs;
  Rx<String> selectedCategory = 'UI/UX'.obs;

  final industries = [
    'Information Technology',
    'Finance',
    'Healthcare',
    'Retail',
    'Manufacturing',
    'Telecommunications',
  ];

  final industryCategories = {
    'Information Technology': [
      'BA/BI',
      'UI/UX',
      'Software Development',
      'Network Administration'
    ],
    'Finance': ['Accounting', 'Financial Planning', 'Auditing'],
    'Healthcare': ['Nursing', 'Medical Technology', 'Pharmacy'],
    'Retail': ['Sales', 'Merchandising', 'Customer Service'],
    'Manufacturing': ['Production', 'Quality Assurance', 'Supply Chain'],
    'Telecommunications': [
      'Network Engineering',
      'Telecom Sales',
      'Customer Support'
    ],
  };

  void changeIndustry(String newIndustry) {
    selectedIndustry.value = newIndustry;
    // Reset category when industry changes
    selectedCategory.value = categoriesForIndustry(newIndustry).first;
    update();
  }

  void changeCategory(String newCategory) {
    selectedCategory.value = newCategory;
    update();
  }

  List<String> categoriesForIndustry(String industry) {
    return industryCategories[industry] ?? [];
  }

  final Rx<RangeValues> salaryRange = const RangeValues(50000, 250000).obs;

  final RxList<String> allTags = [
    'On-site',
    'Remote',
    'Hybrid',
    'Full Time',
    'Part Time',
    'Intern',
    'Senior',
    'New',
    'Urgent'
  ].obs;
  final RxList<String> selectedTags = <String>[].obs;

  void addTag(String tag) {
    selectedTags.add(tag);
  }

  void removeTag(String tag) {
    selectedTags.remove(tag);
  }

  @override
  void onInit() {
    super.onInit();
    fetchRecentJobPostings();
    fetchMostPopularJobPosts();
    // fetchJobTags();
    // fetchRecommendedJobPosts();
    // fetchMostPopularJobPosts();
  }
}
