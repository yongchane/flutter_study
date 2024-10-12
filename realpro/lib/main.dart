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
// class MyApp2 extends StatefulWidget {
//
//   @override
//   State<MyApp2> createState() => _MyApp2();
// }
//
// class _MyApp2 extends State<MyApp2> {
//   final PageController pageController = PageController();// 생성자 만들기
// // 부모 클래스로 부터 initState()
//   @override
//   void initState() {
//     super.initState();
//     // initState 안에 변경될 State내용 입력
//     Timer.periodic(
//         Duration(seconds: 3), // 주기
//             (timer) { // 콜백함수
//       int? nextPage = pageController.page?.toInt();
//       //pageController.page는 double 타입의 현재 페이지 인덱스를 반환
//       //pageController.page가 null이면 ?를 통해 예외처리를 하여 toInt가 널로 변환 만약 pageController.page?이 없으 toInt를 호출하면서 런타임 오류 발샐
//       //pageController.page?.toInt()가 null을 반환했을때 int는 null을 받을 수 없으니 ?가 없으면 런타임 오류 발생
//       if (nextPage == null) {
//         return;
//       }
//       if (nextPage == 4) {
//         nextPage = 0;
//       } else {
//         nextPage ++;
//       }
//       pageController.animateToPage(
//         nextPage, duration: Duration(milliseconds: 100), curve: Curves.ease,);
//       //animateToPage: PageView를 다음 페이지로 전환할 때 애니메이션을 적용
//               // Curves.ease: 애니메이션을 점점 빨라졌다가 부드럽게 멈추는 곡선 효과로 설정합니다.
//     }
//     );
//   }
//   @override
//   Widget build (BuildContext context){
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light)
//     return Scaffold(
//       body: PageView(
//         controller: pageController,
//         children: [1,2,3,4,5].map((number)=>Image.asset("asset/img/img$number.jpg")).toList(),
//       ),
//     );
//   }
// }

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: PageView(
        children: [1, 2, 3, 4, 5].map(
              (number) =>
              Image.asset(
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
              (number) =>
              Image.asset(
                'asset/img/img$number.jpg',
                fit: BoxFit.cover,
              ),
        )
            .toList(),
      ),
    );
  }
}