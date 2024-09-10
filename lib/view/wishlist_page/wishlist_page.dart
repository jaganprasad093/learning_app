import 'package:flutter/material.dart';
import 'package:learning_app/view/homepage/widgets/horizontal_card.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wishlist",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => HorizontalCard(
                description: "",
                author_name: "dshgh",
                course_name: "nejdk",
                photo: "wmkm",
                price: 324,
                islearning: false,
              ),
          separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
          itemCount: 5),
    );
  }
}
