// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garments_app/controller/garmentsApp.dart';
import 'package:garments_app/model/party.dart';

import 'package:http/http.dart' as http;

class PartyKhataDetails extends StatefulWidget {
  String shopName;
  PartyKhataDetails({super.key, required this.shopName});

  @override
  State<PartyKhataDetails> createState() => _PartyKhataDetailsState();
}

class _PartyKhataDetailsState extends State<PartyKhataDetails> {
  Future<List<PartyKhatiyan>> getPartyKhatiyanDetails(String shopName) async {
    String finalUrl = "http://$mydeviceIP:8000/getPartyKhatiyanDetails";
    var url = Uri.parse(finalUrl);
    http.Response response = await http.post(url, body: {
      "shopName": shopName,
    });

    if (response.statusCode == 200) {
      List result = jsonDecode(response.body);
      List<PartyKhatiyan> mydata =
          result.map((e) => PartyKhatiyan.fromJson(e)).toList();

      return mydata;
    } else {
      throw Exception("Error loading data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Party Details"),
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
                    widget.shopName,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: FutureBuilder<List<PartyKhatiyan>>(
                  future: getPartyKhatiyanDetails(widget.shopName),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PartyKhatiyan>> sn) {
                      
                    if (sn.hasData) {
                      return Container(
                          padding: const EdgeInsets.all(5),
                          child: DataClass(
                              datalist: sn.data as List<PartyKhatiyan>));
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
  final List<PartyKhatiyan> datalist;
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
                          '${data.details}',
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
