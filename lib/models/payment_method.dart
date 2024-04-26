import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentMethod {
  final String payMethodName;
  final String payMethodDetails;
  final String payMethodClassification;

  PaymentMethod({
    required this.payMethodName,
    required this.payMethodDetails,
    required this.payMethodClassification,
  });

  factory PaymentMethod.fromFirestore(DocumentSnapshot doc) {
    return PaymentMethod(
      payMethodName: doc['pay_method_name'] as String,
      payMethodDetails: doc['pay_method_details'] as String,
      payMethodClassification: doc["pay_method_classification"] as String,
    );
  }

  Map<String, String> toJson() {
    return {
      'pay_method_name': payMethodName,
      'pay_method_details': payMethodDetails,
      'pay_method_classification': payMethodClassification
    };
  }
}
