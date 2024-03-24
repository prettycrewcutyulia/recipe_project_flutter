import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_project_flutter/services/share_recipe_manager.dart';
import 'package:recipe_project_flutter/views/components/custom_app_bar.dart';
class ShoppingPage extends StatelessWidget {
  const ShoppingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var box = Hive.box('shopping');

    return Scaffold(
        appBar: CustomAppBar(title: 'Need to shop', back: false),
      body: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, box, _) {
            var data = box.values.toList();
            return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Container(
                      height: height*.085,
                      color: Colors.grey[100],
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                              child: Text(data[index])),
                          PopupMenuButton(itemBuilder: (context) {
                            return const [
                              PopupMenuItem(value: 'share',child: Text('share')),
                              PopupMenuItem(value: 'delete',child: Text('delete')),
                            ];
                          },
                            onSelected: (String value) async{
                            if (value == 'share') {
                              ShareRecipeManager.share(data[index]);
                            } else {
                              await box.deleteAt(index);
                            }
                            },
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
      ),

    );
  }
}
