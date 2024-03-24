import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const CircleButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        CircleAvatar(
          radius: width*.06,
          backgroundColor: Colors.redAccent,
          child: Center(
            child: Icon(icon, color: Colors.white,),
          ),
        ),
        SizedBox(height: height*.005,),
        Text(label)
      ],
    );
  }
}
