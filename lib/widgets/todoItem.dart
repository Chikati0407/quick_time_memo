import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:time_memo_app/pages/task_page.dart';
import 'package:time_memo_app/widgets/inner_url_text.dart';

class Todoitem extends ConsumerWidget {
  const Todoitem({super.key,required this.task});

  final Map<String, dynamic> task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 100,
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: InkWell(
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return TaskPage();
            }),
          );
        },
        child: NeuContainer(
          offset: Offset(5,5),
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.surfaceContainer,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                SizedBox(width: 8,),
                RoundCheckBox(
                  onTap: (value){},
                  isChecked: false,
                  checkedColor: Theme.of(context).colorScheme.secondaryContainer,
                  uncheckedColor: Theme.of(context).colorScheme.surfaceContainer,
                  borderColor: Theme.of(context).colorScheme.onSecondaryContainer,
                  border: Border.all(width: 3),
                  checkedWidget: Icon(Icons.check, color: Theme.of(context).colorScheme.onSecondaryContainer,),
                  // uncheckedWidget: Icon(Icons.clear,color: Theme.of(context).colorScheme.onSecondaryContainer,),
                ),
                SizedBox(width: 16,),
                Expanded(
                  child: ListTile(
                    title: Text(task["title"]),
                    subtitle: InnerUrlText(text: task["content"],maxLines: 2,), //textoverflowの実装から
                  ),
                ),
                Center(

                ),
                SizedBox(width: 16,)
              ],
            ),
          )
        ),
      ),
    );
  }
}
