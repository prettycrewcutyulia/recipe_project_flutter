import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  final String title;
  const HomeAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Text(title, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: width * .07,
            height: 1
        ),),
        const Spacer()
      ],
    );
  }
}