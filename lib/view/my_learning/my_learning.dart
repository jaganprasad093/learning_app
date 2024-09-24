import 'package:flutter/material.dart';
import 'package:learning_app/view/bottom_navigation/bottom_navigation.dart';
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
        leading: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavigation(initialIndex: 0),
                  ));
            },
            child: Icon(Icons.arrow_back)),
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
                    rating: 3,
                    courseID: 1,
                    isWishlist: false,
                    index: index,
                    description: "",
                    author_name: "dshgh",
                    course_name: "nejdk",
                    photo: "wmkm",
                    price: 876,
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
