import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skywander_app/models/destination.dart';

class Visa {
  final Destination destination;
  final Map<String, double> price;
  final String applicationForm, visaDetails;

  Visa({
    required this.destination,
    required this.price,
    required this.applicationForm,
    required this.visaDetails,
  });

  factory Visa.fromFirestore(DocumentSnapshot doc) {
    return Visa(
      destination: Destination.fromFirestore(doc['destination']),
      price: doc['price'] as Map<String, double>,
      applicationForm: doc['application_form'] as String,
      visaDetails: doc['visa_details'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'destination': destination.toJson(),
      'price': price,
      'applicationForm': applicationForm,
      'visaDetails': visaDetails,
    };
  }
}
