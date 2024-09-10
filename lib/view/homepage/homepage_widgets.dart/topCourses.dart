import 'package:flutter/material.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/view/homepage/see_all_page.dart';
import 'package:learning_app/view/homepage/widgets/card2.dart';
import 'package:provider/provider.dart';

class Topcourses extends StatelessWidget {
  const Topcourses({super.key});

  @override
  Widget build(BuildContext context) {
    var getProvider = context.watch<HomepageController>().topCoursesModel?.data;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Top courses",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 200,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Card2(
                    index: index,
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    width: 10,
                  ),
                  itemCount: (getProvider?.length ?? 0) < 3
                      ? (getProvider?.length ?? 0)
                      : 3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SeeAllPage(
                                  caption: "Top Courses",
                                  value: "top",
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
