import 'package:flutter/material.dart';
import 'package:skywander_app/styles.dart';

class tourCardWide extends StatefulWidget {
  final String image;
  final String title;
  final String days;
  final String place;
  final String price;
  final IconData? star;
  final String? rate;
  bool isFavorite;
  final bool isStarred;
  final double size;

  tourCardWide(
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
  State<tourCardWide> createState() => _tourCardWideState();
}

class _tourCardWideState extends State<tourCardWide> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: kPrimaryLight,
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: widget.size,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Stack(
            children: [
              ListTile(
                title: Text(widget.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.days,
                      style: const TextStyle(
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
                        Text(widget.place,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xff6E6853),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 10, 0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 106,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Color(0xff6E6853),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            widget.price,
                            style: k14RegularWhite,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => setState(
                            () => widget.isFavorite = !widget.isFavorite),
                        icon: widget.isFavorite == true
                            ? const Icon(Icons.favorite)
                            : const Icon(Icons.favorite_border),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
