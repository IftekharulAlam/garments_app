import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garments_app/view/staff_khata/staff_profile.dart';
import 'package:http/http.dart' as http;

class StaffDetailsPage extends StatefulWidget {
  const StaffDetailsPage({super.key});

  @override
  State<StaffDetailsPage> createState() => _StaffDetailsPageState();
}

class _StaffDetailsPageState extends State<StaffDetailsPage> {
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
      const DataColumn(label: Text('Date')),
      const DataColumn(label: Text('Item')),
      const DataColumn(label: Text('Amount')),
    ];
  }

  List<DataRow> _createRows() {
    return [
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('#100')),
        DataCell(Text('200')),
      ]),
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('#100')),
        DataCell(Text('200')),
      ]),
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('#100')),
        DataCell(Text('200')),
      ]),
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('#100')),
        DataCell(Text('200')),
      ]),
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('#100')),
        DataCell(Text('200')),
      ]),
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('#100')),
        DataCell(Text('200')),
      ]),
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('#100')),
        DataCell(Text('200')),
      ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Sheet Khoroch"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            const Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.man_2_outlined,
                        color: Colors.cyan, size: 40),
                    title: Text(
                      "Name : Kajol Khan",
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Row(
                      children: [
                        Text('Designation : Senior'),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Salary : 20000'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Profile'),
                onPressed: () {
                  // login(name.text, password.text, dropdownvalue);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StaffProfile(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              child: DataTable(columns: _createColumns(), rows: _createRows()),
            ),
          ],
        ),
      ),
    );
  }
}
