import 'package:cloud_firestore/cloud_firestore.dart';

class Theme {
  final String themeName;

  Theme({required this.themeName});

  factory Theme.fromFirestore(DocumentSnapshot doc) {
    return Theme(
      themeName: doc['theme_name'] as String,
    );
  }

  Map<String, String> toJson() {
    return {
      'name': themeName,
    };
  }
}
