// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garments_app/view/home_page.dart';

import 'package:http/http.dart' as http;

class DailySheetAddPage extends StatefulWidget {
  const DailySheetAddPage({super.key});

  @override
  State<DailySheetAddPage> createState() => _DailySheetAddPageState();
}

class _DailySheetAddPageState extends State<DailySheetAddPage> {
  String dropdownvalue = 'Owner';
  var items = ['Owner', 'Manager', 'Staff', 'Designer'];
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('Item')),
      const DataColumn(label: Text('Amount')),
      const DataColumn(label: Text('Update')),
      const DataColumn(label: Text('Delete')),
    ];
  }

  List<DataRow> _createRows() {
    return [
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('200')),
        DataCell(
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
        ),
        DataCell(
          IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
        ),
      ]),
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('200')),
        DataCell(
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
        ),
        DataCell(
          IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
        ),
      ]),
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('200')),
        DataCell(
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
        ),
        DataCell(
          IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
        ),
      ]),
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('200')),
        DataCell(
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
        ),
        DataCell(
          IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
        ),
      ]),
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('200')),
        DataCell(
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
        ),
        DataCell(
          IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
        ),
      ]),
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('200')),
        DataCell(
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
        ),
        DataCell(
          IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
        ),
      ]),
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('200')),
        DataCell(
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
        ),
        DataCell(
          IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
        ),
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
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextField(
                      controller: name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'New Entry',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextField(
                      controller: name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Amount',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Add'),
                      onPressed: () {
                        // login(name.text, password.text, dropdownvalue);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Staff List:',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: DropdownButton(
                      underline: Container(),
                      style: const TextStyle(
                          //te
                          color: Colors.black, //Font color
                          fontSize: 18 //font size on dropdown button
                          ),
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                            value: items, child: Text(items));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextField(
                      controller: name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Amount',
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Add'),
                    onPressed: () {
                      // login(name.text, password.text, dropdownvalue);
                    },
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Khatiyan List:',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: DropdownButton(
                      underline: Container(),
                      style: const TextStyle(
                          //te
                          color: Colors.black, //Font color
                          fontSize: 18 //font size on dropdown button
                          ),
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                            value: items, child: Text(items));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextField(
                      controller: name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Amount',
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Add'),
                    onPressed: () {
                      // login(name.text, password.text, dropdownvalue);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 300,
              child: SingleChildScrollView(
                child:
                    DataTable(columns: _createColumns(), rows: _createRows()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
