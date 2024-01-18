// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garments_app/controller/controller.dart';
import 'package:http/http.dart' as http;

class DailySheetViewPage extends StatefulWidget {
  String date;
  DailySheetViewPage({super.key, required this.date});

  @override
  State<DailySheetViewPage> createState() => _DailySheetViewPageState();
}

class _DailySheetViewPageState extends State<DailySheetViewPage> {
  Future getJomaDataList(String date) async {
    String finalUrl = "http://$mydeviceIP:8000/getJomaDataList";
    var url = Uri.parse(finalUrl);
    http.Response response = await http.post(url, body: {
      "date": date,
    });

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Update Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return jsonDecode(response.body);
    } else {
      throw Exception("Error loading data");
    }
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('Item')),
      const DataColumn(label: Text('Amount')),
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
        title: const Text("Daily Sheet Khoroch"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Center(
                child: Text(
              'Date :${widget.date}',
              style: const TextStyle(fontSize: 20),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
              child: DataTable(columns: _createColumns(), rows: _createRows()),
            ),
          ],
        ),
      ),
    );
  }
}
