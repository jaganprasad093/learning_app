import 'package:flutter/material.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:provider/provider.dart';

class SearchCard extends StatefulWidget {
  final int index;
  const SearchCard({super.key, required this.index});

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.read<HomepageController>();
    var data = provider.recentlyViewedModel?.data?.data?[widget.index];
    return provider.isLoading
        ? Center(
            child: CircularProgressIndicator(
            color: ColorConstants.primary_white,
          ))
        : Container(
            height: 220,
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(),
                  height: 100,
                  child: ClipRRect(
                    child: Image.network(
                      data?.courseThumbnail ?? "",
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                Text(
                  data?.courseName ?? "",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "₹ " + "${data?.coursePrice.toInt()}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Text(
                  data?.instructorName ?? "",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          );
  }
}
