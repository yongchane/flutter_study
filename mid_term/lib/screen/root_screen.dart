import 'package:flutter/material.dart';
import 'package:mid_term/screen/home_screen.dart';
import 'package:mid_term/screen/settings_screen.dart';
import 'package:mid_term/screen/pokemon_screen.dart';
import 'dart:math';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  TabController? controller; // 사용할 TabController 선언
  double threshold = 2.7;
  int number = 1;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this); // ➋
    controller!.addListener(tabListener);
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
    controller!.removeListener(tabListener); // ➌ listener에 등록한 함수 등록 취소
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
      HomeScreen(number: number),
      SettingsScreen(
        threshold: threshold,
        onThresholdChange: onThresholdChange,
      ),

      PokemonScreen(
        nums: number,
        onRoll: onPhoneShake,
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
          icon: Icon(
            Icons.edgesensor_high_outlined,
          ),
          label: '주사위',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          label: '설정',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.cake,
          ),
          label: '백만볼트',
        ),
      ],
    );
  }
}