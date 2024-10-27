import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:week7/component/custom_video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
  // 실제 App의 LayOut을 정의해줄 class 지정
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video; // image_picker는 xfile 자료형으로 동영상 경로를 저장함
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
// ➋ 동영상이 선택됐을 때와 선택 안 됐을때 보여줄 위젯
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }
  // 위젯을 renderEmpty,renderVideo를 선언해 컨테이너에 내용을 배치하는 걸로 다력적으로 만들어 줌
  Widget renderEmpty(){ // ➌ 동영상 선택 전 보여줄 위젯
    return Container(
      width: MediaQuery.of(context).size.width, // 넓이 최대로 늘려주기
      decoration: getBoxDecoration(),
      child: Column(
// 위젯들 가운데 정렬
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo( // 해당 class는 버튼이 터치될 때 처리를 할 것임
            onTap: onNewVideoPressed, // ontap을 통해 해당 함수로 가면 파일 선택 기능 구현함
          ), // 로고 이미지
          SizedBox(height: 30.0),
          _AppName(), // 앱 이름
        ],
      ),
    );
  }
  void onNewVideoPressed() async { // ➋ 이미지 선택하는 기능을 구현한 함수
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }
  Widget renderVideo(){
    return Center(
      child: CustomVideoPlayer(
        video: video!, // 선택한 동영상 주소를 매개변수로 전달해 줌
        onNewVideoPressed: onNewVideoPressed,
      ),
    );
  }
  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient( // ➋ 그라데이션으로 색상 적용하기
        // 그라데이션 시작점: 상단 중앙
        begin: Alignment.topCenter, //Alignment는 위젯이나 레이아웃의 위치를 정의하는 클래스
        // 그라데이션 끝점: 하단 중앙
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2A3A7C), // 상단의 색상: 파란색 계열
          Color(0xFF000118), // 하단의 색상: 거의 검정색
        ],
      ),
    );
  }
}class _Logo extends StatelessWidget { // 로고를 보여줄 위젯
  final GestureTapCallback onTap; // 위젯에 터치가 들어가야하니 onTap사용
  //ontap:onNewVideoPresse을 통해 해당 함수랑 연결됨
  const _Logo({
    required this.onTap,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // ➌ 상위 위젯으로부터 탭 콜백받기
      child: Image.asset(
        'asset/img/logo.png',
      ),
    );
  }
}
class _AppName extends StatelessWidget { // 앱 제목을 보여줄 위젯
  const _AppName({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    ); // mixin 처럼 미리 선언해서 함수처럼 쓰임
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          style: textStyle.copyWith(
// ➊ textStyle에서 두께만 700으로 변경
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

