import 'package:flutter/material.dart';

import 'ingredient_item.dart';

class IngridientList extends StatelessWidget {
  final List<dynamic> ingredients;
  const IngridientList({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ScrollPhysics(
        parent: NeverScrollableScrollPhysics()
      ),
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          int quantity = ingredients[index]['quantity'].toInt() ?? 1;
          return IngredientItem(
              quantity: quantity.toString(),
              imageUrl: ingredients[index]['image']??'',
              measure: ingredients[index][ 'measure']?? '',
              food: ingredients[index]['food']?? '',
          );
        }
        );
  }
}
