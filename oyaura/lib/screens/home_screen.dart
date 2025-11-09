import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome Home')),
      body: Center(
        child: Text(
          'This is your wellness dashboard.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
