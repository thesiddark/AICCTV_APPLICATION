import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MyCurvedNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyCurvedNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      height: kBottomNavigationBarHeight, // Always keep a minimum height
      curve: Curves.easeInOut,
      child: Material(
        elevation: 8.0,
        color: Colors.white,
        child: SafeArea(
          child: CurvedNavigationBar(
            onTap: onTap,
            backgroundColor: Colors.transparent,
            color: Colors.blueGrey, // Background color of the navigation bar
            buttonBackgroundColor: Colors.blueGrey, // Color of the selected item
            height: 60, // Height of the navigation bar
            items: [
              Icon(
                Icons.home_outlined,
                color: Colors.white,
                size: 30,
              ),
              Icon(
                Icons.security,
                color: Colors.white,
                size: 30,
              ),
              Icon(
                Icons.security,
                color: Colors.white,
                size: 30,
              ),
              Icon(
                Icons.feedback_outlined,
                color: Colors.white,
                size: 30,
              ),
              Icon(
                Icons.star_border,
                color: Colors.white,
                size: 30,
              ),
              Icon(
                Icons.settings_outlined,
                color: Colors.white,
                size: 30,
              ),

            ],
            index: currentIndex,
          ),
        ),
      ),
    );
  }
}
