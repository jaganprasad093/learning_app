import 'package:flutter/material.dart';
import 'package:learning_app/controller/review_controller/ReviewController.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:provider/provider.dart';

class Aboutapp extends StatefulWidget {
  const Aboutapp({super.key});

  @override
  State<Aboutapp> createState() => _AboutappState();
}

class _AboutappState extends State<Aboutapp> {
  @override
  void initState() {
    context.read<Reviewcontroller>().getAbout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.read<Reviewcontroller>();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "About App",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.aboutModel?.data?[index].title ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        provider.aboutModel?.data?[index].aboutApp ?? "",
                        style: TextStyle(
                            color: ColorConstants.primary_black.withOpacity(.9),
                            fontWeight: FontWeight.normal,
                            fontSize: 19),
                      )
                    ],
                  ),
                ),
            separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
            itemCount: provider.aboutModel?.data?.length ?? 0));
  }
}
