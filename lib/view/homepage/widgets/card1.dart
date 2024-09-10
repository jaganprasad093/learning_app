import 'package:flutter/material.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:provider/provider.dart';

class Card1 extends StatelessWidget {
  final int index;
  const Card1({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var provider =
        context.watch<HomepageController>().recommendedModel?.data?[index];
    return Container(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            Container(
              height: 120,
              width: 200,
              color: ColorConstants.button_color,
              child: Image.network(
                provider?.thumbnail?.fullSize ?? "",
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
                right: 3,
                top: 3,
                child: Icon(
                  Icons.favorite_border_sharp,
                  color: ColorConstants.primary_white,
                ))
          ]),
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
