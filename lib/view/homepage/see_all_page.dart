import 'package:flutter/material.dart';
import 'package:learning_app/view/homepage/widgets/horizontal_card.dart';

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
                child: HorizontalCard(
                  islearning: false,
                )),
            separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
            itemCount: 10));
  }
}
