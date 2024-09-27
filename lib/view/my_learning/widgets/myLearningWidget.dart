import 'package:flutter/material.dart';

class Mylearningwidget extends StatelessWidget {
  final String courseName;
  final String photo;
  final double percentage;

  const Mylearningwidget(
      {super.key,
      required this.courseName,
      required this.photo,
      required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(photo), fit: BoxFit.cover)),
              width: 100,
              child: Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.black.withOpacity(.4),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 1,
                child: Container(
                  height: 5,
                  width: percentage,
                  color: Colors.red,
                ))
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          courseName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        )
      ],
    );
  }
}
