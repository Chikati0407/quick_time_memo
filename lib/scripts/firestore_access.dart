import 'package:cloud_firestore/cloud_firestore.dart';

void firestore_change_field(String doc_id, String field, dynamic data){
  final collection = FirebaseFirestore.instance.collection("todo");
  collection.doc(doc_id).set({field: data});
}