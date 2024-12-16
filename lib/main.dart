// Flutter imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pattern_background/pattern_background.dart';

// Project imports:
import 'package:time_memo_app/pages/to_do_page.dart';
import 'package:time_memo_app/theme.dart';
import 'package:time_memo_app/widgets/bottom_app_bar.dart';
import 'package:time_memo_app/widgets/floatingAcbu.dart';
import 'package:universal_platform/universal_platform.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (UniversalPlatform.isMobile){
    debugPrint("Mobileだぜ");
    final messagingInstance = FirebaseMessaging.instance;
    messagingInstance.requestPermission();
    final fcmToken = await messagingInstance.getToken();
    await FirebaseFirestore.instance.collection("token").doc("now_token").set({"token": fcmToken});
  } else if (UniversalPlatform.isDesktopOrWeb) {
    debugPrint("DesktopかWebだぜ！");
  }

  runApp(
    const ProviderScope(child: MyToDoApp()),
  );
}

class MyToDoApp extends ConsumerWidget {
  const MyToDoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: MaterialTheme().light(),
      darkTheme: MaterialTheme().dark(),
      home: const MyPage(),
    );
  }
}

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: NeuFloatingActionbutton(),
      body: CustomPaint(
          painter: DotPainter(
            dotColor: Theme.of(context).colorScheme.onSurface,
            dotRadius: 1,
            spacing: 10,
          ),
          child: const ToDoPage()),
      bottomNavigationBar: const NeuBottomAppBar(),
    );
  }
}
