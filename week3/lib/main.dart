import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MaterialApp(home: HomeScreen()));
}

class HomeScreen extends StatelessWidget {
  WebViewController webViewController = WebViewController() // 웹 뷰를 제어하기 위한 객체
    ..loadRequest(
        Uri.parse("http://www.smu.ac.kr")) // uri.parse:webview 형 uri 자료형으로 변형
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  TextEditingController txtcr = TextEditingController();

  //txtcr는 TextField의 내용을 저장하는 데 사용될 TextEditingController의 인스턴스
  //TextEditingController는 Flutter의 텍스트 필드(TextField 또는 TextFormField)의 상태를 관리하는 역할
  //사용자가 텍스트 필드에 입력한 내용을 제어하고 가져올 수 있도록 돕는 컨트롤러 객체

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffff5439),
        title: Column(children: [
          Text(
            "Smu",
            style: TextStyle(
                color: Colors.blue, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  style: // 텍스트 자체의 스타일
                      TextStyle(fontSize: 15, height: 0.6, color: Colors.black),
                  controller: txtcr,
                  decoration: InputDecoration( // 텍스트 필드 전체의 외관
                      filled: true,//텍스트 필드 배경색 채우는 여부
                      fillColor: Color(0xffC8E6C9),
                      contentPadding: EdgeInsets.symmetric( //텍스트 필드 내부의 여백
                        vertical: 10, // 위 아래 여백 10px
                        horizontal: 10, //양옆 여백 10px
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (webViewController != null) {
                    webViewController.loadRequest(Uri.parse(txtcr.text));
                  }
                },
                icon: Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 40,
                ),
              )
            ],
          )
        ]),
        centerTitle: true,
      ),
      body: WebViewWidget(controller: webViewController),
    );
  }
}
