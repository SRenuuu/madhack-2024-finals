import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/employer/job_post_controller.dart';
import 'package:flutter_app/theme/colors.dart';
import 'package:get/get.dart';

class JobPostFormView extends StatelessWidget {
  const JobPostFormView({Key? key});

  @override
  Widget build(BuildContext context) {
    final JobPostController controller = Get.put(JobPostController());
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Post Your Job'),
      ),
      body: SafeArea(
        child: Center(
          child: Theme(
            data: ThemeData(
              colorScheme: const ColorScheme.light(
                primary: WorkWiseColors.primaryColor,
              ),
            ),
            child: GetBuilder<JobPostController>(
              init: controller,
              builder: (_) => Stepper(
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  final bool isLastStep = controller.currentStep.value ==
                      controller.getSteps().length - 1;
                  return controller.buildControls(context, details, isLastStep);
                },
                type: StepperType.horizontal,
                currentStep: controller.currentStep.value,
                onStepCancel: controller.previousStep,
                onStepContinue: controller.nextStep,
                onStepTapped: controller.goToStep,
                steps: controller.getSteps(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
