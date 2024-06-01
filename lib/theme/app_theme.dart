import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData getTheme() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      primaryColor: WorkWiseColors.primaryColor,
      hintColor: WorkWiseColors.accentColor,
      scaffoldBackgroundColor: Colors.white,
      splashColor: WorkWiseColors.accentColor,
      highlightColor: WorkWiseColors.accentColor,
      cardColor: Colors.white,
      textSelectionTheme: const TextSelectionThemeData(
        selectionHandleColor: WorkWiseColors.primaryColor,
        cursorColor: WorkWiseColors.primaryColor,
        selectionColor: WorkWiseColors.accentColor,
      ),
      // textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      inputDecorationTheme: _buildInputDecorationTheme(
        base.inputDecorationTheme,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: WorkWiseColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          textStyle: const TextStyle(fontSize: 17.0),
          foregroundColor: Colors.white,
          backgroundColor: WorkWiseColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          textStyle: const TextStyle(fontSize: 17.0),
          foregroundColor: WorkWiseColors.primaryColor,
          side: const BorderSide(
            color: WorkWiseColors.primaryColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        tabBarTheme: TabBarTheme(
          indicatorColor: WorkWiseColors.primaryColor,
          labelColor: WorkWiseColors.primaryColor,
          unselectedLabelColor: Colors.grey,
          overlayColor: MaterialStateProperty.all(
              WorkWiseColors.primaryColor.withOpacity(0.1)),
        ),
        // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        //   selectedItemColor: WorkWiseColors.primaryColor,
        //   unselectedItemColor: Colors.grey,
        //   backgroundColor: Colors.white,
        //   elevation: 0.0,
        // ),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          color: WorkWiseColors.primaryColor.withOpacity(0.05),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.white,
        ));
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      displayLarge:
          base.displayLarge?.copyWith(color: WorkWiseColors.primaryColor),
      headlineLarge:
          base.headlineLarge?.copyWith(color: WorkWiseColors.primaryColor),
      titleLarge: base.titleLarge?.copyWith(color: WorkWiseColors.primaryColor),
      bodyLarge: base.bodyLarge?.copyWith(color: WorkWiseColors.primaryColor),
      labelLarge: base.labelLarge?.copyWith(color: WorkWiseColors.primaryColor),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme(
      InputDecorationTheme base) {
    return base.copyWith(
      floatingLabelStyle: const TextStyle(color: WorkWiseColors.primaryColor),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(
          width: 2.0,
          color: WorkWiseColors.primaryColor,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(
          width: 2.0,
          color: WorkWiseColors.greyColor,
        ),
      ),
    );
  }
}
