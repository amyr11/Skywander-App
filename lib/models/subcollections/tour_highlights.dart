import 'package:cloud_firestore/cloud_firestore.dart';

class TourHighlight {
  final String city;
  final List<String> touristSpots;

  TourHighlight({required this.city, required this.touristSpots});

  factory TourHighlight.fromFirestore(DocumentSnapshot doc) {
    return TourHighlight(
        city: doc['city'] as String,
        touristSpots: doc['tourist_spots'] as List<String>);
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'touristSpots': touristSpots,
    };
  }
}
