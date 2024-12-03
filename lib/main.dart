// import 'package:firebase_messaging/firebase_messaging.dart';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pattern_background/pattern_background.dart';

// Project imports:
import 'package:time_memo_app/pages/to_do_page.dart';
import 'package:time_memo_app/theme.dart';
import 'package:time_memo_app/widgets/bottom_app_bar.dart';
import 'package:time_memo_app/widgets/floatingAcbu.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // final messagingInstance = FirebaseMessaging.instance;
  // messagingInstance.requestPermission();
  //
  // final fcmToken = await messagingInstance.getToken();
  // debugPrint('FCM TOKEN: $fcmToken');

  runApp(
    ProviderScope(
      child: MyToDoApp()
    ),
  );
}


class MyToDoApp extends ConsumerWidget {
  const MyToDoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: MaterialTheme().light(),
      darkTheme: MaterialTheme().dark(),
      home: MyPage(),
    );
  }
}


class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // final visible_appbar = ref.watch(bottom_appbar_provider);

    var c1 = Theme.of(context).colorScheme.surface;
    var c2 = Theme.of(context).colorScheme.onSurface;
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: c1,
      floatingActionButton: NeuFloatingActionbutton(),
      body: CustomPaint(
        size: Size(width,height),
        painter: DotPainter(
          dotColor: c2,
          dotRadius: 1,
          spacing: 10,
        ),
        child: ToDoPage()
      ),
      // floatingActionButtonLocation: (visible_appbar) ? FloatingActionButtonLocation.endContained : FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: NeuBottomAppBar(),
    );
  }
}

