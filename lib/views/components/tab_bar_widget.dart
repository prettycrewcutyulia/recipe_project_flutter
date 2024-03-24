import 'package:flutter/material.dart';
import 'package:recipe_project_flutter/views/components/home_tab_bar_view.dart';
import 'package:recipe_project_flutter/views/components/tab_item_widget.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return DefaultTabController(
        length: 4,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                height: height * .05,
                child: TabBar(
                  unselectedLabelColor: Colors.red,
                  labelColor: Colors.white,
                  dividerColor: Colors.white,
                  indicator: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  labelPadding: EdgeInsets.symmetric(horizontal: width * .012),
                  tabs: const [
                    TabItem(title: 'Breakfast'),
                    TabItem(title:'Lunch'),
                    TabItem(title:'Dinner'),
                    TabItem(title:'Quick')
                  ],
                ),
              ),
              SizedBox(height: height * .02,),

              SizedBox(
                height: height * .3,
                child: const TabBarView(
                  children: [
                    HomeTabBarView("breakfast"),
                    HomeTabBarView("lunch"),
                    HomeTabBarView("dinner"),
                    HomeTabBarView("quick")
                  ],
                ),
              )
            ],
          )
    );
  }
}
