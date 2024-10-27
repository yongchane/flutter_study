import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MaterialApp(home: HomeScreen()));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> creatState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with TickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this);

    controller!.addListener(tabListener);
  }

  void onPhoneShake() {
    tabListener() {
      setState(() {

      });
    }
  }

  @override
  void dispose() {
    controller!.removeListener(tabListener)
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
          controller: controller,
          children: renderChildren()),
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChildren() {
    return [
      Center(
        child: Text("1번"),
      ),
      Center(
        child: Text("1번"),
      ),
      Center(
        child: Text("1번"),
      )
    ];
  }

  BottomNavigationBar renderBottomNavigation() {
    return BottomNavigationBar(
      items: BottomNavigationBarItem(icon: icon, label: "1"),
      BottomNavigationBarItem(icon: icon, label: "1"),
      BottomNavigationBarItem(icon: icon, label: "1"),)
  }
}
