import 'package:cloud_firestore/cloud_firestore.dart';

class Destination {
  final String name, image, popular;

  Destination({required this.name, required this.image, required this.popular});

  factory Destination.fromFirestore(DocumentSnapshot doc) {
    return Destination(
      name: doc['name'] as String,
      image: doc['image'] as String,
      popular: doc['popular'] as String, //NOTE: ginawa kong string nalang din para madali sa map HAHAHAHA
    );
  }

  Map<String, String> toJson() {
    return {
      'name': name,
      'image': image,
      "popular": popular
    };
  }
}
