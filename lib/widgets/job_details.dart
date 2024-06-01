import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/job_tag.dart';

import '../theme/colors.dart';

class JobDetails extends StatelessWidget {
  final String jobType; // "Onsite", "Online", or "Hybrid"
  final String employmentType; // "Full Time" or "Part Time"
  final String salaryRange;
  final String salaryValue;
  final String salaryFrequency;

  const JobDetails({
    super.key,
    required this.jobType,
    required this.employmentType,
    required this.salaryRange,
    required this.salaryValue,
    required this.salaryFrequency,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              jobTag(
                  tag: jobType, backgroundColor: Colors.blueGrey, fontSize: 12),
              const SizedBox(width: 2),
              jobTag(
                  tag: employmentType,
                  backgroundColor: Colors.teal,
                  fontSize: 12),
            ],
          ),
        ),
        // const Spacer(),
        Row(
          children: [
            Text(
              "\$$salaryValue",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 2.0),
            Text(
              "/$salaryFrequency",
              style: const TextStyle(
                color: WorkWiseColors.darkGreyColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        )
      ],
    );
  }
}
