import 'package:flutter/material.dart';
import 'package:save_me/routes/report_main_menu.dart';
import 'package:save_me/routes/savings_main_menu.dart';
import 'expenses_main_menu.dart';

var budget = "2,020";

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text("App"),
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
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            minimumSize: const Size(111, 78),
                            primary: Colors.blue[900]),
                        onPressed: () {
                          SavingsMainMenu svm = SavingsMainMenu();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SavingsMainMenu()));
                        },
                        child: Column(
                          children: const [
                            Icon(Icons.attach_money, color: Colors.yellow),
                            Text("Savings",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.yellow)),
                          ],
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            minimumSize: const Size(111, 78),
                            primary: Colors.blue[900]),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ExpensesMainMenu()));
                        },
                        child: Column(
                          children: const [
                            Icon(
                              Icons.add_shopping_cart,
                              color: Colors.yellow,
                            ),
                            Text("Expenses",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.yellow)),
                          ],
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            minimumSize: const Size(111, 78),
                            primary: Colors.blue[900]),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ReportMainMenu()));
                        },
                        child: Column(
                          children: const [
                            Icon(
                              Icons.analytics,
                              color: Colors.yellow,
                            ),
                            Text("Report",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.yellow)),
                          ],
                        )),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
