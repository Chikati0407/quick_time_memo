import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final docs_provider = StreamProvider<List<Map<String,dynamic>>>((ref){

  final collection = FirebaseFirestore.instance.collection("todo");

  final tasks = collection.snapshots().map((snapshot){
    return snapshot.docs.map((doc) => doc.data()).toList();
  });

  return tasks;
});