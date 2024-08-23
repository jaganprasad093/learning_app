import 'package:flutter/material.dart';

class RecommentionsCard extends StatelessWidget {
  const RecommentionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 150,
          child: Image.network(
            "https://images.pexels.com/photos/27791671/pexels-photo-27791671/free-photo-of-evening-street.jpeg?auto=compress&cs=tinysrgb&w=400&lazy=load",
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
                "te tailored learning paths.... ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text("athors name")
            ],
          ),
        ),
      ],
    );
  }
}
