import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class IngredientItem extends StatelessWidget {
  final String quantity, measure, food, imageUrl;

  const IngredientItem({
    super.key,
    required this.quantity,
    required this.food,
    required this.measure,
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var box = Hive.box('shopping');

    return Container(
      margin: EdgeInsets.symmetric(vertical: height*.01, horizontal: width*.033),
      padding: EdgeInsets.only(
        top: height * .008,
        bottom: height * .008,
        left: height * .008,
        right: width * .08
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 3)
          ),
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imageUrl,
              width: width *.2,
            height: height * .1,
                fit: BoxFit.cover)
          ),
          Text("$food\n$quantity $measure", style: TextStyle(
            fontSize: width * .04,
            fontWeight: FontWeight.bold,
            letterSpacing: 1
          ),),
          SizedBox(width: width * .033,),
          ValueListenableBuilder(
            valueListenable: box.listenable(),
              builder: (context, box, _){
              bool exist = box.containsKey(food);
              return GestureDetector(
                onTap: (){
                  String value = "$food $measure $quantity";
                  exist? box.delete(food) : box.put(food, value);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(exist?"item deleted":"item added"))
                  );
                },
                child: Icon(exist? Icons.done :
                Icons.add_circle_outline_rounded,
                size: width * .07,
                    color: Colors.red),
              );
              },
          )
        ],
      ),
    );
  }
}