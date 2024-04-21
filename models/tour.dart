import 'package:cloud_firestore/cloud_firestore.dart';
import 'subcollections/available_dates.dart';
import 'subcollections/hotel_option.dart';
import 'subcollections/itenerary.dart';
import 'subcollections/review.dart';
import 'subcollections/tour_highlights.dart';
import 'theme.dart';

class Tour {
  final String title, subtitle, imageUrl, tourScope;
  final List<String> destinations, otherImageUrls, inclusions, exclusions;
  final double basePrice;
  final int days, nights;
  final Theme theme;
  final Itenerary itenerary;
  final List<TourHighlight> tourHighlights;
  final List<HotelOption> hotelOptions;
  final List<Review> reviews;
  final List<AvailableDates> availableDates;
  final bool isActive;

  Tour(
      {required this.title,
      required this.subtitle,
      required this.imageUrl,
      required this.tourScope,
      required this.basePrice,
      required this.destinations,
      required this.otherImageUrls,
      required this.inclusions,
      required this.exclusions,
      required this.days,
      required this.nights,
      required this.theme,
      required this.itenerary,
      required this.tourHighlights,
      required this.hotelOptions,
      required this.reviews,
      required this.availableDates,
      required this.isActive});

  factory Tour.fromFirestore(DocumentSnapshot doc) {
    return Tour(
      title: doc['title'] as String,
      subtitle: doc['subtitle'] as String,
      imageUrl: doc['imageUrl'] as String,
      tourScope: doc['tourScope'] as String,
      basePrice: doc['basePrice'] as double,
      destinations: doc['destinations'] as List<String>,
      otherImageUrls: doc['otherImageUrls'] as List<String>,
      inclusions: doc['inclusions'] as List<String>,
      exclusions: doc['exclusions'] as List<String>,
      days: doc['days'] as int,
      nights: doc['nights'] as int,
      theme: Theme.fromFirestore(doc['theme']),
      itenerary: Itenerary.fromFirestore(doc['itenerary']),
      tourHighlights: (doc['tourHighlights'] as List)
          .map((e) => TourHighlight.fromFirestore(e))
          .toList(),
      hotelOptions: (doc['hotelOptions'] as List)
          .map((e) => HotelOption.fromFirestore(e))
          .toList(),
      reviews:
          (doc['reviews'] as List).map((e) => Review.fromFirestore(e)).toList(),
      availableDates: (doc['availableDates'] as List)
          .map((e) => AvailableDates.fromFirestore(e))
          .toList(),
      isActive: doc['isActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
      'tourScope': tourScope,
      'basePrice': basePrice,
      'destinations': destinations,
      'otherImageUrls': otherImageUrls,
      'inclusions': inclusions,
      'exclusions': exclusions,
      'days': days,
      'nights': nights,
      'theme': theme.toJson(),
      'itenerary': itenerary.toJson(),
      'tourHighlights': tourHighlights.map((e) => e.toJson()).toList(),
      'hotelOptions': hotelOptions.map((e) => e.toJson()).toList(),
      'reviews': reviews.map((e) => e.toJson()).toList(),
      'availableDates': availableDates.map((e) => e.toJson()).toList(),
      'isActive': isActive,
    };
  }
}
