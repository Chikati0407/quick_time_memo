// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

void firestore_change_field(String doc_id, String field, dynamic data){
  final collection = FirebaseFirestore.instance.collection("todo");
  collection.doc(doc_id).set({field: data});
}

Future<void> firestore_add_doc(Map<String,dynamic> data) async {
  final collection = FirebaseFirestore.instance.collection("todo");
  await collection.add(data);
}

Future<void> firestore_remove_doc(String doc_id) async {
  final collection = FirebaseFirestore.instance.collection("todo");
  await collection.doc(doc_id).delete();
}
