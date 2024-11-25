import 'package:flutter_riverpod/flutter_riverpod.dart';

final docs_provider = StreamProvider((ref){
  return Stream.value(123456);
});