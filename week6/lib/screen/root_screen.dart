import 'package:week6/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:week6/screen/home_screen.dart';
import 'package:week6/screen/setting_screen.dart';
import 'dart:math'; // Random() 객체를 사용하기 위해 추가
import 'package:shake/shake.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  TabController? controller;
  double threshold = 2.7;
  int number = 1;
  ShakeDetector? shakeDetector;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller!.addListener(tabListener);
    shakeDetector = ShakeDetector.autoStart(
      shakeSlopTimeMS: 100,
      shakeThresholdGravity: threshold,
      onPhoneShake: onPhoneShake,
    );
  }

  void onPhoneShake() {
    final rand = Random(); // new 키워드 제거
    setState(() {
      number = rand.nextInt(5) + 1;
    });
  }

  tabListener() {
    setState(() {});
  }

  @override
  void dispose() {
    controller!.removeListener(tabListener);
    shakeDetector?.stopListening(); // shakeDetector! 대신 널 체크 추가
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: renderChildren(),
      ),
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChildren() {
    return [
      HomeScreen(number: number), // number 값을 전달하는 HomeScreen 생성자
      SettingsScreen(
        threshold: threshold,
        onThresholdChange: onThresholdChange,
      ),
      // 랜덤 번호 발생 버튼을 포함한 화면 추가
      Center(
        child: ElevatedButton(
          onPressed: generateRandomNumber,
          child: Text('랜덤 주사위 번호 생성'),
        ),
      ),
    ];
  }

  void onThresholdChange(double val) {
    setState(() {
      threshold = val;
    });
  }

  BottomNavigationBar renderBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: controller!.index,
      onTap: (int index) {
        setState(() {
          controller!.animateTo(index);
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.edgesensor_high_outlined),
          label: '주사위',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: '설정',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: '버튼',
        ),
      ],
    );
  }

  void generateRandomNumber() {
    final rand = Random();
    setState(() {
      number = rand.nextInt(5) + 1; // 1부터 5까지의 랜덤 숫자 생성
    });
    // 현재 탭을 주사위 탭으로 변경
    controller!.animateTo(0);
  }
}