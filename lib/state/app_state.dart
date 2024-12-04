// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final title_provider = StateProvider<String>((ref) => "");
final content_provider = StateProvider<String>((ref) => "");
final date_provider = StateProvider<DateTime>((ref) => DateTime.now());


final page_provider = StateProvider<int>((ref){
  return 0;
});


final bottom_appbar_provider = StateProvider<bool>((ref){
  return true;
});


final docs_provider = StreamProvider<List<Map<String,dynamic>>>((ref){

  final collection = FirebaseFirestore.instance.collection("todo");

  var tasks = collection.snapshots().map((snapshot){
    return snapshot.docs.map((doc){
      var data = doc.data();
      data["doc_id"] = doc.id;
      return data;
    }).toList();
  });

  return tasks;
});


// final attribute_provider = StreamProvider<List<Map<String, dynamic>>>((ref){
//   final collection = FirebaseFirestore.instance.collection("input_attribute");
//
//   var attribute = collection.snapshots().map((snapshot){
//     return snapshot.docs.map((doc) => doc.data()).toList();
//   });
//
//   return attribute;
// });
