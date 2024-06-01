import 'package:flutter/material.dart';
import 'package:flutter_app/theme/colors.dart'; // Import your color constants here

Widget searchBarWithFilterIcon({
  required TextEditingController searchController,
  required Color colour,
  required Function() onFilterPressed,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: const [
        BoxShadow(
          color: WorkWiseColors.greyColor,
          blurRadius: 16,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: WorkWiseColors.lightGreyColor,
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: WorkWiseColors.greyColor,
                    ),
                    prefixIcon: Icon(Icons.search, color: colour),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 12.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8.0),
        InkWell(
          onTap: onFilterPressed,
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: colour,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Icon(Icons.filter_list_alt, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
