import 'package:cloud_firestore/cloud_firestore.dart';

class Destination {
  final String name, image;

  Destination({required this.name, required this.image});

  factory Destination.fromFirestore(DocumentSnapshot doc) {
    return Destination(
      name: doc['name'] as String,
      image: doc['image'] as String,
    );
  }

  Map<String, String> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }
}
