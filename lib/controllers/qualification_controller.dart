import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class QualificationController extends GetxController {
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  var textFieldControllers =
      List<TextEditingController>.empty(growable: true).obs;

}