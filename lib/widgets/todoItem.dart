import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class Todoitem extends ConsumerWidget {
  const Todoitem({super.key, required this.title, required this.subtitle, required this.icon});

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: InkWell(
        onTap: (){print("todoitem:タップきた");},
        child: NeuContainer(
          offset: Offset(5,5),
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                SizedBox(width: 8,),
                RoundCheckBox(
                  onTap: (value){},
                  isChecked: false,
                  checkedColor: Color(0xffecc7d3),
                  borderColor: Colors.black,
                  border: Border.all(width: 3),
                  checkedWidget: Icon(Icons.check),
                  uncheckedWidget: Icon(icon),
                ),
                SizedBox(width: 16,),
                Expanded(
                  child: ListTile(
                    title: Text(title),
                    subtitle: Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Icon(Icons.delete),
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
