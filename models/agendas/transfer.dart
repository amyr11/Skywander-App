import 'package:cloud_firestore/cloud_firestore.dart';

class TransferAgenda {
  final String transferFrom, transferTo, transferVia;

  TransferAgenda(
      {required this.transferFrom,
      required this.transferTo,
      required this.transferVia});

  factory TransferAgenda.fromFirestore(DocumentSnapshot doc) {
    return TransferAgenda(
      transferFrom: doc['transferFrom'] as String,
      transferTo: doc['transferTo'] as String,
      transferVia: doc['transferVia'] as String,
    );
  }

  Map<String, String> toJson() {
    return {
      'transferFrom': transferFrom,
      'transferTo': transferTo,
      'transferVia': transferVia,
    };
  }
}
