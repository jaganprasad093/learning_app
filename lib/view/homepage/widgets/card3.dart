// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/core/constants/color_constants.dart';

class Card3 extends StatelessWidget {
  final int index;
  Card3({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider =
        context.watch<HomepageController>().featuredCoursesModel?.data?[index];
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
          Text(
            provider?.instructor?.name ?? "",
            // maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "₹" + "${provider?.price}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Icon(Icons.local_mall),
            ],
          ),
        ],
      ),
    );
  }
}
