import 'package:flutter/material.dart';
import 'package:week6/screen/home_screen.dart';
import 'package:week6/screen/setting_screen.dart';
import 'dart:async'; // 추가
import 'dart:math'; // Random() 객체를 사용하기 위해 추가
import 'package:sensors_plus/sensors_plus.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  TabController? controller;
  double threshold = 2.7;
  int number = 1;
  late StreamSubscription<AccelerometerEvent> accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller!.addListener(tabListener);

    // 가속도계 스트림 구독
    accelerometerSubscription = SensorsPlatform.instance.accelerometerEvents.listen((AccelerometerEvent event) {
      // 가속도값이 threshold를 초과하는 경우 흔들림으로 간주
      if (event.x.abs() > threshold || event.y.abs() > threshold || event.z.abs() > threshold) {
        onPhoneShake();
      }
    });
  }

  void onPhoneShake() {
    final rand = Random();
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
    accelerometerSubscription.cancel(); // 스트림 구독 해제
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
          child: const Text('랜덤 주사위 번호 생성'),
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
          icon: const Icon(Icons.edgesensor_high_outlined),
          label: '주사위',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: '설정',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
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