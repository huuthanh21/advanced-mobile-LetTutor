import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final int _rating;

  RatingBar({super.key, required int rating}) : _rating = rating.clamp(0, 5);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < _rating; i++)
          const Icon(
            Icons.star,
            color: Colors.yellow,
          ),
        for (int i = 0; i < 5 - _rating; i++)
          const Icon(
            Icons.star,
            color: Colors.grey,
          ),
      ],
    );
  }
}
