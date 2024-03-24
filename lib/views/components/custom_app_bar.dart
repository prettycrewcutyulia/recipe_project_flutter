import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool back;
  const CustomAppBar({super.key, required this.title, required this.back});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AppBar(
      title: Text(title, style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: width*.06,
        letterSpacing: 2,
        color: Colors.black,
      ),),
      leading: back ? const BackButton(color: Colors.black,): null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
