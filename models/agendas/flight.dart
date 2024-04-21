import 'package:cloud_firestore/cloud_firestore.dart';

import '../airline.dart';

class FlightAgenda {
  final Airline airline;
  final String departFrom, arriveTo, departureTime, arrivalTime;

  FlightAgenda(
      {required this.airline,
      required this.departFrom,
      required this.arriveTo,
      required this.departureTime,
      required this.arrivalTime});

  factory FlightAgenda.fromFirestore(DocumentSnapshot doc) {
    return FlightAgenda(
      airline: Airline.fromFirestore(doc['airline']),
      departFrom: doc['departFrom'] as String,
      arriveTo: doc['arriveTo'] as String,
      departureTime: doc['departureTime'] as String,
      arrivalTime: doc['arrivalTime'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'airline': airline.toJson(),
      'departFrom': departFrom,
      'arriveTo': arriveTo,
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
    };
  }
}
