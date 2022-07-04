import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
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
    {'amount': 50, 'date': "07/15/2011"},
    {'amount': 60, 'date': "07/13/2011"},
    {'amount': 70, 'date': "07/12/2011"}
  ];

  @override
  Widget build(BuildContext context) {
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
                          FutureBuilder<DataTable>(
                            future: _createDataTable(),
                            builder: (context, snapshot) {
                              //_createDataTable();
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Text("${snapshot.data}");
                              } else {
                                // A Widget to show while the value loads
                                return Text('Loading');
                              }
                            },
                          )
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

  Future<List> read() async {
    String text = "";

    // listOfData contains all data after
    // textFile is read.
    var listOfData = [];
    var chunks = [];
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/my_file.txt');
      text = await file.readAsString();
      var startFlagChar = ':';
      var stopFlagChars = [',', '{', '}'];
      var excludedChars = [' ', ':'];
      bool isStartOfWord = false;
      bool isStopOfWord = false;
      var words = <String>[];
      for (var char in text.runes) {
        var charToString = String.fromCharCode(char);

        // if char detects flag of start
        if (startFlagChar == charToString) {
          isStartOfWord = true;
          isStopOfWord = false;
        } else {
          for (var i = 0; i < stopFlagChars.length; i++) {
            // stopFlag does not contain whatever the
            // char is and start word already true
            if (stopFlagChars.contains(charToString) && isStartOfWord) {
              isStartOfWord = false;
              isStopOfWord = true;
            }
          }
        }
        // only puts char if : is detected, and ends if stopFlag is detected
        // also excludes excluded characters.
        // !excludedChars.contains(charToString)
        if (isStartOfWord &&
            !isStopOfWord &&
            !excludedChars.contains(charToString)) {
          words.add(charToString);
        }

        // if char is already a stop word, join the
        // words list and add in listOfData.
        // clear words list to store another
        // set of words
        if (!isStartOfWord && isStopOfWord) {
          var joinedWords = [words.join()];
          listOfData.add(joinedWords);
          words.clear();
          isStopOfWord = false;
        }
      }
      var chunks = [];
      int chunkSize = 2;
      for (var i = 0; i < listOfData.length; i += chunkSize) {
        chunks.add(listOfData.sublist(
            i,
            i + chunkSize > listOfData.length
                ? listOfData.length
                : i + chunkSize));
      }
    } catch (e) {
      print("Couldn't read file");
    }

    // returns a future value of listOfData asynchronously
    // once entire method is finished
    return listOfData;
  }

  /*createTable() async {
    Future<List> _futureList = read();
    List list = await _futureList;
    print(list);
    for (int i = 0; i < list.length; i++) {
      for (int j = 0; j <= 1; j++) {
        dataRow = DataRow(cells: [
          DataCell(Text(
            list[i][j],
            style: TextStyle(fontSize: 20),
          )),
          DataCell(Text(
            list[i][j]['date'].toString(),
            style: TextStyle(fontSize: 20),
          )),
        ]);
  }*/

  Future<DataTable> _createDataTable() async {
    Future.delayed(const Duration(seconds: 5), () {
      print("hello");
      return DataTable(
          columnSpacing: 100,
          columns: _createColumns(),
          rows: _createRows()); // Prints after 1 second.
    });
    return DataTable(
        columnSpacing: 200, columns: _createColumns(), rows: _createRows());

    // await _createRows())
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Amount', style: TextStyle(fontSize: 25))),
      DataColumn(label: Text('Date', style: TextStyle(fontSize: 25))),
    ];
  }

  _createRows() {
    return [
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('Flutter Basics')),
      ]),
      DataRow(
        cells: [
          DataCell(Text('#101')),
          DataCell(Text('Dart Internals')),
        ],
      ),
    ];
    /*List list = await read();
    List<DataRow> dataRow = [];
    DataCell cell;
    DataCell cell1;
    DataRow data;
    print(list);
    for (int i = 0; i < list.length; i++) {
      for (int j = 0; j < 1; j++) {
        data = DataRow(
          cells: [
            cell = DataCell(const Text(
              "Hello",
              style: TextStyle(fontSize: 20),
            )),
            cell1 = DataCell(Text(
              list[i][j],
              style: TextStyle(fontSize: 20),
            )),
          ].toList(),
        );
      }
    }*/
  }
}
