// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garments_app/controller/garmentsApp.dart';
import 'package:garments_app/model/dailySheet.dart';

import 'package:http/http.dart' as http;

class DailySheetViewPage extends StatefulWidget {
  String date;
  DailySheetViewPage({super.key, required this.date});

  @override
  State<DailySheetViewPage> createState() => _DailySheetViewPageState();
}

class _DailySheetViewPageState extends State<DailySheetViewPage> {
  Future approveDeclineDailySheet(String date, String status) async {
    String finalUrl = "http://$mydeviceIP:8000/approveDeclineDailySheet";
    var url = Uri.parse(finalUrl);
    http.Response response = await http.post(url, body: {
      "date": date,
      "status": status,
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error loading data");
    }
  }

  Future<List<DailySheetJomaKhorochData>> getJomaDataList(String date) async {
    String finalUrl = "http://$mydeviceIP:8000/getJomaDataList";
    var url = Uri.parse(finalUrl);
    http.Response response = await http.post(url, body: {
      "date": date,
    });

    if (response.statusCode == 200) {
      List result = jsonDecode(response.body);
      List<DailySheetJomaKhorochData> mydata =
          result.map((e) => DailySheetJomaKhorochData.fromJson(e)).toList();

      return mydata;
    } else {
      throw Exception("Error loading data");
    }
  }

  Future<List<DailySheetJomaKhorochData>> getKhorochDataList(String date) async {
    String finalUrl = "http://$mydeviceIP:8000/getKhorochDataList";
    var url = Uri.parse(finalUrl);
    http.Response response = await http.post(url, body: {
      "date": date,
    });

    if (response.statusCode == 200) {
      List result = jsonDecode(response.body);
      List<DailySheetJomaKhorochData> mydata =
          result.map((e) => DailySheetJomaKhorochData.fromJson(e)).toList();

      return mydata;
    } else {
      throw Exception("Error loading data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Date :${widget.date}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(2),
                  child: const Text(
                    'Joma :',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 300,
              child: Container(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: FutureBuilder<List<DailySheetJomaKhorochData>>(
                  future: getJomaDataList(widget.date),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<DailySheetJomaKhorochData>> sn) {
                        print(sn.error);
                    if (sn.hasData) {
                      return Container(
                        padding: const EdgeInsets.all(5),
                        child: DataClass(
                            datalist:
                                sn.data as List<DailySheetJomaKhorochData>),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(2),
                  child: const Text(
                    'Khoroch :',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 300,
              child: Container(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: FutureBuilder<List<DailySheetJomaKhorochData>>(
                  future: getKhorochDataList(widget.date),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<DailySheetJomaKhorochData>> sn) {
                        print(sn.data);
                    if (sn.hasData) {
                      return Container(
                        padding: const EdgeInsets.all(5),
                        child: DataClass(
                            datalist:
                                sn.data as List<DailySheetJomaKhorochData>),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Approve'),
                    onPressed: () {
                      approveDeclineDailySheet(widget.date, "Approve");
                    },
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Decline'),
                    onPressed: () {
                      approveDeclineDailySheet(widget.date, "Decline");
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DataClass extends StatelessWidget {
  final List<DailySheetJomaKhorochData> datalist;
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
                  "Item",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  "Amount",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
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
                          '${data.amount}',
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
