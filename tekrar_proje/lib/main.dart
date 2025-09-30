import 'package:flutter/material.dart';
import 'package:tekrar_proje/home_screen.dart';

void main() {
  runApp(Uygulamam());
}

class Uygulamam extends StatelessWidget {
  const Uygulamam({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          title: Text(
            'Tekrar Projem',
            style: TextStyle(fontSize: 30, color: Colors.white70),
          ),
        ),
        body: home_screen(),
      ),
    );
  }
}
