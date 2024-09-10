import 'package:flutter/material.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:provider/provider.dart';

class Categorieslist extends StatelessWidget {
  const Categorieslist({super.key});

  @override
  Widget build(BuildContext context) {
    var getProvider =
        context.watch<HomepageController>().categoryListModel?.data;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              "See all",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.button_color),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var data = context
                  .watch<HomepageController>()
                  .categoryListModel
                  ?.data?[index];
              return Container(
                decoration: BoxDecoration(
                  color: ColorConstants.button_color,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: Center(
                    child: Text(
                      data?.categoryName ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.button_color,
                          fontSize: 16),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              width: 10,
            ),
            itemCount:
                (getProvider?.length ?? 0) < 6 ? (getProvider?.length ?? 0) : 6,
          ),
        ),
      ],
    );
  }
}
