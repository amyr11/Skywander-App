import 'package:cloud_firestore/cloud_firestore.dart';

class OtherAgenda {
  final String other;

  OtherAgenda({required this.other});

  factory OtherAgenda.fromFirestore(DocumentSnapshot doc) {
    return OtherAgenda(
      other: doc['other'] as String,
    );
  }

  Map<String, String> toJson() {
    return {
      'other': other,
    };
  }
}
