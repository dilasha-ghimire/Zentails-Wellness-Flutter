import 'package:flutter/material.dart';
import 'package:zentails_wellness/view/splash_screen_view.dart';
import 'package:zentails_wellness/view/login_page_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zentails Wellness',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(), 
      routes: {
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
