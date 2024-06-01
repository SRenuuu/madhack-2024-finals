import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SkillsController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxList<String> skills = RxList<String>(["Java", "Python", "Flutter"]);

  void addSkill(String skill) {
    skills.add(skill);
    searchController.text = "";
    update();
  }

  void removeSkill(String skill) {
    skills.remove(skill);
    update();
  }
}
