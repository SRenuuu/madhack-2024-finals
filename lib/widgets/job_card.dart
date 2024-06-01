import 'package:flutter/material.dart';
import 'package:flutter_app/theme/colors.dart';
import 'package:flutter_app/widgets/job_tag.dart';

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

class JobCard extends StatelessWidget {
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

  const JobCard({
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
      Icons.work,
      color: Colors.white,
    ),
    this.fallbackBackgroundColor = WorkWiseColors.secondaryColor,
    this.shadowColor = WorkWiseColors.greyColor,
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
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: GestureDetector(
        onTap: () => onCardTap(),
        child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 64.0,
                          height: 64.0,
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
                              : fallbackIcon),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: Column(
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      // save button with icon
                      showSaveButton && jobPosting.isSaved != null
                          ? jobPosting.isSaved == true
                              ? const Icon(
                                  size: 28,
                                  Icons.bookmark,
                                  color: WorkWiseColors.accentColor,
                                )
                              : const Icon(
                                  size: 28,
                                  Icons.bookmark_add_outlined,
                                  color: WorkWiseColors.darkGreyColor,
                                )
                          : Container(),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  showDescription && jobPosting.description != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              jobPosting.description!,
                              style: const TextStyle(
                                color: WorkWiseColors.darkGreyColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      showTags
                          ? Expanded(
                              child: Row(
                                children: jobPosting.tags
                                    .map((tag) => jobTag(tag: tag))
                                    .toList(),
                              ),
                            )
                          : Container(),
                      showSalary
                          ? Row(
                              children: [
                                Text(
                                  jobPosting.salaryValue != null
                                      ? jobPosting.salaryValue!
                                      : "",
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 2.0),
                                Text(
                                  jobPosting.salaryFrequency != null
                                      ? "/${jobPosting.salaryFrequency!}"
                                      : "",
                                  style: const TextStyle(
                                    color: WorkWiseColors.darkGreyColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
