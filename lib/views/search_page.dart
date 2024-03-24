import 'package:flutter/material.dart';
import 'package:recipe_project_flutter/views/all_recipe_screen.dart';
import 'package:recipe_project_flutter/views/components/custom_app_bar.dart';
import 'package:recipe_project_flutter/views/components/text_field_widget.dart';

import '../services/search_tags.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const CustomAppBar(title: "Search", back: false),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height*.016,
            horizontal: width*.032
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextFieldWidget(),
            SizedBox(height: height * .04,),
            Text('Search tags', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: width*.06
            ),),
            Wrap(
              spacing: 8,
              children: tags.map((label) {
                return ElevatedButton(
                    onPressed: (){
                      Navigator.push(context,
                      MaterialPageRoute(builder:
                          (context) => AllRecipeScreen(recipe: label)
                      ));
                    },
                    child: Text(label)
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
