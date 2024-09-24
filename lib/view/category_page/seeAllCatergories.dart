import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_app/controller/category_controller/category_controller.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/view/category_page/category_screen.dart';
import 'package:provider/provider.dart';

class Seeallcatergories extends StatelessWidget {
  const Seeallcatergories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.separated(
            itemBuilder: (context, index) {
              var data = context
                  .watch<HomepageController>()
                  .categoryListModel
                  ?.data?[index];
              return InkWell(
                onTap: () {
                  var id = data?.id;
                  log("Id equals----$id");
                  context.read<CategoryController>().getCategoryItem(id);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryScreen(
                          id: id ?? 0,
                        ),
                      ));
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        data?.categoryName ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
            itemCount: context
                    .read<HomepageController>()
                    .categoryListModel
                    ?.data
                    ?.length ??
                0),
      ),
    );
  }
}
