import 'package:flutter/material.dart';

import 'Home.dart';

void main() {
  runApp(AlphabetGridViewApp());
}

class AlphabetGridViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alphabet Grid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AlphabetGridView(),
    );
  }
}

class AlphabetGridView extends StatelessWidget {
  final List<String> alphabet = List.generate(
      26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          "Selecione uma letra",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            fontFamily: 'Roboto',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu_book),
          onPressed: () {},
        ),
        backgroundColor: const Color(0xFF008751),
      ),
      body: GridView.count(
        crossAxisCount: 3, // Number of columns in the grid
        padding: const EdgeInsets.all(16.0),
        children: alphabet.map((letter) {
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            // opcional: define a elevação do card
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(letter),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF008751),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    letter,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
