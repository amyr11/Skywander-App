import 'package:flutter/material.dart';
import 'package:skywander_app/styles.dart';

class tourCardWide extends StatelessWidget {
  final String image;
  final String title;
  final String days;
  final String place;
  final String price;
  final IconData? star;
  final String? rate;
  final bool isFavorite;
  final bool isStarred;
  final double size;

  const tourCardWide(
      {super.key,
      required this.image,
      required this.title,
      required this.days,
      required this.place,
      required this.price,
      this.star,
      this.rate,
      this.isFavorite = false,
      this.isStarred = false,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kPrimaryLight,
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: size,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            title: Text(title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  days,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff6E6853),
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 15,
                      color: Colors.red,
                    ),
                    Text(place,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff6E6853),
                        )),
                  ],
                ),
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 106,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0xff6E6853),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      price,
                      style: k14RegularWhite,
                    ),
                  ),
                ),
                Icon(
                  isFavorite == true ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
