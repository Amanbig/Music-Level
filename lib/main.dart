import 'package:flutter/material.dart';
import 'package:music_level/screens/auth/login_screen.dart';
import 'package:music_level/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      initialRoute: '/', // Set initial route to Login page
      routes: {
        '/' : (context) => const MainScreen(),
        '/auth': (context) => const LoginPage(),
      },
    );
  }
}
