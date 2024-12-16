// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
import 'package:pattern_background/pattern_background.dart';

// Project imports:
import 'package:time_memo_app/scripts/firestore_access.dart';
import 'package:time_memo_app/scripts/scripts.dart';
import 'package:time_memo_app/scripts/url_suggest.dart';
import 'package:time_memo_app/state/app_state.dart';
import 'package:time_memo_app/widgets/add_date_button.dart';
import 'package:time_memo_app/widgets/add_modal_content.dart';
import 'package:time_memo_app/widgets/inner_url_text.dart';

class TaskPage extends ConsumerStatefulWidget {
  const TaskPage({super.key, required this.task});

  final Map<String, dynamic> task;


  @override
  ConsumerState createState() => _TaskPageState(task: task);
}

class _TaskPageState extends ConsumerState<TaskPage> {
  _TaskPageState({required this.task});

  Map<String, dynamic> task;


  Future<void> change_field(Timestamp stamp) async {
    await firestore_change_field(task["doc_id"], {
      "title": task["title"],
      "content": task["content"],
      "time": stamp,
    });
  }



  @override
  Widget build(BuildContext context) {

    final difference_message = create_full_difference_message(task["time"].toDate());
    final difference_color = create_time_color(context, difference_message);

    final difference_text = Container(
      height: 60,
      width: double.infinity,
      alignment: Alignment.centerRight,
      child: Text(
        difference_message,
        style: TextStyle(
            fontSize: 20,
            color: difference_color
        ),
      )
    );

    final title_text = Container(
      constraints: const BoxConstraints(
        minHeight: 60,
      ),
      child: Center(
        child: Tooltip(
          message: task["title"],
          child: Text(
            task["title"],
            style: const TextStyle(fontSize: 32),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,

          ),
        ),
      ),
    );

    final content_container = Expanded(
      child: NeuContainer(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(10),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    children: [
                      InnerUrlText(text: task["content"],style: const TextStyle(fontSize: 20),),
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                future:  create_url_suggest(task["content"]),
                builder: (context, snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeCap: StrokeCap.round,
                      ),
                    );
                  }


                  if (snapshot.error != null) {
                    return Center(
                      child: Text('エラーがおきました: ${snapshot.error}'),
                    );
                  }

                  if (snapshot.data!.isEmpty) {
                    return const SizedBox();
                  }

                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: snapshot.data!,
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );

    final change_button = SizedBox(
      width: double.infinity,
      child: NeuTextButton(
        enableAnimation: true,
        borderRadius: BorderRadius.circular(10),
        buttonColor: Theme.of(context).colorScheme.tertiaryContainer,
        text: Text("タスクの変更",style: TextStyle(color: Theme.of(context).colorScheme.onTertiaryContainer),),
        onPressed: () async {

          await showModalBottomSheet<void>(
            showDragHandle: true,
            enableDrag: false,
            context: context,
            builder: (context) {
              return AddModalContent(
                title: task["title"],
                content: task["content"],
                date: task["time"].toDate(),
                doc_id: task["doc_id"],
              );
            },
          );

          await Future.delayed(const Duration(seconds: 1));    //更新待ち

          final List<Map<String, dynamic>> _list = ref.read(docs_provider).value!;

          for (var doc in _list){
            if(doc["doc_id"] == task["doc_id"]){
              setState(() {
                task = doc;
              });
            }
          }

        },
      ),
    );

    final completion_button = Container(
      width: double.infinity,
      child: NeuTextButton(
        enableAnimation: true,
        borderRadius: BorderRadius.circular(10),
        buttonColor: Theme.of(context).colorScheme.primaryContainer,
        text: Text("完了にする",style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),),
        onPressed: (){
          firestore_remove_doc(task["doc_id"]);
          Navigator.of(context).pop();
        },
      ),
    );

    final change_time_row = Row(
      children: [
        AddDateButton(
          text: "-1h",
          function: () async {
            final new_datetime = (task["time"].toDate() as DateTime).add(const Duration(hours: -1));
            final new_timestamp = Timestamp.fromDate(new_datetime);

            await change_field(new_timestamp);

            setState(() {
              task["time"] = new_timestamp;
            });
          }
        ),
        const Spacer(),
        NeuTextButton(
          buttonWidth: MediaQuery.of(context).size.width * 0.4,
          enableAnimation: true,
          buttonColor: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          buttonHeight: 48,
          text: Text("${task["time"].toDate().year}/${task["time"].toDate().month}/${task["time"].toDate().day}-${task["time"].toDate().hour}:${task["time"].toDate().minute.toString().padLeft(2,"0")}"),
          onPressed: () async {
            final DateTime new_date = (await showDatePicker(
                context: context,
                initialDate: task["time"].toDate(),
                firstDate: task["time"].toDate().add(const Duration(days: -365)),
                lastDate: DateTime.now().add(const Duration(days: 365),)
            ))!;
            final TimeOfDay new_time = (await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(task["time"].toDate()),
            ))!;
            final new_timestamp = Timestamp.fromDate(DateTime(new_date.year,new_date.month,new_date.day,new_time.hour,new_time.minute));

            await change_field(new_timestamp);

            setState(() {
              task["time"] = new_timestamp;
            });
          },
        ),
        const Spacer(),
        AddDateButton(
          text: "+1h",
          function: () async {
            final new_datetime = (task["time"].toDate() as DateTime).add(const Duration(hours: 1));
            final new_timestamp = Timestamp.fromDate(new_datetime);

            await change_field(new_timestamp);

            setState(() {
              task["time"] = new_timestamp;
            });
          }
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomPaint(
          painter: DotPainter(
            dotColor: Theme.of(context).colorScheme.onSurface,
            dotRadius: 1,
            spacing: 10,
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.surfaceContainer,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        difference_text,
                        title_text,
                        const SizedBox(height: 16,),
                        (task["content"].isNotEmpty) ? content_container : const SizedBox(),
                        const SizedBox(height: 16,),
                        change_time_row,
                        (task["content"].isNotEmpty) ? const SizedBox(height: 8) : const Spacer(),
                        change_button,
                        const SizedBox(height: 8,),
                        completion_button,
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 30,
                    left: 0,
                    child: Container(
                      width: 80,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSurface,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                          border: const Border(
                            top: BorderSide(
                              color: Colors.black,
                              width: 4,
                            ),
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 4,
                            ),
                            right: BorderSide(
                              color: Colors.black,
                              width: 4,
                            ),
                          )
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    )
                ),
              ],
            ),
          )
      ),
    );
  }
}
