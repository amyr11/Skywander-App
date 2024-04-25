import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skywander_app/models/user.dart';
import 'package:skywander_app/models/user_wishlist.dart';

class UserAppData {
  final User user;
  final UserWishlist userWishlist; //wala to sa dd pero nilagay ko lang since meron na tayong user wishlist - romeo
  

  UserAppData(
      {
        required this.user,
        required this.userWishlist
      });

  factory UserAppData.fromFirestore(DocumentSnapshot doc) {
    return UserAppData(
      user: User.fromFirestore(doc['user']),
      userWishlist: UserWishlist.fromFirestore(doc['userWishlist'])
      );
  }

  Map<String, dynamic> toJson() {
    return {
      'user':user,
      'userWishlist': userWishlist,
    };
  }
}
