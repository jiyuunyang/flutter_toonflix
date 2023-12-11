import 'package:flutter/material.dart';
import 'package:flutterwebtoon/screens/home_screen.dart';
import 'package:flutterwebtoon/services/api_service.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
