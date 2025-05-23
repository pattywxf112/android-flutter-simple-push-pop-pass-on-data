import 'package:flutter/material.dart';
import 'pages/submission.dart';
import 'pages/submitted.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SDG Report App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 253, 255, 151)),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SubmissionPage(),
        '/submitted': (context) => const SubmittedPage(),
      },
    );
  }
}
