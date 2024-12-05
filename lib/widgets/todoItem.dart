// Flutter imports:
import 'package:flutter/material.dart';

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

  String create_time_message(DateTime time){
    final date_map = datetime_difference(time,true);

    final String difference = date_map["difference"].toString();
    final String type = date_map["type"][0];
    return difference + type;
  }

  Color create_time_color(BuildContext context, String msg){
    return (msg[0] != "-") ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    String time_meaasge = create_time_message(task["time"].toDate());
    Color time_color = create_time_color(context, time_meaasge);

    return Container(
      height: 100,
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: InkWell(
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return TaskPage(task: task,);
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
                  onTap: (value) async {
                    await Future.delayed(Duration(seconds: 1));
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
                SizedBox(width: 16,),
                Expanded(
                  child: ListTile(
                    title: Text(task["title"]),
                    subtitle: InnerUrlText(text: task["content"],maxLines: 2,), //textoverflowの実装から
                  ),
                ),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      VerticalDivider(
                        color: time_color,
                        width: 4,
                      ),
                      Container(
                        height: 30,
                        width: 50,
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        child: Center(
                          child: Text(
                            time_meaasge,
                            style: TextStyle(
                              color: time_color,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
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
