import 'package:flutter/material.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:provider/provider.dart';

class RecommentionsCard extends StatelessWidget {
  final int index;

  const RecommentionsCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var data =
        context.watch<HomepageController>().recommendedModel?.data?[index];
    return Row(
      children: [
        Container(
          height: 100,
          width: 150,
          child: Image.network(
            data?.thumbnail?.fullSize ?? "",
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data?.courseName ?? "",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                data?.description ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                data?.instructor?.name ?? "",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
