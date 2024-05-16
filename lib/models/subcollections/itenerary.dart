import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skywander_app/models/hotel.dart';

class Itenerary {
  final String eta, etd, image;
  final int day;
  final List<String> agenda;
  final Hotel hotel;
  final bool breakfast, lunch, dinner;

  Itenerary({
    required this.eta,
    required this.etd,
    required this.image,
    required this.day,
    required this.agenda,
    required this.hotel,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
  });

  factory Itenerary.fromFirestore(DocumentSnapshot doc) {
    return Itenerary(
      eta: doc['eta'] as String,
      etd: doc['etd'] as String,
      image: doc['image'] as String,
      day: doc['day'] as int,
      agenda: (doc['agenda'] as List).map((e) => e as String).toList(),
      hotel: Hotel.fromFirestore(doc['hotel']),
      breakfast: doc['breakfast'] as bool,
      lunch: doc['lunch'] as bool,
      dinner: doc['dinner'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eta': eta,
      'etd': etd,
      'image': image,
      'day': day,
      'agenda': agenda,
      'hotel': hotel.toJson(),
      'breakfast': breakfast,
      'lunch': lunch,
      'dinner': dinner,
    };
  }
}
