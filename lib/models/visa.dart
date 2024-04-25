import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skywander_app/models/country.dart';

class Visa{
  final Country country;
  final List<dynamic> requirements; // - sinunod ko nalang si gelo

  Visa({
    required this.country, 
    required this.requirements});

  factory Visa.fromFirestore(DocumentSnapshot doc) {
    return Visa(
      country: Country.fromFirestore(doc['country']),
      requirements: doc['requirements'] as List<dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country.toJson(),
      'requirements': requirements, //idk dito wahaha -romeo
    };
  }
}
