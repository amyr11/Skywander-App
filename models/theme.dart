import 'package:cloud_firestore/cloud_firestore.dart';

class Theme {
  final String name;

  Theme({required this.name});

  factory Theme.fromFirestore(DocumentSnapshot doc) {
    return Theme(
      name: doc['name'] as String,
    );
  }

  Map<String, String> toJson() {
    return {
      'name': name,
    };
  }
}
