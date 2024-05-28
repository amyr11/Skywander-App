import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skywander_app/models/destination.dart';
import 'package:skywander_app/models/subcollections/itenerary.dart';
import 'subcollections/available_dates.dart';
import 'subcollections/review.dart';
import 'subcollections/tour_highlights.dart';
import 'theme.dart';

class Tour {
  final String title, subtitle, image, airline, origin;
  final List destinations;
  final List otherImages;
  final String tourScope;
  final String overviewMarkdown;
  final double basePrice;
  final int days, nights;
  final List itenerary;
  final List theme;
  final List tourHighlights;
  final List reviews;
  final List availableDates;
  final bool active;

  Tour({
    required this.airline,
    required this.availableDates,
    required this.active,
    required this.basePrice,
    required this.days,
    required this.destinations,
    required this.image,
    required this.itenerary,
    required this.nights,
    required this.origin,
    required this.otherImages,
    required this.overviewMarkdown,
    required this.reviews,
    required this.subtitle,
    required this.tourHighlights,
    required this.tourScope,
    required this.theme,
    required this.title,
  });

  factory Tour.fromFirestore(Map<String, dynamic> doc) {
    return Tour(
      airline: doc['airline'] ?? "",
      basePrice: doc['base_price'] + 0.0,
      destinations: doc['destination'] ?? [],
      days: doc['days'],
      image: doc['image'],
      itenerary: doc['itenerary'] ?? [],
      otherImages: doc['other_images'] ?? [],
      origin: doc['origin'],
      overviewMarkdown: doc['overviewMarkdown'] ?? "",
      reviews: doc['reviews'] ?? [],
      subtitle: doc['subtitle'] ?? "",
      availableDates: doc['availableDates'] ?? [],
      theme: List.from(doc['theme']),
      tourHighlights: doc['tourHighlights'] ?? [],
      tourScope: doc['tour_scope'],
      active: doc['isActive'] ?? true,
      nights: doc['nights'],
      title: doc['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'airline': airline,
      'availableDates': availableDates.map((e) => e.toJson()).toList(),
      'basePrice': basePrice,
      'days': days,
      'destinations': destinations,
      'imageUrl': image,
      'itenerary': itenerary,
      'isActive': active,
      'nights': nights,
      'origin': origin,
      'otherImageUrls': otherImages,
      'overviewMarkdown': overviewMarkdown,
      'reviews': reviews.map((e) => e.toJson()).toList(),
      'subtitle': subtitle,
      'theme': theme.map((e) => e.toJson()).toList(),
      'tourHighlights': tourHighlights.map((e) => e.toJson()).toList(),
      'tourScope': tourScope,
      'title': title,
    };
  }
}
