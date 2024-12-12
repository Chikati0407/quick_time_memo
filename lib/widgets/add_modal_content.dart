// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

// Project imports:
import 'package:time_memo_app/scripts/firestore_access.dart';
import 'package:time_memo_app/state/app_state.dart';
import 'package:time_memo_app/widgets/add_date_button.dart';

final enable_entry_provider = StateProvider<bool>((ref){
  return false;
});




class AddModalContent extends ConsumerWidget {
  const AddModalContent({super.key, this.doc_id});

  final String? doc_id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(title_provider);
    final content = ref.watch(content_provider);
    final DateTime date = ref.watch(date_provider);
    // final selected_index = ref.watch(select_chip_provider);
    final enable_entry = ref.watch(enable_entry_provider);

    final title_textfield = TextFormField(
      initialValue: title,
      style: TextStyle(
        fontSize: 24,
      ),
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "新しいタスク",
          hintStyle: TextStyle(fontSize: 24)
      ),
      onChanged: (value){
        ref.read(title_provider.notifier).state = value;
        ref.read(enable_entry_provider.notifier).state = value.isNotEmpty;
      },
    );
    final content_container = NeuContainer(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          initialValue: content,
          keyboardType: TextInputType.multiline,
          maxLines: 3,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "詳細を追加",
          ),
          onChanged: (value) => ref.read(content_provider.notifier).state = value,
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
            final _date = (await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365),)
            ))!;
            ref.read(date_provider.notifier).state = DateTime(_date.year, _date.month, _date.day, date.hour, date.minute);
          },
        ),
        Spacer(),
        AddDateButton(
            text: "+1d",
            function: (){
              ref.watch(date_provider.notifier).state = date.add(Duration(days: 1));
            }
        ),
        SizedBox(width: 8,),
        AddDateButton(
          text: "+2d",
          function: (){
            ref.watch(date_provider.notifier).state = date.add(Duration(days: 2));
          },
        ),
        SizedBox(width: 8,),
        AddDateButton(
            text: "+3d",
            function: (){
              ref.watch(date_provider.notifier).state = date.add(Duration(days: 3));
            }
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
          text: Text("${date.hour}:${date.minute.toString().padLeft(2,"0")}"),
          onPressed: () async {
            final time = (await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(date),
            ))!;
            ref.read(date_provider.notifier).state = DateTime(date.year, date.month, date.day, time.hour, time.minute);
          },
        ),
        Spacer(),
        AddDateButton(
          text: "+30m",
          function: (){
            ref.watch(date_provider.notifier).state = date.add(Duration(minutes: 30));
          },
        ),
        SizedBox(width: 8,),
        AddDateButton(
          text: "+1h",
          function: (){
            ref.watch(date_provider.notifier).state = date.add(Duration(hours: 1));
          },
        ),
        SizedBox(width: 8,),
        AddDateButton(
          text: "+2h",
          function: (){
            ref.watch(date_provider.notifier).state = date.add(Duration(hours: 2));
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
          buttonColor: Theme.of(context).colorScheme.primaryContainer,
          onPressed: (){
            ref.read(title_provider.notifier).state = "";
            ref.read(content_provider.notifier).state = "";
            ref.read(date_provider.notifier).state = DateTime.now();
            ref.read(enable_entry_provider.notifier).state = false;
            Navigator.of(context).pop();
          },
        ),
        NeuTextButton(
            enableAnimation: enable_entry,
            text: Text("決定"),
            borderRadius: BorderRadius.circular(10),
            buttonWidth: 160,
            buttonColor:(enable_entry) ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.surfaceContainerHigh,
            onPressed: () async {
              if (enable_entry) {
                if (doc_id == null){
                  await firestore_add_doc({
                    "title": title,
                    "content": content,
                    "time": Timestamp.fromDate(date)
                  });
                } else {
                  await firestore_change_field(doc_id!, {
                    "title": title,
                    "content": content,
                    "time": Timestamp.fromDate(date),
                  });
                }

                ref.read(title_provider.notifier).state = "";
                ref.read(content_provider.notifier).state = "";
                ref.read(date_provider.notifier).state = DateTime.now();
                ref.read(enable_entry_provider.notifier).state = false;
                Navigator.of(context).pop();
              }
            }
        ),
      ],
    );

    // 属性一旦保留
    // final chip_list = SingleChildScrollView(
    //   scrollDirection: Axis.horizontal,
    //   child: Row(
    //     children: List<Widget>.generate(2, (index) {
    //       return Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 4.0),
    //         child: ChoiceChip(
    //           avatar: (selected_index == index) ? null : Icon(Icons.add),
    //           label: Text("ラベル"),
    //           selected: selected_index == index,
    //           selectedColor: Theme.of(context).colorScheme.tertiaryContainer,
    //           labelStyle: TextStyle(
    //             color: Theme.of(context).colorScheme.onTertiaryContainer,
    //           ),
    //           checkmarkColor: Theme.of(context).colorScheme.onTertiaryContainer,
    //           onSelected: (selected) {
    //             ref.read(select_chip_provider.notifier).state = index;
    //           },
    //         ),
    //       );
    //     }).toList(),
    //   ),
    // );


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
                // chip_list,
                SizedBox(height: 8,),
                Divider(),
                button_row,
              ],
            )),
      ),
    );

  }
}
