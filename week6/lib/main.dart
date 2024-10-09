import 'package:flutter/material.dart';
import 'package:week6/screen/root_screen.dart';
import 'package:week6/const/colors.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        sliderTheme: SliderThemeData(
          thumbColor: primaryColor,
          activeTrackColor: primaryColor,
          inactiveTrackColor: primaryColor.withOpacity(0.3),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          unselectedItemColor: secondaryColor,
          backgroundColor: backgroundColor,
        ),
      ),
      home: const RootScreen(),
    ),
  );
}