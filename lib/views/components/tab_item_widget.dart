import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String title;
  const TabItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red
        ),
        borderRadius:  BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: Text(title, style: const TextStyle(
          fontSize: 9.8
        ),),
      ),),
    );
  }
}
