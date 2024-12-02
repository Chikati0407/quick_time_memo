import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_memo_app/scripts/scripts.dart';
import 'package:time_memo_app/state/app_state.dart';
import 'package:time_memo_app/widgets/todoItem.dart';

class ToDoPage extends ConsumerWidget {
  const ToDoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final tasks = ref.watch(docs_provider);

    return Column(
      children: [
        Expanded(
          child: tasks.when(
            error: (error, stack) => Text('Error: $error'),
            loading: () => Center(child: CircularProgressIndicator(),),
            data: (tasks){
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index){
                  final DateTime date = tasks[index]["time"].toDate();

                  if (datetime_difference(date,true)["difference"] > 0) {
                    return Todoitem(
                      task: tasks[index],
                    );
                  } else {
                    return SizedBox();
                  }
                },
              );
            }
          )
        ),
      ],
    );
  }
}
