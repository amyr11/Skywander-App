import 'package:cloud_firestore/cloud_firestore.dart';

class Itenerary {
  final int day;
  final String imageUrl;
  final List<dynamic> agenda; // rip bawal union types sa dart, gawin nalang ba tong enum instead of dynamic? - gelo
  final bool breakfast, lunch, dinner;

  Itenerary(
      {required this.day,
      required this.imageUrl,
      required this.agenda,
      required this.breakfast,
      required this.lunch,
      required this.dinner});

  factory Itenerary.fromFirestore(DocumentSnapshot doc) {
    return Itenerary(
      day: doc['day'] as int,
      imageUrl: doc['imageUrl'] as String,
      agenda: doc['agenda'] as List<dynamic>,
      breakfast: doc['breaakfast'] as bool,
      lunch: doc['lunch'] as bool,
      dinner: doc['dinner'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'imageUrl': imageUrl,
      'agenda': agenda,
      'breakfast': breakfast,
      'lunch': lunch,
      'dinner': dinner,
    };
  }
}