import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                  return Todoitem(
                    title: tasks[index]["title"],
                    subtitle: tasks[index]["content"],
                    icon: Icons.blender,
                  );
                },
              );
            }
          )
        ),
      ],
    );
  }
}
