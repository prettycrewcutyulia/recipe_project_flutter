import 'package:flutter/material.dart';
import 'package:recipe_project_flutter/services/network_service.dart';

import '../detail_page.dart';

class HomeTabBarView extends StatelessWidget {
  final String recipe;
  const HomeTabBarView(this.recipe, {super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: NetworkService.getResponse(recipe),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data. Check your connection'),);
        }

        return  SizedBox(
          height: height*.28,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Map<String, dynamic> snap=snapshot.data! [index];
                int time=snap[ 'totalTime'].toInt();
                int calories=snap['calories'].toInt();
                return Container(
                  margin: EdgeInsets.only(right: width*.02),
                  width: width*.5,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPage(item: snap))
                              );
                            },
                            child: Container(
                              width: width,
                              height: height*.17,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage(snap['image']),
                                fit: BoxFit.fill)
                              ),
                            ),
                          ),
                          SizedBox(height: height*.01,),
                          Text(snap['label'], style: TextStyle(
                            fontSize: width*.035,
                            fontWeight: FontWeight.bold
                          ),),
                          SizedBox(height: height*.01,),
                          Text("Calories: ${calories.toString()}. Min: ${time.toString()}",
                            style: TextStyle(
                                fontSize: width*.03,
                                color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
              separatorBuilder:(context, index) {
                return const SizedBox(width: 15);
              },
              itemCount: snapshot.data!.length),
        );
      },
    );
  }
}
