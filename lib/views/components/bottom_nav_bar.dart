import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  final int SelectedItem;
  final Function(int) onTap;

  const BottomNavBar({super.key, required this.SelectedItem, required this.onTap});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.grey[100],
       child: Padding(
         padding: EdgeInsets.symmetric(horizontal: width * .015, vertical: height * .015),
         child: GNav (
           gap: 10,
           tabBorderRadius: 100,
           backgroundColor: Colors.grey[100]!,
           activeColor: Colors.white,
           color: Colors.red[600],
           tabBackgroundGradient: LinearGradient(
             colors: [
               Colors.red[200]!,
               Colors.red[400]!
             ],
             begin: Alignment.topLeft,
             end: Alignment.topRight
           ),
           iconSize: 30,
           textSize: 18,
           padding:  EdgeInsets.symmetric(horizontal: width * .01, vertical: height * .01),
           tabs: const [
             GButton(icon: Icons.home, text: 'Home'),
             GButton(icon: Icons.search, text: 'Search'),
             GButton(icon: Icons.bookmark, text: 'Saved'),
             GButton(icon: Icons.shopping_cart, text: 'Shopping')
           ],
           onTabChange: widget.onTap,
           selectedIndex: 0,
         )
       ),
    );
  }
}
