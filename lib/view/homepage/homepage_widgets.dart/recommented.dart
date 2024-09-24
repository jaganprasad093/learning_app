import 'package:flutter/material.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/view/detail_page/detail_page.dart';
import 'package:learning_app/view/homepage/see_all_page.dart';
import 'package:learning_app/view/homepage/widgets/card1.dart';
import 'package:provider/provider.dart';

class Recommented extends StatelessWidget {
  const Recommented({super.key});

  @override
  Widget build(BuildContext context) {
    var getProvider =
        context.watch<HomepageController>().recommendedModel?.data;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recommended for you",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                height: 220,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var provider = context.watch<HomepageController>();
                    var id = provider.recommendedModel?.data?[index].id;
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                id: id ?? 0,
                              ),
                            ));
                        provider.getCourseDetails(id);
                      },
                      child: Card1(
                        index: index,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    width: 20,
                  ),
                  itemCount: (getProvider?.length ?? 0) < 3
                      ? (getProvider?.length ?? 0)
                      : 3,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeeAllPage(
                              caption: "Recommented Courses",
                              value: "recommented",
                            ),
                          ));
                    },
                    child: Text(
                      "See all",
                      style: TextStyle(
                          color: ColorConstants.button_color,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  )
                ],
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
