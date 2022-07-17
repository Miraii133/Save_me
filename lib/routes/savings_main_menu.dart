import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class SavingsMainMenu extends StatefulWidget {
  const SavingsMainMenu({Key? key}) : super(key: key);

  @override
  State<SavingsMainMenu> createState() => _SavingsMainMenuState();
}

@override
void initState() {
  _SavingsMainMenuState savings = _SavingsMainMenuState();
  initState();
}

class _SavingsMainMenuState extends State<SavingsMainMenu> {
  @override
  String dataValues = "600, 07/10/2022, 145, 07/15/2022";
  Widget build(BuildContext context) {
    //write(dataValues);
    //_removeData();
    //_addData();
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
                    FutureBuilder<int>(
                      // waits for _createDataTable future
                      future: _getTotalSavings(),
                      builder: (context,
                          // AsyncSnapshot just enables indexes
                          // for multiple widgets
                          snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          String newSnapshotData = "";
                          // removes [ and ] when snapshot.data
                          // is received from _getTotalSavings()
                          // snapshot.data will automatically have
                          // [ and ], condition removes it.
                          if (snapshot.data.toString().contains("[") ||
                              snapshot.data.toString().contains("]")) {
                            newSnapshotData =
                                snapshot.data.toString().replaceAll("[", "");
                            newSnapshotData =
                                newSnapshotData.replaceAll("]", "");
                          }
                          return Text(
                            newSnapshotData,
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow),
                          );
                        } else {
                          // A Widget to show while the value loads
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _addData();
                        },
                        child: Text("Add")),
                    ElevatedButton(
                        onPressed: () {
                          _removeData();
                        },
                        child: Text("Remove")),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                "History",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
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
      // remove auto generated [ and ] from turning
      // strings to maps
      dataValues = dataValues.replaceAll("[", "");
      dataValues = dataValues.replaceAll("]", "");
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
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('Amount', style: TextStyle(fontSize: 25))),
      const DataColumn(label: Text('Date', style: TextStyle(fontSize: 25))),
    ];
  }

  Future<List<DataRow>> _createRows() async {
    List list = await read();
    List<DataRow> dataRow = [];
    for (int i = 0; i < list.length; i++) {
      dataRow.add(
        DataRow(
          cells: [
            DataCell(
                TextFormField(
                  style: const TextStyle(fontSize: 20),
                  // increments by 1 to ensure that
                  // the same value in amount row
                  // and date row does not duplicate
                  initialValue: list[i++],
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (newValue) {
                    // decrements i again
                    // to make sure that cellIndex
                    // is correct.
                    i--;
                    int cellIndex = i;

                    _changeTableData(list, newValue, cellIndex);
                  },
                ),
                showEditIcon: false),
            DataCell(
                TextFormField(
                  style: TextStyle(fontSize: 20),
                  initialValue: list[i++],
                  keyboardType: TextInputType.datetime,
                  onFieldSubmitted: (newValue) {
                    setState(() {
                      int cellIndex = i;
                      _changeTableData(list, newValue, cellIndex);
                    });
                  },
                ),
                showEditIcon: false),
          ],
          //,
          onSelectChanged: (bool? selected) {},
        ),
      );
      // decrements to return index value after incrementing
      // actually have no idea why the increments
      // are working, but it works
      i--;
    }
    return dataRow;
  }

  void _changeTableData(List list, String newValue, int cellIndex) {
    list.insert(cellIndex, newValue);
    // removes the next element of list
    // after adding the new value in list;
    setState(() {
      list.removeAt(cellIndex + 1);
    });
    // converts list to a string
    // write() needs a string
    // for writeAsString()
    write(list.toString());
    _getTotalSavings();
  }

  Future<int> _getTotalEntries() async {
    List list = await read();
    int totalEntries = list.length;
    return totalEntries;
  }

  Future<int> _getTotalSavings() async {
    List list = await read();
    int totalSavings = 0;
    for (int i = 0; i < list.length; i++) {
      totalSavings = (totalSavings + int.parse(list[i++]));
    }
    return totalSavings;
  }

  void _removeData() async {
    List list = await read();
    // removes both the value
    // in amount and date
    setState(() {
      list.removeAt(0);
      list.removeAt(0);
      write(list.toString());
    });
  }

  void _addData() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('MM/dd/yyyy');
    String formattedDate = formatter.format(now);
    List list = await read();
    setState(() {
      list.insert(0, "");
      list.insert(1, formattedDate);
      write(list.toString());
    });
  }
}
