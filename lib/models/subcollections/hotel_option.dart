import 'package:cloud_firestore/cloud_firestore.dart';

class HotelOption {
  final String hotelId;
  final bool breakfast, lunch, dinner;

  HotelOption(
      {required this.hotelId,
      required this.breakfast,
      required this.lunch,
      required this.dinner});

  factory HotelOption.fromFirestore(DocumentSnapshot doc) {
    return HotelOption(
      hotelId: doc['hotelId'] as String,
      breakfast: doc['breakfast'] as bool,
      lunch: doc['lunch'] as bool,
      dinner: doc['dinner'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hotelId': hotelId,
      'breakfast': breakfast,
      'lunch': lunch,
      'dinner': dinner,
    };
  }
}
