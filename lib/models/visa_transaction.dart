
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skywander_app/models/user.dart';

class VisaTransaction {

  final User user;
  final String status; // di ko na ginawang enum since controlled namna ata natin inputs for status? -romeo
 
 
  VisaTransaction(
      {
        required this.user,
        required this.status,
        });

  factory VisaTransaction.fromFirestore(DocumentSnapshot doc) {
    return VisaTransaction(
      user: User.fromFirestore(doc['user']),
      status: doc['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'status': status,
    };
  }
}
