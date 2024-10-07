import 'package:flutter/material.dart';
import 'package:weekfive/screen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'sunflower',
        textTheme: TextTheme(
          displayLarge: TextStyle( // headline1 -> displayLarge
            color: Colors.white, // Color.white -> Colors.white
            fontSize: 80.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'parisienne',
          ),
          displayMedium: TextStyle( // headline2 -> displayMedium
            color: Colors.white, // Color.white -> Colors.white
            fontSize: 50.0,
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle( // bodyText1 -> bodyLarge
            color: Colors.white, // Color.white -> Colors.white
            fontSize: 30.0,
          ),
          bodyMedium: TextStyle( // bodyText2 -> bodyMedium
            color: Colors.white, // Color.white -> Colors.white
            fontSize: 20.0,
          ),
        ),
      ),
      home: HomeScreen(), // 'home' inside the MaterialApp
    ),
  );
}