import 'package:flutter/material.dart';
import 'package:flutter_app/theme/colors.dart';
import 'package:flutter_app/widgets/job_tag.dart';

import 'flag.dart';

class JobPosting {
  final String id;
  final String title;
  final String location;
  final String? description;
  final String? image;
  final String? salaryValue;
  final String? salaryFrequency;
  final List<String> tags;
  final bool? isSaved;

  JobPosting({
    required this.id,
    required this.title,
    required this.location,
    required this.description,
    required this.image,
    required this.salaryValue,
    required this.salaryFrequency,
    required this.tags,
    required this.isSaved,
  });
}

class EventCard extends StatelessWidget {
  final VoidCallback onCardTap;
  final JobPosting jobPosting;
  final bool showSaveButton;
  final bool showDescription;
  final bool showTags;
  final bool showSalary;
  final bool showShadow;
  final bool showBorder;
  final double borderRadius;
  final Color backgroundColor;
  final double cardWidth;
  final Icon fallbackIcon;
  final Color fallbackBackgroundColor;
  final Color shadowColor;
  final String? flagText; // Optional flag text

  const EventCard({
    super.key,
    required this.onCardTap,
    required this.jobPosting,
    this.showSaveButton = true,
    this.showDescription = true,
    this.showShadow = true,
    this.showBorder = false,
    this.borderRadius = 12.0,
    this.backgroundColor = Colors.white,
    this.cardWidth = double.infinity,
    this.showTags = true,
    this.showSalary = true,
    this.fallbackIcon = const Icon(
      Icons.handshake,
      color: Colors.white,
    ),
    this.fallbackBackgroundColor = WorkWiseColors.secondaryColor,
    this.shadowColor = WorkWiseColors.greyColor,
    this.flagText = "Sample",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        boxShadow: [
          showShadow
              ? BoxShadow(
                  color: shadowColor,
                  blurRadius: 20.0,
                  offset: Offset(0, 8.0),
                  spreadRadius: 0,
                )
              : const BoxShadow(
                  color: Colors.transparent,
                  blurRadius: 0,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                ),
        ],
        border: showBorder
            ? Border.all(
                color: WorkWiseColors.darkGreyColor,
                width: 1.0,
              )
            : null,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: GestureDetector(
        onTap: () => onCardTap(),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Stack(
            // Use Stack for layering
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 140.0,
                      decoration: BoxDecoration(
                        color: WorkWiseColors.secondaryColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: jobPosting.image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                'https://foyr.com/learn/wp-content/uploads/2021/08/modern-office-design.png',
                                fit: BoxFit.cover,
                              ),
                            )
                          : fallbackIcon,
                    ),
                    const SizedBox(width: 8.0),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                jobPosting.title,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: WorkWiseColors.primaryColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                jobPosting.location,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: WorkWiseColors.darkGreyColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Flag element positioned on top right
              if (flagText != null)
                Positioned(
                  right: 20.0,
                  child: Flag(
                    triangleColor: Colors.white, // Currently not used
                    textValue: '3',
                    textLabel: 'Days',
                    size: 60.0,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
