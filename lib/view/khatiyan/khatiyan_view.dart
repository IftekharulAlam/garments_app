// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garments_app/controller/garmentsApp.dart';

import 'package:garments_app/model/khatiyan.dart';

import 'package:http/http.dart' as http;

class KhatiyanViewPage extends StatefulWidget {
  String khatiyanName;
  KhatiyanViewPage({super.key, required this.khatiyanName});

  @override
  State<KhatiyanViewPage> createState() => _KhatiyanViewPageState();
}

class _KhatiyanViewPageState extends State<KhatiyanViewPage> {
  Future<List<KhatiyanData>> getKhatiyanDetails(String khatiyanName) async {
    String finalUrl = "http://$mydeviceIP:8000/getKhatiyanDetails";
    var url = Uri.parse(finalUrl);
    http.Response response = await http.post(url, body: {
      "khatiyanName": khatiyanName,
    });

    if (response.statusCode == 200) {
      List result = jsonDecode(response.body);
      List<KhatiyanData> mydata =
          result.map((e) => KhatiyanData.fromJson(e)).toList();

      return mydata;
    } else {
      throw Exception("Error loading data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Khatiyan Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.khatiyanName,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: FutureBuilder<List<KhatiyanData>>(
                  future: getKhatiyanDetails(widget.khatiyanName),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<KhatiyanData>> sn) {
                    if (sn.hasData) {
                      return Container(
                        padding: const EdgeInsets.all(5),
                        child:
                            DataClass(datalist: sn.data as List<KhatiyanData>),
                      );
                    }
                    if (sn.hasError) {
                      return const Center(child: Text("Error Loading Data"));
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DataClass extends StatelessWidget {
  final List<KhatiyanData> datalist;
  const DataClass({super.key, required this.datalist});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: FittedBox(
        child: DataTable(
            sortColumnIndex: 1,
            showCheckboxColumn: false,
            border: TableBorder.all(width: 1.0),
            columns: const [
              DataColumn(
                label: Text(
                  "Date",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  "Details",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  "Joma",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  "Khoroch",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  "Balance",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              )
            ],
            rows: datalist
                .map((data) => DataRow(cells: [
                      DataCell(
                        Text(
                          data.date,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ),
                      DataCell(
                        Text(
                          data.details,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ),
                      DataCell(
                        Text(
                          '${data.joma}',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ),
                      DataCell(
                        Text(
                          '${data.khoroch}',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ),
                      DataCell(
                        Text(
                          '${data.balance}',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ]))
                .toList()),
      ),
    );
  }
}
