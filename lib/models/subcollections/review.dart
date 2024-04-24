import 'package:cloud_firestore/cloud_firestore.dart';
import '../user.dart';

class Review {
  final User user;
  final int rating;
  final String comment;

  Review({required this.user, required this.rating, required this.comment});

  factory Review.fromFirestore(DocumentSnapshot doc) {
    return Review(
        user: User.fromFirestore(doc['user']),
        rating: doc['rating'] as int,
        comment: doc['comment'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'rating': rating,
      'comment': comment,
    };
  }
}
