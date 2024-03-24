import 'package:flutter/material.dart';

import '../all_recipe_screen.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: height * .06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0,  1),
            blurRadius: 2
          )
        ]
      ),
      child: TextField(
        controller: search,
        style: TextStyle(
          fontSize: width * .04,
          color: Colors.black
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "What do you want?",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: width * .03
          ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none
        ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => AllRecipeScreen(recipe:search.text)));
            },
            child: Icon(Icons.search,
            color: Colors.deepOrangeAccent,
              size: width * .07,
            ),
          )
        ),
      ),
    );
  }
}
