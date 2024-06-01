import 'package:flutter_app/util/enums.dart';
import 'package:get/get.dart';

class JobPostFormController extends GetxController {
  RxInt currentStep = 0.obs;
  Rx<Industries> selectedIndustry = Industries.values.first.obs;
  Rx<Categories> selectedCategory = Categories.values.first.obs;
  Rx<JobTypes> selectedJobType = JobTypes.values.first.obs;
  Rx<TypeOfWorkspace> selectedWorkspace = TypeOfWorkspace.values.first.obs;
  RxString address = "null".obs;
  RxString autocompletePlace = "null".obs;
  RxDouble startSalary = 0.0.obs;
  RxDouble endSalary = 500000.0.obs;

  void nextStep() {
    if (currentStep.value < 4) {
      // Assuming there are 5 steps
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void setStep(int step) {
    currentStep.value = step;
  }
}
