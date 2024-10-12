import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime firstDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea( //화면 안전한 영역 내에 위젯을 배치
        // 주로 노치(Notch), 상태바(Status Bar), 네비게이션 바(Navigation Bar) 같은 시스템 UI에 의해 콘텐츠가 가려지는 것을 방지하기 위해 사용
        top: true, // 상단 영역에 안전한 공간 확보
        bottom: false, // 하단 네이게이션 바 무시
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // Colum으로 위젯들을 위아래로 정렬
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // 위젯을 양옆으로 확장 ,stretch는 자식축 위젯 교차축 방향으로 가능한 최대 크기로 확장하게함
          children: [
            _DDay(
              onHeartPressed: onHeartPressed,
              firstDay: firstDay,
            ),
            _GersImage(),
          ],
        ),
      ),
    );
  }

  void onHeartPressed() {
    showCupertinoDialog( //아이폰 스타일의 다이얼로그 실행
      context: context, // 현재 위젯의 위치 정보 제공, 어디서 다이얼로그 열지 알려줌
      builder: (BuildContext context) { // 다이얼로그 안에 표시할 위젯을 반환
        return Align( // Align: 자식 위젯을 부모 위젯안에서 특정 위치에 정렬시키는데 사용
          alignment: Alignment.bottomCenter,
          // 자식 위젯을 화면 하단 중앙에 배치 (아래에 있는 Container)
          child: Container(
            color: Colors.white,
            height: 300,
            child: CupertinoDatePicker( // 아이폰 스타일의 날짜 선택기
              mode: CupertinoDatePickerMode.date,
              // 모드를 통해 날짜, 시간 또는 둘다(dateAndTime) 선택하게 설정 가능
              onDateTimeChanged: (DateTime date) { // 사용자가 날짜를 선택할때 마 호출되는 콜백함수
                setState(() { // 날짜가 변경됬음을 flutter에게 알리 ui를 재 빌드업
                  firstDay = date;
                });
              },
            ),
          ),
        );
      },
      barrierDismissible: true, // true를 했을때 다이얼로그 외부 클릭하면 닫힘
    );
  }
}

class _DDay extends StatelessWidget {
  final GestureTapCallback onHeartPressed;
  final DateTime firstDay;

  //StatelessWidget은 상태가 변하지 않는 위젯이므로, 필드에 final 키워드를 사용해 생성 이후 값을 고정합니다.
  // final은 필드 ,필드는 클래스 인스턴스가 가지고 있을 데이터를 정의
  _DDay({
    required this.onHeartPressed,
    required this.firstDay,
    //생성자는 인스턴스를 생성할 때 필드에 값을 전달하는 역할
  });

//위 코드에서는 생성자를 통해 필드에 초기값을 전달
  //required 키워드를 사용한 이유는 이 값들이 반드시 필요하다는 것을 명시
  //즉, 인스턴스를 생성할 때 반드시 값을 넘겨줘야 컴파일 오류가 발생하지 않는다

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    final now = DateTime.now();

    return Column(
      children: [
        const SizedBox(height: 16.0),
        Text(
          'I&GE',
          style: textTheme.displayLarge, // headline1 -> displayLarge
        ),
        const SizedBox(height: 16.0),
        Text(
          '우리 처음 만난 날',
          style: textTheme.bodyLarge, // bodyText1 -> bodyLarge
        ),
        Text(
          '${firstDay.year}.${firstDay.month}.${firstDay.day}',
          style: textTheme.bodyMedium, // bodyText2 -> bodyMedium
        ),
        const SizedBox(height: 16.0),
        IconButton(
          iconSize: 60.0,
          onPressed: onHeartPressed,
          icon: const Icon(
            Icons.favorite, // 하트모양 아이콘
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          'D+${DateTime(now.year, now.month, now.day)
              .difference(firstDay)
              .inDays + 1}',
          //DateTime()이건 현재시간 ditterence는 현재 날짜와 차이점 .inDays를 통 두날짜 차이를 일로 반환
          style: textTheme.displayMedium, // headline2 -> displayMedium
        ),
      ],
    );
  }
}

class _GersImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded( // 위젯을 가능한 공간에 맞춰 확장 주로 Row, Column, 또는 Flex 위젯 내에서 사용
// Expanded 추가
      child: Center(
// ➊ 이미지 중앙정렬
        child: Image.asset(
          'asset/img/pngwing.com.png',
// ➋ 화면의 반만큼 높이 구현
          height: MediaQuery
              .of(context)
              .size
              .height / 2,
          //MediaQuery: 화면의 크기와 방향 등을 조회할 수 있게 해주는 객체로, 반응형 디자인을 구현하는 데 필수
        ),
      ),
    );
  }
}

