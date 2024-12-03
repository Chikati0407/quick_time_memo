// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class AddModalPlusButton extends ConsumerWidget {
  const AddModalPlusButton({super.key, required this.type, required this.value, required this.provider});

  final int value;
  final String type;
  final StateProvider<dynamic> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    DateTime before_value;
    try {
      before_value = ref.watch(provider)as DateTime;
    }catch(e){
      final time = ref.watch(provider) as TimeOfDay;
      before_value = DateTime(0,0,0,time.hour,time.minute);
    }
    

    final text = switch(type){
      "date" => "+${value}d",
      "hour" => "+${value}h",
      "minute" => "+${value}m",
      String() => "error",
    };

    increase_value(){
      ref.read(provider.notifier).state = switch(type){
        "date" => before_value.add(Duration(days: value)),
        "hour" => TimeOfDay.fromDateTime(before_value.add(Duration(hours: value))),
        "minute" => TimeOfDay.fromDateTime(before_value.add(Duration(minutes: value))),
        String() => DateTime.now(),
      };
    }

    return NeuTextButton(
      enableAnimation: true,
      borderRadius: BorderRadius.circular(10),
      buttonWidth: 50,
      text: Text(text),
      onPressed: increase_value()
    );
  }
}
