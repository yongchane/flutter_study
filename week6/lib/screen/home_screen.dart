import 'package:week6/const/colors.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  final int number; //주사위 번호 번호 처리
// 주사위 번호는 RootScreen에서 생성됨
  const HomeScreen({
    required this.number, //주사위 번호 처리
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ Center(// ➊ 주사위 이미지
          child: Image.asset('asset/img/$number.png'),
        ),
          SizedBox(height: 32.0),
          Text(
            '행운의 숫자',
            style: TextStyle(
              color: secondaryColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            number.toString(), // ➋ 주사위 값에 해당되는 숫자
            style: TextStyle(
              color: primaryColor,
              fontSize: 60.0,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
    );
  }
}