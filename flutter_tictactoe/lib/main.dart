import 'package:flutter/material.dart';
// import 'package:flutter_tictactoe/screens/game.dart';
import 'package:flutter_tictactoe/screens/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Menu(),
    );
  }
}

