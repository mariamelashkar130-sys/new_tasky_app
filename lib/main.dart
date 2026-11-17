import 'package:flutter/material.dart';
import 'package:taskyapp/core/services/preferences_manger.dart';
import 'package:taskyapp/core/theme/dark_theme.dart';
import 'package:taskyapp/core/theme/light_theme.dart';
import 'package:taskyapp/core/theme/theme_controler.dart';
import 'package:taskyapp/core/feature/navigation/main_screen.dart';
import 'package:taskyapp/core/feature/welcome/welcome_screen.dart';

import 'core/constants/storage_key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesManger().init();
  ThemeControler().init();

  String? username = PreferencesManger().getString((StorageKey.username));

  //pref.clear();
  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});
  final String? username;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeControler.themeNotifier,
      builder: (context, ThemeMode themeMode, Widget? child) {
        return MaterialApp(
          theme: lighttheme,
          darkTheme: darktheme,
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          title: 'Tasky app',
          home: username == null ? WelcomeScreen() : MainScreen(),
        );
      },
    );
  }
}
