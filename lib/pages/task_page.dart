import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
import 'package:pattern_background/pattern_background.dart';

class TaskPage extends ConsumerWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final title_text = Container(
      constraints: BoxConstraints(
        minHeight: 60,
      ),
      child: Center(
        child: Text(
          "タイトルタイトルタイトルタイトルタイトル",
          style: TextStyle(fontSize: 32),
          maxLines: 3,
          overflow: TextOverflow.ellipsis
        ),
      ),
    );
    final content_container = NeuContainer(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Wrap(
          children: [
            Text("こんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちは")
          ],
        )
      ),
    );



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
                        SizedBox(height: 60,),
                        title_text,
                        content_container,
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
