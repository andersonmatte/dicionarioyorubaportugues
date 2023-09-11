import 'dart:async' show Future;

import 'package:csv/csv.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData, rootBundle;

class Home extends StatefulWidget {
  final String letter;

  Home(this.letter);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<Home> {
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
        body: FutureBuilder<List<List<dynamic>>>(
          future: readCSV(),
          builder: (BuildContext context,
              AsyncSnapshot<List<List<dynamic>>> snapshot) {
            if (snapshot.hasData) {
              List<List<dynamic>> csvData = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: csvData.length,
                itemBuilder: (BuildContext context, int index) {
                  String text = csvData[index][0].toString();
                  String titleText = '';
                  String subtitleText = '';
                  List<String> lines = text.split('\n');
                  for (String line in lines) {
                    int colonIndex = line.indexOf(':');
                    if (colonIndex != -1) {
                      titleText = line.substring(0, colonIndex).trim();
                      subtitleText = line.substring(colonIndex + 1).trim();
                    }
                  }
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: const BorderSide(color: Color(0xFF008751), width: 2.0),
                    ),
                    elevation: 2.0,
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(titleText),
                        ),
                        subtitle: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text("Significado: $subtitleText"),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy, color: Color(0xFF008751)),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: "$titleText\n$subtitleText"));
                                showToast(context, 'Texto copiado para a área de transferência');
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.share, color: Color(0xFF008751)),
                              onPressed: () {
                                String cardContent = "$titleText\nSignificado: $subtitleText";
                                Share.share('Olha essa plavra que aprendi em YORUBÁ', subject: cardContent);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              showToast(
                  context, "Erro ao carregar os dados da letra selecionada");
              return const Text("Erro ao carregar os dados da letra selecionada");
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
  }

  Future<List<List<dynamic>>> readCSV() async {
    final String fileData = await rootBundle.loadString('assets/a.csv');
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(fileData);
    return csvTable;
  }

  void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            fontFamily: 'Roboto',
          ),
        ),
        backgroundColor: const Color(0xFF008751)
            .withOpacity(0.8), // Define a cor de fundo com 50% de transparência
      ),
    );
  }
}
