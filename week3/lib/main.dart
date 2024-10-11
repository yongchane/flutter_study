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
          ), Row(
            children: [
              SizedBox(
                width: 300,

                child: TextField(
                  style: TextStyle(
                      fontSize: 15, height: 0.6, color: Colors.black),
                  controller: txtcr,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffC8E6C9),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(8)
                          )
                      )
                  ),
                ),
              ),
              IconButton(onPressed: () {
                if (webViewController != null){
                  webViewController.loadRequest(Uri.parse(txtcr.text));
                }
              },icon: Icon(Icons.arrow_circle_right_outlined,size: 40,),)
            ],
          )

        ]),
        centerTitle: true,

      ),
      body: WebViewWidget(controller: webViewController),
    );
  }
}
