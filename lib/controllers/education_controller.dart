import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EducationController extends GetxController {
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController degreeController = TextEditingController();
  final TextEditingController fieldOfStudyController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  var textFieldControllers =
      List<TextEditingController>.empty(growable: true).obs;

}