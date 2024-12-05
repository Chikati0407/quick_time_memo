// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
import 'package:pattern_background/pattern_background.dart';

// Project imports:
import 'package:time_memo_app/scripts/firestore_access.dart';
import 'package:time_memo_app/scripts/scripts.dart';
import 'package:time_memo_app/widgets/inner_url_text.dart';

class TaskPage extends ConsumerStatefulWidget {
  const TaskPage({super.key, required this.task});

  final Map<String, dynamic> task;

  @override
  ConsumerState createState() => _TaskPageState(task: task);
}

class _TaskPageState extends ConsumerState<TaskPage> {
  _TaskPageState({required this.task});

  final Map<String, dynamic> task;



  String create_difference_message(DateTime time){
    String msg = "";
    final data_map = datetime_difference(time);

    data_map.forEach((key, value){
      msg += value.toString() + key[0] + " ";
    });

    return msg;
  }

  @override
  void initState(){
    super.initState();

    // ref.read(title_provider.notifier).state = task["title"];
    // ref.read(content_provider.notifier).state = task["content"];
    // ref.read(date_provider.notifier).state = task["time"].toDate();
  }



  @override
  Widget build(BuildContext context) {
    // final String title = ref.watch(title_provider);
    // final String content = ref.watch(content_provider);
    // final DateTime date = ref.watch(date_provider);

    final title = task["title"];
    final content = task["content"];
    final date = task["time"].toDate();

    final difference_message = create_difference_message(date);
    final difference_color = (difference_message[0] != "-") ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary;

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
      ),
    );

    final title_text = Container(
      constraints: BoxConstraints(
        minHeight: 60,
      ),
      child: Center(
        child: Text(
            title,
            style: TextStyle(fontSize: 32),
            maxLines: 3,
            overflow: TextOverflow.ellipsis
        ),
      ),
    );

    final content_container = Container(
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.5
      ),
      child: NeuContainer(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(10),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(8),
              child: Wrap(
                children: [
                  InnerUrlText(text: content,style: TextStyle(fontSize: 20),)
                ],
              )
          ),
        ),
      ),
    );

    final completion_button = Container(
      width: double.infinity,
      child: NeuTextButton(
        enableAnimation: true,
        borderRadius: BorderRadius.circular(10),
        buttonColor: Theme.of(context).colorScheme.primaryContainer,
        text: Text("完了にする"),
        onPressed: (){
          firestore_remove_doc(task["doc_id"]);
          Navigator.of(context).pop();
        },
      ),
    );

    // final change_time_row = Row(
    //   children: [
    //     AddDateButton(text: "-1h", function: (){}),
    //     Spacer(),
    //     NeuTextButton(
    //       buttonWidth: MediaQuery.of(context).size.width * 0.4,
    //       enableAnimation: true,
    //       buttonColor: Theme.of(context).colorScheme.surface,
    //       borderRadius: BorderRadius.circular(10),
    //       buttonHeight: 48,
    //       text: Text("aaa"),
    //       onPressed: () async {
    //         ref.read(date_provider.notifier).state = (await showDatePicker(
    //             context: context,
    //             initialDate: date,
    //             firstDate: DateTime.now(),
    //             lastDate: DateTime.now().add(Duration(days: 365),)
    //         ))!;
    //       },
    //     ),
    //     Spacer(),
    //     AddDateButton(text: "+1h", function: (){}),
    //   ],
    // );

    var c1 = Theme.of(context).colorScheme.surface;
    var c2 = Theme.of(context).colorScheme.onSurface;
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: c1,
      body: CustomPaint(
          size: Size(width,height),
          painter: DotPainter(
            dotColor: c2,
            dotRadius: 1,
            spacing: 10,
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.surfaceContainer,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        difference_text,
                        title_text,
                        SizedBox(height: 16,),
                        (content.isNotEmpty) ? content_container : SizedBox(),
                        SizedBox(height: 16,),
                        // change_time_row,
                        Spacer(),
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
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                          border: Border(
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
