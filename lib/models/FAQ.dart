import 'package:cloud_firestore/cloud_firestore.dart';

class FAQ {
  final String question;
  final String answer;

  FAQ({
    required this.question, 
    required this.answer});

  factory FAQ.fromFirestore(DocumentSnapshot doc) {
    return FAQ(
      question: doc['question'] as String,
      answer: doc['answer'] as String,
    );
  }

  Map<String, String> toJson() {
    return {
      'question': question,
      'answer': answer,
    };
  }
}
