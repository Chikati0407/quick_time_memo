// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class AddDateButton extends ConsumerWidget {
  const AddDateButton({super.key, required this.text, required this.function});

  final String text;
  final void Function() function;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return NeuTextButton(
      enableAnimation: true,
      borderRadius: BorderRadius.circular(10),
      buttonWidth: 50,
      buttonColor: Theme.of(context).colorScheme.tertiary,
      text: Text(text,style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),),
      onPressed: function,
    );
  }
}
