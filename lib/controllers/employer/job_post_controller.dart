import 'package:flutter/material.dart';
import 'package:flutter_app/models/create_job_request.dart';
import 'package:flutter_app/theme/colors.dart';
import 'package:flutter_app/views/job_posting/range_picker.dart';
import 'package:flutter_app/widgets/form_dropdown_field.dart';
import 'package:flutter_app/widgets/form_text_field.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/create_job_response.dart';
import '../../services/api_service.dart';
import '../../util/constants.dart';

class JobPostController extends GetxController {
  final TextEditingController positionController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController requirementsController = TextEditingController();
  final TextEditingController responsibilitiesController =
      TextEditingController();
  final TextEditingController aboutCompanyController = TextEditingController();
  RxInt currentStep = 0.obs;

  final ApiService api = Get.find<ApiService>();

  var textFieldControllers =
      List<TextEditingController>.empty(growable: true).obs;

  Rx<String?> selectedIndustry = Rx<String?>(null);
  RxList<String> industries = ['Industry 1', 'Industry 2', 'Industry 3'].obs;

  Rx<String?> selectedCategory = Rx<String?>(null);
  RxList<String> categories = ['Category 1', 'Category 2', 'Category 3'].obs;

  Rx<String?> selectedJobType = Rx<String?>(null);
  RxList<String> jobTypes = ['Type 1', 'Type 2', 'Type 3'].obs;

  Rx<String?> selectedWorkspace = Rx<String?>(null);
  RxList<String> workspaces = ['Workspace 1', 'Workspace 2', 'Workspace 3'].obs;

