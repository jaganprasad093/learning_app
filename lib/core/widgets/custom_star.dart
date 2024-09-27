import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final double? size;

  const StarRating({
    Key? key,
    required this.rating,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Icon(
          Icons.star,
          size: size == null ? 18 : size,
          color: index < rating ? Colors.amber : Colors.grey,
        );
      }),
    );
  }
}
