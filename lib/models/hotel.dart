import 'package:cloud_firestore/cloud_firestore.dart';

class Hotel {
  final String name;
  final String logo;
  final String address;
  final String mapLink;

  Hotel(
      {required this.name,
      required this.logo,
      required this.address,
      required this.mapLink});

  factory Hotel.fromFirestore(DocumentSnapshot doc) {
    return Hotel(
      name: doc['name'] as String,
      logo: doc['logo'] as String,
      address: doc['address'] as String,
      mapLink: doc['map_link'] as String,
    );
  }

  Map<String, String> toJson() {
    return {
      'name': name,
      'logo': logo,
      'address': address,
      'mapLink': mapLink,
    };
  }
}
