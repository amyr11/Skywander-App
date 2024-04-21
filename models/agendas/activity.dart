import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityAgenda {
  final String title, description, location;

  ActivityAgenda(
      {required this.title, required this.description, required this.location});

  factory ActivityAgenda.fromFirestore(DocumentSnapshot doc) {
    return ActivityAgenda(
      title: doc['title'] as String,
      description: doc['description'] as String,
      location: doc['location'] as String,
    );
  }

  Map<String, String> toJson() {
    return {
      'title': title,
      'description': description,
      'location': location,
    };
  }
}
