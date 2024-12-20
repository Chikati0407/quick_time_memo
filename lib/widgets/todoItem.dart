import 'package:animations/animations.dart' show OpenContainer;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

// Project imports:
import 'package:time_memo_app/pages/task_page.dart';
import 'package:time_memo_app/scripts/firestore_access.dart';
import 'package:time_memo_app/scripts/scripts.dart';
import 'package:time_memo_app/widgets/inner_url_text.dart';

class Todoitem extends ConsumerWidget {
  const Todoitem({super.key,required this.task});

  final Map<String, dynamic> task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    String timeMeaasge = create_short_time_message(task["time"].toDate());
    Color timeColor = create_time_color(context, timeMeaasge);

    String fullTimeMessage = create_full_difference_message(task["time"].toDate());

    return Animate(
      effects: const [ShimmerEffect()],
      child: Container(
        height: 100,
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: OpenContainer(
          transitionDuration: const Duration(milliseconds: 300),
          openColor: Theme.of(context).colorScheme.surface,
          closedColor: Theme.of(context).colorScheme.surface,
          closedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          ),
          openShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          ),

          openBuilder: (context, _){
            return TaskPage(task: task);
          },
          closedBuilder: (context, _){
            return NeuContainer(
                offset: const Offset(5,5),
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.surfaceContainer,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      const SizedBox(width: 8,),
                      RoundCheckBox(
                        onTap: (value) async {
                          await Future.delayed(const Duration(milliseconds: 500));
                          await firestore_remove_doc(task["doc_id"]);
                        },
                        isChecked: false,
                        checkedColor: Theme.of(context).colorScheme.secondaryContainer,
                        uncheckedColor: Theme.of(context).colorScheme.surfaceContainer,
                        borderColor: Theme.of(context).colorScheme.onSecondaryContainer,
                        border: Border.all(width: 3),
                        checkedWidget: Icon(Icons.check, color: Theme.of(context).colorScheme.onSecondaryContainer,),
                        // uncheckedWidget: Icon(Icons.clear,color: Theme.of(context).colorScheme.onSecondaryContainer,),
                      ),
                      const SizedBox(width: 16,),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            task["title"],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,

                          ),
                          subtitle: InnerUrlText(text: task["content"],maxLines: 2,), //textoverflowの実装から
                        ),
                      ),
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            VerticalDivider(
                              color: timeColor,
                              width: 4,
                            ),
                            Container(
                              height: 30,
                              width: 50,
                              color: Theme.of(context).colorScheme.surfaceContainer,
                              child: Center(
                                child: Tooltip(
                                  message: fullTimeMessage,
                                  child: Text(
                                    timeMeaasge,
                                    style: TextStyle(
                                      color: timeColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 16,)
                    ],
                  ),
                )
            );
          },
        )
      ),
    );
  }
}
