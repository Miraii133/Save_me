import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'main_menu.dart';

class SavingsMainMenu extends StatefulWidget {
  const SavingsMainMenu({Key? key}) : super(key: key);

  @override
  State<SavingsMainMenu> createState() => _SavingsMainMenuState();
}

class _SavingsMainMenuState extends State<SavingsMainMenu> {
  List<Map> _books = [
    {'amount': 5000, 'date': "07/16/2022"},
    {'amount': 500, 'date': "07/16/2022"},
    {'amount': 500, 'date': "07/16/2022"},
  ];

  @override
  Widget build(BuildContext context) {
    write(_books);
    read();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text("Edit",
                  style: TextStyle(fontSize: 20, color: Colors.white)))
        ],
        title: const Text("Savings",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            )),
        elevation: 10,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.blue[900],
              child: SizedBox(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Savings",
                        style: TextStyle(fontSize: 35, color: Colors.yellow)),
                    Text("$budget",
                        style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow)),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "History",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _createDataTable(),
                        ]),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  write(List text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/my_file.txt');
    await file.writeAsString(text.toString());
  }

  Future<String> read() async {
    String text = "";
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/my_file.txt');
      text = await file.readAsString();
      var stopFlagChars = [',', '{', '}'];
      bool isStartOfWord = false;
      var words = <String>[];
      for (var char in text.runes) {
        for (var i = 0; i < stopFlagChars.length; i++) {
          var charToString = String.fromCharCode(char);
          /*if (stopFlagChars[i] != charToString) {
            print(charToString);
          }*/
          if (charToString == ':') {
            isStartOfWord = true;
          }
        }
      }
    } catch (e) {
      print("Couldn't read file");
    }
    return text;
  }

  DataTable _createDataTable() {
    return DataTable(
        columnSpacing: 100, columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Amount', style: TextStyle(fontSize: 25))),
      DataColumn(label: Text('Date', style: TextStyle(fontSize: 25))),
    ];
  }

  List<DataRow> _createRows() {
    return _books
        .map((book) => DataRow(cells: [
              DataCell(Text(
                book['amount'].toString(),
                style: TextStyle(fontSize: 20),
              )),
              DataCell(Text(
                book['date'].toString(),
                style: TextStyle(fontSize: 20),
              )),
            ]))
        .toList();
  }
}
