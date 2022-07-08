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
    {'amount': 500, 'date': "07/16/2022"},
    {'amount': 50, 'date': "07/15/2011"},
    {'amount': 60, 'date': "07/13/2011"},
    {'amount': 70, 'date': "07/12/2011"},
    {'amount': 50, 'date': "02/15/2013"}
  ];

  String dataValues =
      "500, 07/16/5022, 50, 07/15/2011, 60, 07/13/2011, 70, 07/12/2011, 50, 02/15/2013";

  @override
  Widget build(BuildContext context) {
    write(dataValues);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        actions: [
          /*TextButton(
              onPressed: () {},
              child: const Text("Edit",
                  style: TextStyle(fontSize: 20, color: Colors.white)))*/
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
                          FutureBuilder(
                            // waits for _createDataTable future
                            future: Future.wait([_createDataTable()]),
                            builder: (context,
                                // AsyncSnapshot just enables indexes
                                // for
                                AsyncSnapshot<List<dynamic>> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return snapshot.data![0];
                              } else {
                                // A Widget to show while the value loads
                                return CircularProgressIndicator();
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

  write(String dataValues) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/my_file.txt');
    await file.writeAsString(dataValues);
  }

  Future<List> read() async {
    List dataFromString = [];
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/my_file.txt');
      String dataValues = await file.readAsString();
      print("data values");
      print(dataValues);
      final regexp = RegExp('^([^,])+');
      RegExpMatch? match;
      var matchedValue;
      int dataAmount = dataValues.split(", ").length;
      for (int i = 0; i < dataAmount; i++) {
        match = regexp.firstMatch(dataValues);
        matchedValue = match?.group(0);
        dataFromString.add(matchedValue);
        // clears matched_value and deletes it in dataValues
        // for next string to be pushed to index 0
        dataValues = dataValues.replaceFirst(matchedValue ?? "", "");
        // removes , after removing the matched_value
        dataValues = dataValues.replaceFirst(", ", "");
      }
      print("to string");
      print(dataFromString.toString());
    } catch (e) {
      print("Couldn't read file");
    }

    // returns a future value of listOfData asynchronously
    // once entire method is finished
    return dataFromString;
  }

  Future<Widget> _createDataTable() async {
    return DataTable(
        columnSpacing: 100,
        columns: _createColumns(),
        rows: await _createRows());

    // await _createRows())
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Amount', style: TextStyle(fontSize: 25))),
      DataColumn(label: Text('Date', style: TextStyle(fontSize: 25))),
    ];
  }

  Future<List<DataRow>> _createRows() async {
    List list = await read();
    List<DataRow> dataRow = [];
    int j = 0;
    print(list.length);
    for (int i = 0; i < list.length; i++) {
      print(i);

      DataRow(cells: [
        DataCell(
            TextFormField(
              style: TextStyle(fontSize: 20),
              initialValue: list[i],
              keyboardType: TextInputType.number,
              onFieldSubmitted: (val) {
                setState(() {
                  print(val);
                  print(i);
                  //you can do anything you want
                });
              },
            ),
            showEditIcon: false),
      ]);
      DataRow(
        cells: [
          DataCell(
              TextFormField(
                style: TextStyle(fontSize: 20),
                initialValue: list[i],
                keyboardType: TextInputType.datetime,
                onFieldSubmitted: (newValue) {
                  setState(() {
                    int cellIndex = i;
                    _changeTableData(list, newValue, cellIndex);
                    //you can do anything you want
                  });
                },
              ),
              showEditIcon: false),
        ],
      );
    }
    return dataRow;
  }

  void _changeTableData(List list, String newValue, int cellIndex) {
    list.insert(cellIndex, newValue);
    list.removeAt(cellIndex + 1);
    write(dataValues);
  }
}
