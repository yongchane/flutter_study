import 'package:flutter/material.dart';
import 'package:week6/screen/root_screen.dart';
import 'package:week6/const/colors.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData( //앱 전체에서 슬라이더의 모양을 일관성 있게 관리하며, 디자인을 쉽게 변경할 수 있도록 도와준다
        scaffoldBackgroundColor: backgroundColor,
        sliderTheme: SliderThemeData( //silder는 사용자 값을 조절할 수 있는 슬라이더 ui,
          // SliderThemeData는 Flutter의 Slider 위젯의 모양과 색상을 커스터마이즈하는 설정
          thumbColor: primaryColor, // thumbColor(손잡이) 색상을 정의
          activeTrackColor: primaryColor, //슬라이더의 채워진 부분(사용자가 조절한 부분) 색상을 정의
          //예를 들어, 슬라이더가 0부터 100까지 범위라면 50까지 채워진 부분의 색상을 primaryColor로 설정
          inactiveTrackColor: primaryColor.withOpacity(0.3), //슬라이더의 아직 채워지지 않은 부분의 색상을 지정
          //withOpacity(0.3)는 이 색상의 투명도를 30%로 줄인 값
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