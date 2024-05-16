import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skywander_app/models/country.dart';

class Visa {
  final Country country;
  final List<dynamic> requirements; // - sinunod ko nalang si gelo
  final String applicationForm, visaDetails;
  final double price;

  Visa(
      {required this.country,
      required this.requirements,
      required this.applicationForm,
      required this.visaDetails,
      required this.price});

  factory Visa.fromFirestore(DocumentSnapshot doc) {
    return Visa(
      country: Country.fromFirestore(doc['country']),
      requirements: doc['requirements'] as List<dynamic>,
      applicationForm: doc['applicationForm'] as String,
      visaDetails: doc['visaDetails'] as String,
      price: doc['price'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country.toJson(),
      'requirements': requirements, //idk dito wahaha -romeo
      'applicationForm': applicationForm,
      'visaDetails': visaDetails,
      'price': price
    };
  }
}
