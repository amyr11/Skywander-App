import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skywander_app/models/user.dart';

class VisaTransaction {
  final User user;
  final String status, visaFile, paymentMethod;
  final Map<String, double> fee;
  final bool paid;
  final DateTime createdAt, updatedAt;

  VisaTransaction(
      {required this.user,
      required this.status,
      required this.visaFile,
      required this.paymentMethod,
      required this.fee,
      required this.paid,
      required this.createdAt,
      required this.updatedAt});

  factory VisaTransaction.fromFirestore(DocumentSnapshot doc) {
    return VisaTransaction(
      user: User.fromFirestore(doc['user']),
      status: doc['status'] as String,
      visaFile: doc['visa_file'] as String,
      paymentMethod: doc['payment_method'] as String,
      fee: doc['fee'] as Map<String, double>,
      paid: doc['paid'] as bool,
      createdAt: (doc['created_at'] as Timestamp).toDate(),
      updatedAt: (doc['updated_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'status': status,
      'visa_file': visaFile,
      'payment_method': paymentMethod,
      'fee': fee,
      'paid': paid,
      'created_at': createdAt,
      'updated_at': updatedAt
    };
  }
}
