import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skywander_app/models/tour.dart';
import 'package:skywander_app/models/user.dart';

class TourTransaction {
  final User user;
  final Tour tour;
  final String
      status; //di ko na inenum since galing naman sa db. controlled naman ata natin mga pwede nilang iinput here? -romeo
  final List<String> passportPicture;
  final DateTime startDate;
  final DateTime endDate;
  final File tickets;
  final double totalFee;
  final String paymentMethod;
  final bool paid;

  TourTransaction({
    required this.user,
    required this.tour,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.passportPicture,
    required this.tickets,
    required this.totalFee,
    required this.paymentMethod,
    required this.paid,
  });

  factory TourTransaction.fromFirestore(DocumentSnapshot doc) {
    return TourTransaction(
      user: User.fromFirestore(doc['user']),
      tour: Tour.fromFirestore(doc['tour']),
      status: doc['status'] as String,
      startDate: doc['startDate'].toDate() as DateTime,
      endDate: doc['endDate'].toDate() as DateTime,
      passportPicture: doc['passport_picture'] as List<String>,
      tickets: File(doc['tickets'] as String),
      totalFee: doc['total_fee'] as double,
      paymentMethod: doc['payment_method'] as String,
      paid: doc['paid'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'tour': tour.toJson(),
      'status': status,
      'start_date': startDate,
      'end_date': endDate,
      'passport_picture': passportPicture,
      'tickets': tickets.path,
      'totalFee': totalFee,
      'payment_method': paymentMethod,
      'paid': paid,
    };
  }
}
