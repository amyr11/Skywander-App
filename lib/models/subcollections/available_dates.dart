import 'package:cloud_firestore/cloud_firestore.dart';

class AvailableDates {
  final DateTime startDate, endDate;
  final double additionFees;

  AvailableDates(
      {required this.startDate,
      required this.endDate,
      required this.additionFees});

  factory AvailableDates.fromFirestore(DocumentSnapshot doc) {
    return AvailableDates(
      startDate: (doc['startDate'] as Timestamp).toDate(),
      endDate: (doc['endDate'] as Timestamp).toDate(),
      additionFees: doc['additionFees'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'endDate': endDate,
      'additionFees': additionFees,
    };
  }
}