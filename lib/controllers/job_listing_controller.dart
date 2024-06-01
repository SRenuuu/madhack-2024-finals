import 'package:get/get.dart';

import '../models/job_response.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

class JobListingController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  final ApiService apiService = Get.find<ApiService>();
  final RxBool isLoading =
      true.obs; // Initialize with true to show loading initially

  // Observable variables for job details
  final RxString jobTitle = "".obs;
  final RxString companyName = "".obs;
  final RxString location = "".obs;
  final RxString jobDescription = "".obs;
  final RxList<String> requirements = <String>[].obs;
  final RxList<String> tags = <String>[].obs;
  final RxList<String> responsibilities = <String>[].obs;
  final RxString companyDescription = "".obs;
  final RxString salaryRange = "".obs;
  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;

  Future<void> fetchJobPosting(jobId) async {
    isLoading.value = true;

    // Access the jobId from the URL parameters
    // final String jobId = Get.parameters['jobId'] ?? '';
    //
    // print(jobId);

    Response? response = await apiService.sendGetRequest(
      true,
      "job/$jobId", // Assuming the endpoint to fetch a single job posting is /job/{jobId}
    );

    if (response != null && response.statusCode == 200) {
      // Parse the response into a JobResponse object
      JobResponse jobPosting = JobResponse.fromJson(response.body["data"]);

      // Update the observable variables with the fetched job posting details
      jobTitle.value = jobPosting.title;
      companyName.value = jobPosting.employer?.profile?.name ?? 'No name';
      location.value = jobPosting.location;
      jobDescription.value = jobPosting.description;
      requirements.value = jobPosting.requirements;
      responsibilities.value = jobPosting.responsibilities;
      companyDescription.value = jobPosting.description;
      salaryRange.value =
          '${jobPosting.salaryRange.currency} ${jobPosting.salaryRange.high.round().toString()}';
      latitude.value = 6.91293;
      longitude.value = 79.85360;
      tags.value = jobPosting.tags;
    } else {
      // Handle error
      print("Failed to load job posting");
    }

    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
  }
}