  // Rx variables for start and end salary
  Rx<double> startSalary = 0.0.obs;
  Rx<double> endSalary = 0.0.obs;

  Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);

  void addTextField() {
    textFieldControllers.add(TextEditingController());
    update();
  }

  void removeTextField(int index) {
    textFieldControllers.removeAt(index);
    update();
  }

  void changeIndustry(String newIndustry) {
    print('Selected Industry: $newIndustry');
    selectedIndustry.value = newIndustry;
  }

  void changeCategory(String newCategory) {
    selectedCategory.value = newCategory;
  }

  void changeJobType(String newJobType) {
    selectedJobType.value = newJobType;
  }

  void changeWorkspace(String newWorkspace) {
    selectedWorkspace.value = newWorkspace;
  }

  void nextStep() {
    if (currentStep.value < getSteps().length - 1) {
      currentStep.value++;
      update(); // Add this line to trigger UI update
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
      update();
    }
  }

  void goToStep(int step) {
    currentStep.value = step;
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep.value > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep.value >= 0,
        title: const Text(""),
        content: _buildDescriptionStep(),
      ),
      Step(
        state: currentStep.value > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep.value >= 1,
        title: const Text(""),
        content: _searchLocationWidget(),
      ),
      Step(
        state: currentStep.value > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep.value >= 2,
        title: const Text(""),
        content: _buildSalaryStep(),
      ),
      Step(
        state: currentStep.value > 3 ? StepState.complete : StepState.indexed,
        isActive: currentStep.value >= 3,
        title: const Text(""),
        content: _buildDetailsStep(),
      ),
    ];
  }

  Widget _buildDescriptionStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Description",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
        const SizedBox(height: 25.0),
        //industries
        formDropdownField(
            prefixIcon: const Icon(Icons.apartment_sharp,
                size: 20.0, color: WorkWiseColors.primaryColor),
            label: 'Industries',
            items: industries,
            selectedValue: selectedIndustry.value,
            onChanged: (val) => changeIndustry(val!)),
        const SizedBox(height: 15.0),
        //categories
        formDropdownField(
            prefixIcon: const Icon(Icons.category_sharp,
                size: 20.0, color: WorkWiseColors.primaryColor),
            label: 'Categories',
            items: categories,
            selectedValue: selectedCategory.value,
            onChanged: (val) => changeCategory(val!)),
        const SizedBox(height: 20.0),
        //positions
        formTextField(
            label: 'Position',
            prefixIcon: const Icon(Icons.work,
                size: 20.0, color: WorkWiseColors.primaryColor),
            controller: positionController,
            keyboardType: TextInputType.text),
        const SizedBox(height: 20.0),
        //job types
        formDropdownField(
            prefixIcon: const Icon(Icons.business_center_sharp,
                size: 20.0, color: WorkWiseColors.primaryColor),
            label: 'Job Types',
            items: jobTypes,
            selectedValue: selectedJobType.value,
            onChanged: (val) => changeJobType(val!)),
        const SizedBox(height: 20.0),
        //workspaces
        formDropdownField(
            prefixIcon: const Icon(Icons.add_location_alt_sharp,
                size: 20.0, color: WorkWiseColors.primaryColor),
            label: 'Workspaces',
            items: workspaces,
            selectedValue: selectedWorkspace.value,
            onChanged: (val) => changeWorkspace(val!)),
        const SizedBox(height: 15.0),
      ],
    );
  }

  Widget _searchLocationWidget() {
    // Removed context parameter

    return Column(
      children: [
        formTextField(
            maxLines: 4,
            label: 'Job Location',
            controller: locationController,
            keyboardType: TextInputType.text),
        const SizedBox(height: 10.0),
      ],
    );
  }

  void onLocationSelected(LatLng? location) {}

  Widget _buildSalaryStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Salary",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
        RangePickerWidget(
          initialValueStart: startSalary.value,
          initialValueEnd: endSalary.value,
          onRangeStartChanged: (startValue) {
            startSalary.value = startValue;
          },
          onRangeEndChanged: (endValue) {
            endSalary.value = endValue;
          },
        ),
        const SizedBox(height: 200),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Start',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                Obx(() => Text('LKR ${startSalary.value.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 20))),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('End',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                Obx(() => Text('LKR ${endSalary.value.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 20))),
              ],
            ),
          ],
        ),
        SizedBox(height: 35)
      ],
    );
  }

  Widget _buildDetailsStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Details",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
        const SizedBox(height: 15),
        formTextField(
            maxLines: 4,
            label: 'Job Description',
            controller: descriptionController,
            keyboardType: TextInputType.text),
        const SizedBox(height: 15.0),
        formTextField(
            maxLines: 4,
            label: 'Requirements',
            controller: requirementsController,
            keyboardType: TextInputType.text),
        const SizedBox(height: 15.0),
        formTextField(
            maxLines: 4,
            label: 'Responsibilities',
            controller: responsibilitiesController,
            keyboardType: TextInputType.text),
        const SizedBox(height: 15.0),
        formTextField(
            maxLines: 4,
            label: 'About Company',
            controller: aboutCompanyController,
            keyboardType: TextInputType.text),
        const SizedBox(height: 15.0),
      ],
    );
  }

  Widget buildControls(
      BuildContext context, ControlsDetails details, bool isLastStep) {
    return Row(
      children: [
        if (details.stepIndex != 0) // Show only if not in the first step
          Expanded(
            child: ElevatedButton(
              onPressed: details.onStepCancel,
              style: ElevatedButton.styleFrom(
                backgroundColor: WorkWiseColors.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: const Text('Previous'),
            ),
          ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              if (isLastStep) {
                if (await submitJobPost()) {
                  Get.snackbar(
                    icon: const Icon(
                      Icons.check_circle,
                      size: 26,
                      color: Colors.white,
                    ),
                    shouldIconPulse: true,
                    "Success",
                    "Job post created successfully",
                    colorText: Colors.white,
                    backgroundColor: Colors.green.shade700.withOpacity(0.9),
                  );
                  Get.offAllNamed("/employer-home");
                  destroy();
                } else {
                  Get.snackbar(
                    icon: const Icon(
                      Icons.error,
                      size: 26,
                      color: Colors.white,
                    ),
                    shouldIconPulse: true,
                    "Error",
                    "Failed to create job post",
                    colorText: Colors.white,
                    backgroundColor: Colors.red.shade700.withOpacity(0.9),
                  );
                }
              } else {
                details.onStepContinue!();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: WorkWiseColors.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            child: Text(isLastStep ? 'Finish' : 'Next'),
          ),
        ),
      ],
    );
  }

  Future<bool> submitJobPost() async {
    CreateJobRequest jobPostData = CreateJobRequest(
      title: positionController.text,
      description: descriptionController.text,
      requirements: [requirementsController.text],
      responsibilities: [responsibilitiesController.text],
      location: locationController.text,
      salaryRange: (SalaryRange(
          low: startSalary.value, high: endSalary.value, currency: 'LKR')),
      tags: ['Remote', 'Full Time'],
    );

    print(jobPostData.toJson());

    CreateJobResponse createJobResponse =
        CreateJobResponse.fromJson((await api.sendPostRequest(
      true,
      Constants.createJobPostEndpoint,
      data: jobPostData.toJson(),
    ))
            ?.body);

    if (createJobResponse.status == 'success') {
      return true;
    } else {
      return false;
    }
  }

  @override
  void onClose() {
    positionController.dispose();
    descriptionController.dispose();
    requirementsController.dispose();
    responsibilitiesController.dispose();
    aboutCompanyController.dispose();
    super.onClose();
  }

  void destroy() {
    Get.delete<JobPostController>();
  }
}
