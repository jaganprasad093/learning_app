import 'package:flutter/material.dart';
import 'package:learning_app/view/homepage/widgets/horizontal_card.dart';

class MyLearning extends StatefulWidget {
  const MyLearning({super.key});

  @override
  State<MyLearning> createState() => _MyLearningState();
}

class _MyLearningState extends State<MyLearning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My learning",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Icon(Icons.search),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => HorizontalCard(
                    islearning: true,
                  ),
              separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
              itemCount: 2)
        ],
      ),
    );
  }
}
