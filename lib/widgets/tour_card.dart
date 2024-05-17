import 'package:flutter/material.dart';
import 'package:skywander_app/styles.dart';
import 'package:skywander_app/widgets/rating_overlay.dart';

class TourCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String location;
  final String price;
  final bool isFavorite;
  final String imageUrl;
  final double rating;
  final VoidCallback onFavorite;
  final VoidCallback onTap;

  const TourCard({
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
    return SizedBox(
      width: 250,
      child: Card.outlined(
        clipBehavior: Clip.antiAlias,
        color: getTheme().colorScheme.surfaceContainer,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image with Rating Overlay
              Stack(
                fit: StackFit.passthrough,
                children: [
                  Image.network(
                    imageUrl,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: RatingOverlay(rating: rating),
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
                        Text(
                          price,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: getTheme().colorScheme.onPrimaryFixedVariant,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite
                                ? getTheme().colorScheme.error
                                : getTheme().colorScheme.onPrimaryFixedVariant,
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
      ),
    );
  }
}
