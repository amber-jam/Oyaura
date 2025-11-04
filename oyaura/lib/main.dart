import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Oyaura());
}

class Oyaura extends StatelessWidget {
  const Oyaura({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OyauraState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class OyauraState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<OyauraState>();

    return Scaffold(
      body: Column(
        children: [
          Text('AYEEEE DOWNLOAD OYAURA'), 
          Text(appState.current.asLowerCase),
        
          ElevatedButton(
              onPressed: () {
                print('button pressed!');
              },
              child: Text('Next'),
            ),
        ],
      ),
    );
  }
}
