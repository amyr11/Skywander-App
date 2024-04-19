import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? id;
  final String firstName, middleName, lastName, contactNumber;
  final bool isOnboarded = false;

  User({
    this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.contactNumber
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    return User(
      id: doc.id,
      firstName: doc['firstName'] as String,
      middleName: doc['middleName'] as String,
      lastName: doc['lastName'] as String,
      contactNumber: doc['contactNumber'] as String,
    );
  }

  Map<String, String?> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'contactNumber': contactNumber,
    };
  }
}
