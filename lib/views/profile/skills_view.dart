import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/skills_controller.dart';
import '../../theme/colors.dart';
import '../../widgets/form_text_field.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    SkillsController controller = Get.put(SkillsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Skills'),
      ),
      body: Obx(
          () => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              formTextField(
                label: "",
                showLabel: false,
                controller: controller.searchController,
                onSubmitted: (skill) => controller.addSkill(skill),
                prefixIcon: const Icon(Icons.search,
                    size: 20.0, color: WorkWiseColors.primaryColor),
              ),
              const SizedBox(height: 16.0),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8.0,
                runSpacing: 4.0,
                children: controller.skills.map((skill) => _SkillChip(
                  skill: skill,
                  onRemove: () => controller.removeSkill(skill),
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String skill;
  final VoidCallback onRemove;

  const _SkillChip({super.key, required this.skill, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(skill),
      deleteIcon: const Icon(Icons.close), // Use Icon directly for simplicity
      onDeleted: onRemove, // Set onDeleted property for delete functionality
      backgroundColor: Colors.grey[200],
      shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(10)))
    );
  }
}
