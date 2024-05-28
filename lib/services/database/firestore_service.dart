import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skywander_app/models/destination.dart';
import 'package:skywander_app/models/tour.dart';

const String TOUR_COLLECTION = 'tour';
const String DESTINATION_COLLECTION = 'destination';

class FirestoreService {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final User currentUser = FirebaseAuth.instance.currentUser!;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  late final CollectionReference _toursRef;
  late final CollectionReference _destinationsRef;

  FirestoreService() {
    _toursRef = _database.collection(TOUR_COLLECTION).withConverter<Tour>(
        fromFirestore: (snapshots, _) => Tour.fromFirestore(
              snapshots.data()!,
            ),
        toFirestore: (tour, _) => tour.toJson());
    _destinationsRef =
        _database.collection(DESTINATION_COLLECTION).withConverter<Destination>(
            fromFirestore: (snapshots, _) => Destination.fromFirestore(
                  snapshots.data()!,
                ),
            toFirestore: (destination, _) => destination.toJson());
  }

  /// Get all Tours
  Stream<QuerySnapshot> getTours() {
    return _toursRef.snapshots();
  }

  /// Get all the Tours from Tour collection filtering by the "recommended" field
  Stream<QuerySnapshot> getRecommendedTours() {
    return _toursRef.where('recommended', isEqualTo: true).snapshots();
  }

  /// Get latest Tours by comparing the "created_at" field and getting only the latest 5
  Stream<QuerySnapshot> getLatestTours() {
    return _toursRef
        .orderBy('created_at', descending: true)
        .limit(5)
        .snapshots();
  }

  /// Get Destinations from references
  Stream<QuerySnapshot> getDestinationsFromReferences(List refs) {
    return _destinationsRef
        .where(FieldPath.documentId, whereIn: refs)
        .snapshots();
  }

  /// Get Destinations filtering by the "popular" field
  Stream<QuerySnapshot> getPopularDestinations() {
    return _destinationsRef.where('popular', isEqualTo: true).snapshots();
  }

  /// Get all Destinations
  Stream<QuerySnapshot> getDestinations() {
    return _destinationsRef.snapshots();
  }
}
