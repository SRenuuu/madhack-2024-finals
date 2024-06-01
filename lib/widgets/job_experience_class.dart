import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/colors.dart';

class JobExperienceCard extends StatelessWidget {
  final String company;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final bool isCurrent;
  final String position;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const JobExperienceCard({
    Key? key,
    required this.company,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.isCurrent,
    required this.position,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: Colors.white, // Set background color to white
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Position as title
            Text(
              position,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              company,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: WorkWiseColors.primaryColor,
              ),
            ),
            const SizedBox(height: 12.0),
            // Date Range
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16.0,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4.0),
                Text(
                  '${DateFormat('MMM yyyy').format(startDate)} - ${DateFormat('MMM yyyy').format(endDate)}',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Description
            Text(
              description,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Edit button
                TextButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(
                    Icons.edit,
                    color: WorkWiseColors.primaryColor,
                  ),
                  label: const Text(
                    'Edit',
                    style: TextStyle(color: WorkWiseColors.primaryColor),
                  ),
                ),
                const SizedBox(width: 8.0),
                // Delete button
                TextButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  label: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
