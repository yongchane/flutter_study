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
  //TickerProviderStateMixin은 애니메이션을 관리하기 위해 사용하는 Mixin
  //Ticker: 매 프레임마다 애니메이션을 갱신해주는 타이머 역할
  //vsync: 애니메이션이 화면의 리소스를 절약,불필요한 애니메이션이 발생하지 않도록, 현재 화면이 활성화될 때만 애니메이션을 실행
  TabController? controller; // 탭 전환을 제어하는 컨트롤러
  double threshold = 2.7;
  int number = 1;
  late StreamSubscription<AccelerometerEvent> accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    //tap 명령을 처리해 줄 controller 등록
    controller = TabController(length: 3, vsync: this);
    //	vsync: this: TickerProviderStateMixin을 사용해 현재 클래스가 vsync를 제공
    controller!.addListener(tabListener);
    //addListener()는 탭의 상태나 변경 사항을 감지하여 콜백 함수를 실행하도록 하는 메서드 , !를 사용하여 null이 아님을 알림

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
 // listener 함수 등록
  tabListener() {
    setState(() {});
  }
// listener함수 등록 취소
  @override
  void dispose() {
    controller!.removeListener(tabListener);// listener에 등록한 함수 등록 취소
    accelerometerSubscription.cancel(); // 스트림 구독 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView( // 탭 화면을 보여줄 위젯 탭의 내용을 슬라이드로 보여줌 사용자의 손가락을 통해 좌우로 넘겨 다른 탭을 보여줌
        // 즉 TabBarView는 탭에 해당하는 페이지를 보여줄 위젯
        controller: controller,
        children: renderChildren(), // 각 탭에 보여줄 위젯 리스트
      ),
      bottomNavigationBar: renderBottomNavigation(), // 아래 탭 네비세이션을 구현한느 매개변수
      //bottomNavigationBar는 화면 하단에 고정된 네비게이션 메뉴를 구현
    );
  }
// 탭이 옮길때마다 해당하는 텍스트 위젯이 나타남
  List<Widget> renderChildren() {
    return [
      HomeScreen(number: number), // number 값을 전달하는 HomeScreen 생성자
      SettingsScreen( // 기존에 있던 Container 코드를 통째로 교체
        threshold: threshold,
        onThresholdChange: onThresholdChange,
      ),
      // 랜덤 번호 발생 버튼을 포함한 화면 추가
      Center(
        child: ElevatedButton(// ElevatedButton**은 입체감 있는 버튼
          onPressed: generateRandomNumber,
          child: const Text('랜덤 주사위 번호 생성'),
          //const는 컴파일 타임에 값이 결정되는 상수 즉, 앱 실행 중에 변하지 않는 값을 미리 고정
          // 주로 성능 최적화를 위헤 쓰임
        ),
      ),
    ];
  }
// 슬라이더값 변경시 실행 함수
  void onThresholdChange(double val) {
    setState(() {
      threshold = val;
    });
  }

  BottomNavigationBar renderBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: controller!.index,
      onTap: (int index) { // 탭이 선택될 때마다 실행되는 함수
        setState(() {
          controller!.animateTo(index);
        });
      },
      items: [
        BottomNavigationBarItem( // 하단 탭바의 각 버튼을 구현
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