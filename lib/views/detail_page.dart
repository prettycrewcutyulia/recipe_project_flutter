import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_project_flutter/services/network_service.dart';
import 'package:recipe_project_flutter/services/share_recipe_manager.dart';
import 'package:recipe_project_flutter/views/components/show_detail_dialog.dart';

import 'components/circle_button.dart';
import 'components/custom_clip_path.dart';
import 'components/ingridient_list.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> item;
  const DetailPage({super.key, required this.item});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var box = Hive.box('saved');

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
         children: [
            Container(
              height: height*.44,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(widget.item['image']), fit: BoxFit.cover)
              ),
            ),
            Positioned(
              top: height*.04,
                left: width*.05,
                child: const CircleAvatar(
              backgroundColor: Colors.redAccent,
              child: BackButton(color: Colors.white)
            )
            ),
        ]
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: width*.04),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    Text(widget.item['label'],
                      style: TextStyle(
                          fontSize: width*.05,
                          fontWeight: FontWeight.w700,
                          color: Colors.black
                      ),),
                    const SizedBox(height: 1,),
                    Text("${widget.item['totalTime'].toString()} min"),
                    SizedBox(height: height*.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            ShareRecipeManager.share(widget.item['url']);
                          },
                            child: const CircleButton(
                              icon: Icons.share,
                              label: 'Share',)
                        ),
                        ValueListenableBuilder(
                            valueListenable: box.listenable(),
                            builder: (context, box, _) {
                              var element = widget.item['label'];
                              bool saved = box.containsKey(element);
                              return GestureDetector(
                                onTap: () {
                                  saved? box.delete(element) : box.put(element, element);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                     SnackBar(
                                       duration: Duration(seconds: 1),
                                         content: Text("${saved?'Recipe deleted':'Recipe saved'}")
                                     )
                                  );
                                },
                                child: saved ?
                                CircleButton(
                                  icon: Icons.bookmark,
                                  label: 'Saved',) :
                                CircleButton(
                                  icon: Icons.bookmark_border,
                                  label: 'Save',),
                              );

                            }
                            ),
                        const CircleButton(
                          icon: Icons.bookmark_border,
                          label: 'Save',),
                        GestureDetector(
                          onTap: () {
                            ShowDetailDialog.showCalories(widget.item['totalNutrients'], context);
                          },
                            child: const CircleButton(
                              icon: Icons.monitor_heart_outlined,
                              label: 'Calories',)
                        )
                      ],
                    ),
                    SizedBox(height: height*.02,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Direction", style: TextStyle(fontWeight: FontWeight.bold, fontSize: width*.06),),
                      SizedBox(width: width * .34,
                      child:  ElevatedButton(
                        onPressed: () {
                          NetworkService.startCooking(widget.item['url']);
                        },
                        child: Text('Start')))
                    ],),
                    SizedBox(height: height*.02,),
                    Container(
                      height: height*.07,
                      width: width,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                              child: ClipPath(
                                clipper: CustomClipPath(),
                                child: Container(
                                  color: Colors.redAccent,
                                  child: Center(
                                    child: Text('Ingredients',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * .05,
                                        color: Colors.white
                                      ),),
                                  ),
                                ),
                              ) ),
                          Expanded(
                            flex: 1,
                              child: Container(
                                color: Colors.white,
                                child: Center(
                                  child: Text("   6\n Items"),
                                ),
                          ))
                        ],
                      ),),
                    SizedBox(height: height*1.8,
                    child: IngridientList(
                      ingredients: widget.item['ingredients'],
                    ),
                    ),
                  ],
                )
            ),
        
          ],
        
        ),
      ),
    );
  }
}
