import 'package:cloud_firestore/cloud_firestore.dart';

class Visa {
  final DocumentReference destination;
  final Map<dynamic, dynamic> price;
  final String visaDetails;

  Visa({
    required this.destination,
    required this.price,
    required this.visaDetails,
  });

  factory Visa.fromFirestore(Map<String, dynamic> doc) {
    return Visa(
      destination: doc['destination'],
      price: doc['price'],
      visaDetails: doc['visa_details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'destination': destination,
      'price': price,
      'visaDetails': visaDetails,
    };
  }
}
