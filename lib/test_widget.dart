// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:time_memo_app/theme.dart';
import 'package:time_memo_app/widgets/inner_url_text.dart';

void main() async {
  runApp(
    const ProviderScope(
        child: Test_App()
    ),
  );

}

class Test_App extends ConsumerWidget {
  const Test_App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: MaterialTheme().light(),
      darkTheme: MaterialTheme().dark(),
      home: const Scaffold(
        body: Center(
          child: InnerUrlText(text: "https://zenn.dev/kisia_flutter/articles/3219aea98d6016")
        ),
      ),
    );
  }
}
