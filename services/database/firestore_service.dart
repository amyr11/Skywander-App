import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final User currentUser = FirebaseAuth.instance.currentUser!;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  late final CollectionReference<Map<String, dynamic>> collectionReference;

  /// Creates a new item in the specified collection with the given data.
  ///
  /// The [collectionName] parameter specifies the name of the collection in which to create the item.
  /// The [data] parameter is a map containing the data to be added to the item.
  ///
  /// Returns a [Future] that completes with a [DocumentReference] to the newly created item.
  Future<DocumentReference<Map<String, dynamic>>> createItem(
      String collectionName, Map<String, dynamic> data) {
    return _database.collection(collectionName).add(data);
  }

  /// Get all items from the specified collection.
  ///
  /// The [collectionName] parameter specifies the name of the collection from which to get all items.
  ///
  /// Returns a [Stream] of [QuerySnapshot] containing all items from the specified collection.
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllItems(
      String collectionName) {
    return _database.collection(collectionName).snapshots();
  }

  /// Get an item by its ID from the specified collection.
  ///
  /// The [collectionName] parameter specifies the name of the collection from which to get the item.
  /// The [id] parameter specifies the ID of the item to get.
  ///
  /// Returns a [Future] that completes with a [DocumentSnapshot] containing the item with the specified ID.
  Future<DocumentSnapshot<Map<String, dynamic>>> getItemById(
      String collectionName, String id) async {
    final docRef = _database.collection(collectionName).doc(id);
    return await docRef.get();
  }

  /// Update an item by its ID in the specified collection with the given data.
  ///
  /// The [collectionName] parameter specifies the name of the collection in which to update the item.
  /// The [id] parameter specifies the ID of the item to update.
  /// The [data] parameter is a map containing the data to be updated in the item.
  ///
  /// Returns a [Future] that completes when the item has been updated.
  Future<void> updateItem(
      String collectionName, String id, Map<String, dynamic> data) async {
    final docRef = _database.collection(collectionName).doc(id);
    await docRef.update(data);
  }

  /// Deletes an item by its ID from the specified collection.
  /// 
  /// The [collectionName] parameter specifies the name of the collection from which to delete the item.
  /// The [id] parameter specifies the ID of the item to delete.
  /// 
  /// Returns a [Future] that completes when the item has been deleted.
  Future<void> deleteItem(String collectionName, String id) async {
    final docRef = _database.collection(collectionName).doc(id);
    await docRef.delete();
  }
}
