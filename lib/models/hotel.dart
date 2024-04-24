import 'package:cloud_firestore/cloud_firestore.dart';

class Hotel {
  final String name;
  final String logoUrl;
  final String address;
  final String mapLink;

  Hotel(
      {required this.name,
      required this.logoUrl,
      required this.address,
      required this.mapLink});

  factory Hotel.fromFirestore(DocumentSnapshot doc) {
    return Hotel(
      name: doc['name'] as String,
      logoUrl: doc['logoUrl'] as String,
      address: doc['address'] as String,
      mapLink: doc['mapLink'] as String,
    );
  }

  Map<String, String> toJson() {
    return {
      'name': name,
      'logoUrl': logoUrl,
      'address': address,
      'mapLink': mapLink,
    };
  }
}
