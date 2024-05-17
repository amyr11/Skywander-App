import 'package:flutter/material.dart';
import 'package:skywander_app/styles.dart';

class RatingOverlay extends StatelessWidget {
  const RatingOverlay({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 14,
          ),
          SizedBox(width: 4),
          Text(
            rating.toString(),
            style: getTheme().textTheme.labelSmall!.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
