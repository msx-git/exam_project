import 'package:exam_project/view/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

import '../view/screens/incomes/incomes_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
