import 'package:flutter/material.dart';
import 'package:skywander_app/styles.dart';

class ItineraryDay extends StatelessWidget {
  final String day;
  final String description;
  final List<String> mealIcons;
  final String imageURL;
  final String details;

  const ItineraryDay({
    required this.day,
    required this.description,
    required this.mealIcons,
    required this.imageURL,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      day,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      description,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Row(
                children: mealIcons.map((icon) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Icon(
                      icon == 'breakfast'
                          ? Icons.free_breakfast
                          : icon == 'lunch'
                              ? Icons.lunch_dining
                              : Icons.dinner_dining,
                      size: 16,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kContainerBorderRadius),
            ),
            child: Image.network(imageURL, fit: BoxFit.cover),
          ),
          SizedBox(height: 8),
          Text(
            details,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
