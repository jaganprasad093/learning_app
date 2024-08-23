import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/color_constants.dart';

class SeeAllPage extends StatelessWidget {
  const SeeAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "title",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/detailpage");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 70,
                          width: 70,
                          color: ColorConstants.green,
                          child: Image.network(
                            "https://images.pexels.com/photos/19641063/pexels-photo-19641063/free-photo-of-silhouette-of-couple-on-a-hill.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "We recommend verifying at least one more ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              softWrap: true,
                            ),
                            Text(
                              "least one more email",
                              style: TextStyle(),
                              softWrap: true,
                            ),
                            Text(
                              "₹ 674.00",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                              softWrap: true,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
            separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
            itemCount: 10));
  }
}
