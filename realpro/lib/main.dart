import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MaterialApp(
        home: HomeScreen2(),
      )
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: PageView(
        children: [1, 2, 3, 4, 5].map(
              (number) => Image.asset(
            'asset/img/img$number.jpg',
          ),
        ).toList(),
      ),
    );
  }
}

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen2> {
  final PageController pageController = PageController();
  bool isForward = true; // 슬라이드 방향을 관리할 변수

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 2), (timer) {
      int? currentPage = pageController.page?.toInt();
      if (currentPage == null) {
        return;
      }

      if (isForward) {
        // 앞으로 가는 방향
        if (currentPage == 4) {
          isForward = false; // 끝까지 가면 방향을
        } else {
          currentPage++;
        }
      } else {
        // 뒤로 가는 방향
        if (currentPage == 0) {
          isForward = true; // 첫 페이지까지 가면 방향을 다시 바
        } else {
          currentPage--;
        }
      }

      pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 3000),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [1, 2, 3, 4, 5] // List 자료형, List.map() 함수 활용
            .map(
              (number) => Image.asset(
            'asset/img/img$number.jpg',
            fit: BoxFit.cover,
          ),
        )
            .toList(),
      ),
    );
  }
}