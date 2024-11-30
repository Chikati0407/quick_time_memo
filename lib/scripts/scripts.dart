import 'package:time_memo_app/scripts/firestore_access.dart';

Future<void> add_task(Map<String, dynamic> data) async {

  firestore_add_doc(data);
}