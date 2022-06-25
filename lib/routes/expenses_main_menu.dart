import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ExpensesMainMenu extends StatelessWidget {
  const ExpensesMainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text("Expenses"),
        elevation: 10,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DataTable(
                    columns: <DataColumn>[
                      DataColumn(
                        label: Text("", style: TextStyle(fontSize: 25)),
                      ),
                      DataColumn(
                        label: Text("", style: TextStyle(fontSize: 15)),
                      ),
                    ],
                    rows: <DataRow>[
                      DataRow(cells: <DataCell>[
                        DataCell(Text("5,000", style: TextStyle(fontSize: 20))),
                        DataCell(
                            Text("06/17/2022", style: TextStyle(fontSize: 15))),
                      ]),
                    ],
                  ),
                ])),
      ),
    );
  }
}
