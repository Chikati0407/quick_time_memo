import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class NeuFloatingActionbutton extends ConsumerWidget {
  const NeuFloatingActionbutton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NeuTextButton(
      buttonWidth: 150,
      buttonHeight: 75,
      enableAnimation: true,
      text: Text("タスク追加",style: TextStyle(fontSize: 18),),
      borderRadius: BorderRadius.circular(10),
      onPressed: (){
        showModalBottomSheet<void>(
          showDragHandle: true,
          enableDrag: false,
          context: context,
          builder: (context) {
            return Container(
              height: 300,
              child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.music_note),
                        title: Text('Music'),
                        subtitle: Text('Select your favorite music'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.photo_album),
                        title: Text('Photos'),
                        subtitle: Text('Select your favorite photos'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.videocam),
                        title: Text('Video'),
                        subtitle: Text('Select your favorite video'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  )),
            );
          },
        );
      },
    );
  }
}
