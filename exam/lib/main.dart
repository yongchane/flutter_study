import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       body: Center(
//           child: GestureDetector(
//         onTap: () {
//           print('on Tap');
//         },
//         onDoubleTap: () {
//           print("on Double Tap");
//         },
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//               border: Border.all(
//                 width: 16.0,
//                 color: Colors.red,
//               ),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             width: 200.0,
//             height: 100.0,
//           ),
//         ),
//       )),
//     ));
//   }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Container(
//             color: Colors.black,
//             child: Container(
//               color: Colors.red,
//               margin: EdgeInsets.all(20),
//               child: Padding(padding: EdgeInsets.all(16),
//                 child: Container(color: Colors.amberAccent,
//                   width: 100,
//                   height: 100,
//                 ),),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: SizedBox(
//            // 높이 무한대
//           height: double.infinity,
//           child: Row(
//             // 가로  정렬
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //세로 정렬
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 height: 50,
//                 width: 50,
//                 color: Colors.red,
//               ),
//               const SizedBox(width: 12.0),
//               Container(height: 50.0, width: 50.0, color: Colors.amberAccent),
//               const SizedBox(width: 12.0),
//               Container(height: 50.0, width: 50.0, color: Colors.blue)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// // }
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: SizedBox(
//           width: double.infinity,
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.start,
//             //
//             // crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // Container(
//               //   height: 50,
//               //   width: 50,
//               //   color: Colors.blue,
//               // ),
//               // const SizedBox(width: 12.0),
//               // Container(
//               //   height: 50,
//               //   width: 50,
//               //   color: Colors.red,
//               // ),
//               // const SizedBox(width: 12.0),
//               // Container(
//               //   height: 50,
//               //   width: 50,
//               //   color: Colors.black,
//               // )
//               Expanded(
//                 flex: 1,
//                 child: Container(
//                   color: Colors.red,
//                 ),
//               ),
//               Expanded(
//                 // flex는 남은 공간의 비율 즉 공간의 비율 같은 느낌이다
//                 flex: 1,
//                 child: Container(
//                   color: Colors.black
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(

            decoration: BoxDecoration(color: Color(0xFFF99231)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/pngwing.com.png",width: 100,),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
              ],
            )),
      ),
    );
  }
}
