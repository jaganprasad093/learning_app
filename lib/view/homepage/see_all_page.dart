import 'package:flutter/material.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/view/detail_page/detail_page.dart';
import 'package:learning_app/view/homepage/widgets/horizontal_card.dart';
import 'package:provider/provider.dart';

class SeeAllPage extends StatelessWidget {
  final String caption;
  final String value;

  const SeeAllPage({super.key, required this.caption, required this.value});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          caption,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<HomepageController>(
        builder: (context, controller, child) {
          List? data;
          int itemCount;

          if (value == "featured") {
            data = controller.featuredCoursesModel?.data;
            itemCount = data?.length ?? 0;
          } else if (value == "top") {
            data = controller.topCoursesModel?.data;
            itemCount = data?.length ?? 0;
          } else {
            data = controller.recommendedModel?.data;
            itemCount = data?.length ?? 0;
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              var courseData = data?[index];
              if (courseData == null) return SizedBox();

              String authorName = courseData.instructor?.name ?? "";
              String courseName = courseData.courseName ?? "";
              var price = courseData.price ?? "";
              String photo = courseData.thumbnail?.fullSize ?? "";
              String description = courseData.description ?? "";
              var id = courseData.id ?? "";

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        id: id,
                      ),
                    ),
                  );
                },
                child: HorizontalCard(
                  description: description,
                  author_name: authorName,
                  course_name: courseName,
                  photo: photo,
                  price: price,
                  islearning: false,
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
            itemCount: itemCount,
          );
        },
      ),
    );
  }
}
