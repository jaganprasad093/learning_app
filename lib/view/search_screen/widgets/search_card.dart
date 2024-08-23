import 'package:flutter/material.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: 100,
      child: Column(
        children: [
          Container(
            height: 100,
            color: Colors.amber,
            child: Image.network(
              "https://images.pexels.com/photos/11031989/pexels-photo-11031989.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
              fit: BoxFit.cover,
            ),
          ),
          Text(
            "Title",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            "price",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          Text(
            "Authors Name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
