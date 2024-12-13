// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:time_memo_app/scripts/scripts.dart';
import 'package:time_memo_app/state/app_state.dart';
import 'package:time_memo_app/widgets/todoItem.dart';

class ToDoPage extends ConsumerStatefulWidget {
  const ToDoPage({super.key});

  @override
  ConsumerState createState() => _ToDoPageState();
}

class _ToDoPageState extends ConsumerState<ToDoPage> {

  late ScrollController controller;

  @override
  void initState() {
    super.initState();

    controller = ScrollController()
      ..addListener((){
        if (controller.position.userScrollDirection == ScrollDirection.reverse) {
          ref.read(bottom_appbar_visible_provider.notifier).state = false;
        } else {
          ref.read(bottom_appbar_visible_provider.notifier).state = true;
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(docs_provider);
    final page_index = ref.watch(page_provider);


    return Column(
      children: [
        Expanded(
            child: tasks.when(
                error: (error, stack) => Text('Error: $error'),
                loading: () => const Center(child: CircularProgressIndicator(),),
                data: (tasks){

                  List<Map<String, dynamic>> processed_tasks = [];

                  switch(page_index){
                    case 0:
                      tasks.sort((a,b) => a["time"].compareTo(b["time"]));
                      processed_tasks = tasks;
                    case 1:   //未来のタスク
                      tasks.sort((a,b) => a["time"].compareTo(b["time"]));
                      tasks.forEach((task){
                        if (datetime_difference(task["time"].toDate(),true)["difference"] >= 0){
                          processed_tasks.add(task);
                        }
                      });

                    case 2:   //過去のタスク
                      tasks.sort((a,b) => b["time"].compareTo(a["time"]));
                      tasks.forEach((task){
                        if (datetime_difference(task["time"].toDate(),true)["difference"] < 0){
                          processed_tasks.add(task);
                        }
                      });
                  }


                  return ListView.builder(
                    controller: controller,
                    itemCount: processed_tasks.length,
                    itemBuilder: (context, index){
                      return Todoitem(task: processed_tasks[index]);
                    }
                  );
                }
            )
        ),
      ],
    );
  }
}
