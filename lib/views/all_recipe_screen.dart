import 'package:flutter/material.dart';
import 'package:recipe_project_flutter/services/network_service.dart';
import 'package:recipe_project_flutter/views/detail_page.dart';

import 'components/custom_app_bar.dart';

class AllRecipeScreen extends StatelessWidget {
  final String recipe;
  const AllRecipeScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(title: recipe, back: true,),
      body: FutureBuilder(
          future: NetworkService.getResponse(recipe),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text("No data("),);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            }
            return Padding(
                padding: EdgeInsets.only(
                  right: width*.034,
                left: width* .034,
                top: height*.03),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 10,
                  childAspectRatio: .6/1
                ),
                itemBuilder: (context, index) {
                  Map<String, dynamic> snap = snapshot.data![index];
                  return Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Expanded(
                            flex: 3,
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context,
                                    MaterialPageRoute
                                      (builder: (context)=>
                                        DetailPage(item: snap))
                                );
                              },
                              child: Stack(
                                children: [

                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(snap['image']),
                                        fit: BoxFit.cover
                                      )
                                    ),
                                  ),
                                  Positioned(
                                    top: 7,
                                      left: 15,
                                      child: Container(
                                    height: 20,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text("${snap['totalTime'].toInt()} min",
                                        style: const TextStyle(
                                          color: Colors.white
                                        ),)
                                    ),
                                  ))
                                ],
                              ),
                            )
                        ),
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8, left: 6),
                              child: Text(snap['label'], style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: width * .03
                              ),),
                            ),
                        )
                      ],
                    ),
                  );
                }),
            );
          }),
    );
  }
}
