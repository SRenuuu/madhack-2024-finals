import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/organizations/create_event_controller.dart';
import 'package:get/get.dart';

class SkillsInputField extends StatelessWidget {
  final CreateEventController controller = Get.put(CreateEventController());
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: InputDecorator(
        decoration: InputDecoration(
          border: InputBorder.none, // Remove the border
          suffixIcon: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              if (textEditingController.text.isNotEmpty) {
                controller.addSkill(textEditingController.text);
                textEditingController.clear();
              }
            },
          ),
        ),
        child: Obx(
          () => Wrap(
            spacing: 8.0,
            children: [
              for (var skill in controller.selectedSkills)
                Chip(
                  label: Text(skill),
                  onDeleted: () {
                    controller.removeSkill(skill);
                  },
                ),
              Container(
                width: 200,
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type and press enter',
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      controller.addSkill(value);
                      textEditingController.clear();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
