import 'package:flutter/material.dart';
import 'package:image_generator/features/prompts/ui/create_prompt_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.blueGrey.shade900,
      ),
      debugShowCheckedModeBanner: false,
      home: CreatePromptScreen(),
    );
  }
}

