import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skywander_app/models/tour.dart';
import 'package:skywander_app/models/user.dart';

class TourReview {
  final User user;
  final Tour tour;
  final int rating;
  final String comment;

  TourReview({
    required this.user,
    required this.tour,
    required this.rating,
    required this.comment,
  });

  factory TourReview.fromFirestore(DocumentSnapshot doc) {
    return TourReview(
      user: User.fromFirestore(doc['user']),
      tour: Tour.fromFirestore(doc['tour']),
      rating: doc['rating'] as int,
      comment: doc['comment'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'tour': tour.toJson(),
      'rating': rating,
      'comment': comment,
    };
  }
}
