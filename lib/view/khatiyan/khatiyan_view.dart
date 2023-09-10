import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class KhatiyanViewPage extends StatefulWidget {
  const KhatiyanViewPage({super.key});

  @override
  State<KhatiyanViewPage> createState() => _KhatiyanViewPageState();
}

class _KhatiyanViewPageState extends State<KhatiyanViewPage> {
  Future login(String name, String password, String userType) async {
    String finalUrl = "http://192.168.0.100:8000/login";
    var url = Uri.parse(finalUrl);
    var response = await http.post(url,
        body: {"name": name, "password": password, "userType": userType});

    var data = json.decode(response.body);

    if (data[0]["message"] == "Wrong") {
      Fluttertoast.showToast(
          msg: "Login Unsuccessful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Login successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const HomePage(),
      //   ),
      // );
    }
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('Item')),
      const DataColumn(label: Text('Amount')),
    ];
  }

  List<DataColumn> _createColumns2() {
    return [
      const DataColumn(label: Text('Total')),
      const DataColumn(label: Text('100')),
    ];
  }

  List<DataRow> _createRows() {
    return [
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('200')),
      ]),
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('200')),
      ]),
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('200')),
      ]),
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('200')),
      ]),
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('200')),
      ]),
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('200')),
      ]),
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('200')),
      ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Khatiyan Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Date :',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Joma :',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 450,
              child: SingleChildScrollView(
                  child: DataTable(
                      columns: _createColumns(), rows: _createRows())),
            ),
            DataTable(
                columnSpacing: 33.0, columns: _createColumns2(), rows: const [])
          ],
        ),
      ),
    );
  }
}
