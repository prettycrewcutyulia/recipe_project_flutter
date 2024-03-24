import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:recipe_project_flutter/views/components/custom_app_bar.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('saved');
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
        appBar: const CustomAppBar(title: 'Saved', back: false),
        body: Padding(
            padding: EdgeInsets.only(top: 10, right: 8, left: 8),
            child: ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, index, _) {
                  return ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        var data = box.values.toList();
                        return ListTile(
                          title: Container(
                            height: height * .085,
                            color: Colors.grey[100],
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Text(data[index])
                                ),
                                PopupMenuButton(itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      child: Text('share'), value: 'share',),
                                    PopupMenuItem(
                                      child: Text('delete'), value: 'delete',)
                                  ];
                                })
                              ],
                            ),
                          ),
                        );
                      });
                })
        )
    );
  }
}

