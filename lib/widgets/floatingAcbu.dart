// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

// Project imports:
import 'package:time_memo_app/state/app_state.dart';
import 'package:time_memo_app/widgets/add_modal_content.dart';

class NeuFloatingActionbutton extends ConsumerWidget {
  NeuFloatingActionbutton({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final visible_appbar = ref.watch(bottom_appbar_visible_provider);

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: (visible_appbar) ? 50 : 75,
      child: NeuTextButton(
        buttonWidth: 150,
        enableAnimation: true,
        text: Text("タスク追加",style: TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.onPrimary),),
        borderRadius: BorderRadius.circular(10),
        buttonColor: Theme.of(context).colorScheme.primary,
        onPressed: (){
          showModalBottomSheet<void>(
            showDragHandle: true,
            enableDrag: false,
            context: context,
            builder: (context) {
              return AddModalContent();
            },
          );
        },
      ),
    );
  }
}
