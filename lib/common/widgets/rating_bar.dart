import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final int _rating;
  final double _size;

  RatingBar({super.key, required int rating, double size = 20})
      : _rating = rating.clamp(0, 5),
        _size = size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < _rating; i++)
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: _size ?? 20,
          ),
        for (int i = 0; i < 5 - _rating; i++)
          Icon(
            Icons.star,
            color: Colors.grey.shade200,
            size: _size ?? 20,
          ),
      ],
    );
  }
}
