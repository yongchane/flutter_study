import 'package:flutter/material.dart';
import 'package:weekfive/screen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(//theme: 앱 전반적인 스타일과 테마를 정의하 속, themeData는 앱의 테마를 구성하는 클라 정의하는 스타일이 앱의 전체에 적용
        fontFamily: 'sunflower',
        textTheme: TextTheme(
          displayLarge: TextStyle( // headline1 -> displayLarge
            // TextStyle은 앱에 적용되는 모든 텍스트 스타일을 한번에 적용
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