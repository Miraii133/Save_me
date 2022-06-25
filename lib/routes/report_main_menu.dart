import 'package:flutter/material.dart';

class ReportMainMenu extends StatelessWidget {
  const ReportMainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text("Report"),
        elevation: 10,
      ),
    );
  }
}
