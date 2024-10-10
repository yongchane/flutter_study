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
class MyApp extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          height: double.infinity,
          child: Row(

            mainAxisAlignment: MainAxisAlignment.start,

            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Container(
                height: 50,
                width: 50,
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}
