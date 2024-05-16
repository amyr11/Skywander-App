import 'package:flutter/material.dart';
import 'package:skywander_app/styles.dart';

class TourCardWide extends StatelessWidget {
  final String title;
  final String subtitle;
  final String location;
  final String price;
  final bool isFavorite;
  final String imageUrl;
  final double rating;
  final VoidCallback onFavorite;
  final VoidCallback onTap;

  const TourCardWide({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.location,
    required this.price,
    required this.isFavorite,
    required this.imageUrl,
    required this.rating,
    required this.onFavorite,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          clipBehavior: Clip.antiAlias,
          color: getTheme().colorScheme.primaryContainer,
          child: InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image with Rating Overlay
                Stack(
                  children: [
                    Image.network(
                      imageUrl,
                      width: constraints.maxWidth,
                      height: constraints.maxWidth * 0.45,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20,
                            ),
                            SizedBox(width: 4),
                            Text(
                              rating.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Info section
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      // Location
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: getTheme().colorScheme.error,
                          ),
                          SizedBox(width: 4),
                          Text(
                            location,
                            style: TextStyle(
                              fontSize: 16,
                              color: getTheme().colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                      // Subtitle
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 16,
                          color: getTheme().colorScheme.onPrimaryContainer,
                        ),
                      ),
                      // Price and Favorite icon
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color:
                                  getTheme().colorScheme.onPrimaryFixedVariant,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              price,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite
                                  ? getTheme().colorScheme.error
                                  : getTheme()
                                      .colorScheme
                                      .onPrimaryFixedVariant,
                            ),
                            onPressed: onFavorite,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
