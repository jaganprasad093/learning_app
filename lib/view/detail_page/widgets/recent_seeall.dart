import 'package:flutter/material.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/view/detail_page/detail_page.dart';
import 'package:learning_app/view/homepage/widgets/horizontal_card.dart';
import 'package:provider/provider.dart';

class RecentSeaAll extends StatelessWidget {
  final String caption;
  final String value;

  const RecentSeaAll({super.key, required this.caption, required this.value});

  @override
  Widget build(BuildContext context) {
    //  var data;
    //       int itemCount;
    var provider = context.read<HomepageController>().recentlyViewedModel;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            caption,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.separated(
          itemBuilder: (context, index) {
            // data = provider?.data?.data?[index].instructorName;

            var authorName = provider?.data?.data?[index].instructorName ?? "";
            String courseName = provider?.data?.data?[index].courseName ?? "";
            var price = provider?.data?.data?[index].coursePrice ?? "";
            String photo = provider?.data?.data?[index].courseThumbnail ?? "";
            String description = "";
            var id = provider?.data?.data?[index].id ?? 0;

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
                rating: 3,
                courseID: id,
                isWishlist: false,
                index: index,
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
          itemCount: provider?.data?.data?.length ?? 0,
        ));
  }
}
