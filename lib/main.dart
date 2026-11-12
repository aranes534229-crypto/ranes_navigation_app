import 'package:flutter/material.dart';
import 'login_screen.dart';

// Entry point of the app. Starts the Flutter application.
void main() {
  runApp(const StudentApp());
}

// The root widget of the app. Configures the MaterialApp theme and home screen.
class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Navigation App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
