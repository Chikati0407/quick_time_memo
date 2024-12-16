// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:time_memo_app/state/app_state.dart';

class NeuBottomAppBar extends ConsumerWidget {
  const NeuBottomAppBar({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final visibleAppbar = ref.watch(bottom_appbar_visible_provider);
    final pageIndex = ref.watch(page_provider);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: (visibleAppbar) ? 80.0 : 0,
      decoration: BoxDecoration(
        border: Border.all(
          width: 4,
        ),
      ),
      child: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SegmentedButton(
              selected: {pageIndex},
              onSelectionChanged: (selected){
                ref.read(page_provider.notifier).state = selected.first;
              },
              segments: const [
                ButtonSegment(value: 0,label: Text("ALL"),icon: Icon(Icons.clear_all)),
                ButtonSegment(value: 1,label: Text("SAFE"),icon: Icon(Icons.browse_gallery_outlined)),
                ButtonSegment(value: 2,label: Text("OUT"),icon: Icon(Icons.history_outlined)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
