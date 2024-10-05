import 'firebase_options.dart';

// import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'state.dart';
import 'screen.dart';
import 'screens/archive.dart';
import 'screens/game.dart';
import 'screens/invalid.dart';
import 'utility/style.dart';
import 'utility/ext.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // setUrlStrategy(PathUrlStrategy());
  GoRouter.optionURLReflectsImperativeAPIs = true;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LyricallyApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LyricallyScreen(child: Game()),
    ),
    GoRoute(
        path: '/games',
        builder: (context, state) => const LyricallyScreen(child: Archive()),
        routes: [
          GoRoute(
            redirect: (context, state) {
              var date = state.pathParameters['date']?.fromYMD();
              if (date?.isToday ?? false) return "/";
              return null;
            },
            path: ':date',
            builder: (context, state) {
              var date = state.pathParameters['date']?.fromYMD();
              return LyricallyScreen(child: Game(date: date));
            },
          ),
        ]),
  ],
  errorBuilder: (context, state) => const LyricallyScreen(child: Invalid()),
);

class LyricallyApp extends StatelessWidget {
  const LyricallyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => GameState(),
        child: MaterialApp.router(
          title: 'Lyrically',
          theme: LyricallyThemeData.instance,
          routerConfig: _router,
        ));
  }
}
