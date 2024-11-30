import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

final date_provider = StateProvider<DateTime>((ref) => DateTime.now());
final time_provider = StateProvider<TimeOfDay>((ref) => TimeOfDay.now());

class AddModalContent extends ConsumerWidget {
  const AddModalContent({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final DateTime date = ref.watch(date_provider);
    final TimeOfDay time = ref.watch(time_provider);

    final title_textfield = TextField(
      style: TextStyle(
        fontSize: 24,
      ),
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "新しいタスク",
          hintStyle: TextStyle(fontSize: 24)
      ),
    );
    final content_container = NeuContainer(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          keyboardType: TextInputType.multiline,
          maxLines: 3,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "詳細を追加",
          ),
        ),
      ),
    );
    final date_row = Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        NeuTextButton(
          buttonWidth: 200,
          enableAnimation: true,
          buttonColor: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          buttonHeight: 48,
          text: Text("${date.month}/${date.day}"),
          onPressed: () async {
            ref.read(date_provider.notifier).state = (await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365),)
            ))!;
          },
        ),
        Spacer(),
        NeuTextButton(
          enableAnimation: true,
          borderRadius: BorderRadius.circular(10),
          buttonWidth: 50,
          buttonColor: Theme.of(context).colorScheme.tertiary,
          text: Text("+1d",style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),),
          onPressed: (){
            ref.watch(date_provider.notifier).state = date.add(Duration(days: 1));
          },
        ),
        SizedBox(width: 8,),
        NeuTextButton(
          enableAnimation: true,
          borderRadius: BorderRadius.circular(10),
          buttonWidth: 50,
          buttonColor: Theme.of(context).colorScheme.tertiary,
          text: Text("+2d",style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),),
          onPressed: (){
            ref.watch(date_provider.notifier).state = date.add(Duration(days: 2));
          },
        ),
        SizedBox(width: 8,),
        NeuTextButton(
          enableAnimation: true,
          borderRadius: BorderRadius.circular(10),
          buttonWidth: 50,
          buttonColor: Theme.of(context).colorScheme.tertiary,
          text: Text("+3d",style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),),
          onPressed: (){
            ref.watch(date_provider.notifier).state = date.add(Duration(days: 3));
          },
        ),
      ],
    );
    final time_row = Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        NeuTextButton(
          buttonWidth: 200,
          enableAnimation: true,
          buttonColor: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          buttonHeight: 48,
          text: Text("${time.hour}:${time.minute}"),
          onPressed: () async {
            ref.read(time_provider.notifier).state = (await showTimePicker(
              context: context,
              initialTime: time,
            ))!;
          },
        ),
        Spacer(),
        NeuTextButton(
          enableAnimation: true,
          borderRadius: BorderRadius.circular(10),
          buttonWidth: 50,
          buttonColor: Theme.of(context).colorScheme.tertiary,
          text: Text("+30m",style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),),
          onPressed: (){
            ref.watch(time_provider.notifier).state = TimeOfDay.fromDateTime(DateTime(0,0,0,time.hour,time.minute).add(Duration(minutes: 30)));
          },
        ),
        SizedBox(width: 8,),
        NeuTextButton(
          enableAnimation: true,
          borderRadius: BorderRadius.circular(10),
          buttonWidth: 50,
          buttonColor: Theme.of(context).colorScheme.tertiary,
          text: Text("+1h",style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),),
          onPressed: (){
            ref.watch(time_provider.notifier).state = TimeOfDay.fromDateTime(DateTime(0,0,0,time.hour,time.minute).add(Duration(hours: 1)));
          },
        ),
        SizedBox(width: 8,),
        NeuTextButton(
          enableAnimation: true,
          borderRadius: BorderRadius.circular(10),
          buttonWidth: 50,
          buttonColor: Theme.of(context).colorScheme.tertiary,
          text: Text("+2h",style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),),
          onPressed: (){
            ref.watch(time_provider.notifier).state = TimeOfDay.fromDateTime(DateTime(0,0,0,time.hour,time.minute).add(Duration(hours: 2)));
          },
        ),
      ],
    );
    final button_row = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        NeuTextButton(
          enableAnimation: true,
          text: Text("キャンセル"),
          borderRadius: BorderRadius.circular(10),
          buttonWidth: 160,
          onPressed: () => Navigator.of(context).pop(),
        ),
        NeuTextButton(
          enableAnimation: true,
          text: Text("タスクに追加"),
          borderRadius: BorderRadius.circular(10),
          buttonWidth: 160,
        ),
      ],
    );


    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        right: 16,
        left: 16,
      ),
      child: Container(
        height: 400,
        child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                title_textfield,
                SizedBox(height: 4,),
                content_container,
                SizedBox(height: 8,),
                date_row,
                SizedBox(height: 8,),
                time_row,
                SizedBox(height: 8,),
                Divider(),
                button_row,
              ],
            )),
      ),
    );
  }
}
