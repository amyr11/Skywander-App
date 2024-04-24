import 'package:cloud_firestore/cloud_firestore.dart';
import 'tour.dart';
import 'user.dart';

class UserWishlist {
  final User user;
  final List<Tour> wishlist;

  UserWishlist({required this.user, required this.wishlist});

  factory UserWishlist.fromFirestore(DocumentSnapshot doc) {
    return UserWishlist(
        user: User.fromFirestore(doc['user']),
        wishlist: (doc['wishlist'] as List)
            .map((e) => Tour.fromFirestore(e))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'wishlist': wishlist.map((e) => e.toJson()).toList(),
    };
  }
}
