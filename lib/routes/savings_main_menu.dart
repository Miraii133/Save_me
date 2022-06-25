import 'package:flutter/material.dart';

import 'main_menu.dart';

class SavingsMainMenu extends StatefulWidget {
  const SavingsMainMenu({Key? key}) : super(key: key);

  @override
  State<SavingsMainMenu> createState() => _SavingsMainMenuState();
}

class _SavingsMainMenuState extends State<SavingsMainMenu> {
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
                              style: TextStyle(
                                  fontSize: 35, color: Colors.yellow)),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DataTable(
                                  columnSpacing: 100,
                                  columns: <DataColumn>[
                                    DataColumn(
                                      label: Text("Amount",
                                          style: TextStyle(fontSize: 25)),
                                    ),
                                    DataColumn(
                                      label: Text("Date",
                                          style: TextStyle(fontSize: 25)),
                                    ),
                                  ],
                                  rows: const <DataRow>[
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text("5,005120",
                                          style: TextStyle(fontSize: 20))),
                                      DataCell(Text("06/17/2022",
                                          style: TextStyle(fontSize: 20))),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text("5,000",
                                          style: TextStyle(fontSize: 20))),
                                      DataCell(Text("06/17/2022",
                                          style: TextStyle(fontSize: 20))),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text("5,000",
                                          style: TextStyle(fontSize: 20))),
                                      DataCell(Text("06/17/2022",
                                          style: TextStyle(fontSize: 20))),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text("5,000",
                                          style: TextStyle(fontSize: 20))),
                                      DataCell(Text("06/17/2022",
                                          style: TextStyle(fontSize: 20))),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text("5,000",
                                          style: TextStyle(fontSize: 20))),
                                      DataCell(Text("06/17/2022",
                                          style: TextStyle(fontSize: 20))),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text("5,000",
                                          style: TextStyle(fontSize: 20))),
                                      DataCell(Text("06/17/2022",
                                          style: TextStyle(fontSize: 20))),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text("5,000",
                                          style: TextStyle(fontSize: 20))),
                                      DataCell(Text("06/17/2022",
                                          style: TextStyle(fontSize: 20))),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text("5,000",
                                          style: TextStyle(fontSize: 20))),
                                      DataCell(Text("06/17/2022",
                                          style: TextStyle(fontSize: 20))),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text("5,000",
                                          style: TextStyle(fontSize: 20))),
                                      DataCell(Text("06/17/2022",
                                          style: TextStyle(fontSize: 20))),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text("5,000",
                                          style: TextStyle(fontSize: 20))),
                                      DataCell(Text("06/17/2022",
                                          style: TextStyle(fontSize: 20))),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text("5,000",
                                          style: TextStyle(fontSize: 20))),
                                      DataCell(Text("06/17/2022",
                                          style: TextStyle(fontSize: 20))),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text("5,000",
                                          style: TextStyle(fontSize: 20))),
                                      DataCell(Text("06/17/2022",
                                          style: TextStyle(fontSize: 20))),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text("5,000",
                                          style: TextStyle(fontSize: 20))),
                                      DataCell(Text("06/17/2022",
                                          style: TextStyle(fontSize: 20))),
                                    ]),
                                  ],
                                ),
                              ]),
                        )),
                  ),
                ])));
  }
}
