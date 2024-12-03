// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:time_memo_app/state/app_state.dart';
import 'package:time_memo_app/widgets/todoItem.dart';

class ToDoPage extends ConsumerWidget {
  ToDoPage({super.key});




  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final tasks = ref.watch(docs_provider);
    final page_index = ref.watch(page_provider);


    return Column(
      children: [
        Expanded(
          child: tasks.when(
            error: (error, stack) => Text('Error: $error'),
            loading: () => Center(child: CircularProgressIndicator(),),
            data: (tasks){

              switch(page_index){
                case 0:
                tasks.sort((a,b) => b["time"].compareTo(a["time"]));
                case 1:


                case 2:

              }

              //かこのタスク
              // tasks.sort((a,b) => b["time"].compareTo(a["time"]));

              // 未来のタスク
              // tasks.sort((a,b) => a["time"].compareTo(a["time"]));


              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index){
                  // final DateTime date = tasks[index]["time"].toDate();
                  // if (datetime_difference(date,true)["difference"] < 0) {
                  //   return Todoitem(
                  //     task: tasks[index],
                  //   );
                  // } else {
                  //   return SizedBox();
                  // }
                  return Todoitem(task: tasks[index]);
                },
              );
            }
          )
        ),
      ],
    );
  }
}
