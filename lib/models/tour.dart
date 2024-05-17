import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skywander_app/models/destination.dart';
import 'package:skywander_app/models/subcollections/itenerary.dart';
import 'subcollections/available_dates.dart';
import 'subcollections/review.dart';
import 'subcollections/tour_highlights.dart';
import 'theme.dart';

class Tour {
  final String title, subtitle, image, airline, origin;
  final List<Destination> destinations;
  final List<String> tourScope, otherImages, overviewMarkdown;
  final double basePrice;
  final int days, nights;
  final List<Itenerary> itenerary;
  final List<Theme> theme;
  final List<TourHighlight> tourHighlights;
  final List<Review> reviews;
  final List<AvailableDates> availableDates;
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

  factory Tour.fromFirestore(DocumentSnapshot doc) {
    return Tour(
      airline: doc['airline'] as String,
      basePrice: doc['base_price'] as double,
      destinations: doc['destinations'] as List<Destination>,
      days: doc['days'] as int,
      image: doc['image'] as String,
      itenerary: doc['itenerary'] as List<Itenerary>,
      otherImages: doc['other_images'] as List<String>,
      origin: doc['origin'] as String,
      overviewMarkdown: doc['overviewMarkdown'] as List<String>,
      reviews:
          (doc['reviews'] as List).map((e) => Review.fromFirestore(e)).toList(),
      subtitle: doc['subtitle'] as String,
      availableDates: (doc['availableDates'] as List)
          .map((e) => AvailableDates.fromFirestore(e))
          .toList(),
      theme: (List.from(doc['theme'] as List)
          .map((e) => Theme.fromFirestore(e))).toList(),
      tourHighlights: (doc['tourHighlights'] as List)
          .map((e) => TourHighlight.fromFirestore(e))
          .toList(),
      tourScope: doc['tour_scope'] as List<String>,
      active: doc['isActive'] as bool,
      nights: doc['nights'] as int,
      title: doc['title'] as String,
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
