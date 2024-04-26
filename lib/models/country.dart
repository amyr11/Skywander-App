import 'package:cloud_firestore/cloud_firestore.dart';

class Country {
  final String countryName;
  final String countryImageUrl;

  Country({
    required this.countryName,
    required this.countryImageUrl,
  });

  factory Country.fromFirestore(DocumentSnapshot doc) {
    return Country(
      countryName: doc['countryName'] as String,
      countryImageUrl: doc['countryImageUrl'] as String,
    );
  }

  Map<String, String> toJson() {
    return {
      'country_name': countryName,
      'country_image_url': countryImageUrl,
    };
  }
}
