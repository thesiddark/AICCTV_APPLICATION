import 'package:aicctv/screens/Home.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../user_changepassword.dart';
import '../viewcomplaint.dart';
import '../viewdetectedcriminals.dart';
import '../viewdetectedun.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
      ),
      home: const Homenav(),
    );
  }
}

class Homenav extends StatefulWidget {
  const Homenav({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Homenav> {
  final items =  [
    Icon(Icons.home, size: 30, color: Colors.white),
  Image.asset('assets/images/fraud.png', width: 30, height: 30, color: Colors.white),
  Image.asset('assets/images/zone_person_urgent_FILL0_wght400_GRAD0_opsz24.png', width: 30, height: 30, color: Colors.white),
    Image.asset('assets/images/complaint.png', width: 30, height: 30, color: Colors.white),
    Image.asset('assets/images/settings.png', width: 30, height: 30, color: Colors.white),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBody: true, // To extend the body behind the bottom navigation bar
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        index: index,
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
        },
        height: 70,
        backgroundColor: Colors.transparent,
        color: Colors.blue,
        buttonBackgroundColor: Colors.blue,
        animationDuration: const Duration(milliseconds: 500), // Change animation duration
        animationCurve: Curves.easeInOut, // Change animation curve
        // Optional: You can add additional properties such as color, height, etc.
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: getSelectedWidget(index: index),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 60, // Height of the bottom navigation bar
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.withOpacity(0.0),
                    Colors.blue.withOpacity(0.0),
                    Colors.blue.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30), // Round the top corners
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch(index){
      case 0:
        widget = const Home();
        break;
      case 1:
        widget = const ViewDetectedCriminals();
        break;
      case 2:
        widget = const ViewDetectedUnkown();
        break;
      case 3:
        widget = const ViewReplyPage(title: '',);
        break;
      case 4:
        widget =  MyUserChangePassword();
        break;
      default:
        widget = const Home();
        break;
    }
    return widget;
  }
}
