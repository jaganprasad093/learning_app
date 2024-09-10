// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/core/constants/color_constants.dart';

class Card2 extends StatelessWidget {
  final int index;
  Card2({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider =
        context.watch<HomepageController>().topCoursesModel?.data?[index];
    return Container(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 150,
            color: ColorConstants.button_color,
            child: Image.network(
              provider?.thumbnail?.fullSize ?? "",
              fit: BoxFit.fill,
            ),
          ),
          Text(
            provider?.courseName ?? "",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(provider?.instructor?.name ?? ""),
                  Text(
                    "₹" + "${provider?.price}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              Icon(Icons.local_mall)
            ],
          ),
        ],
      ),
    );
  }
}
