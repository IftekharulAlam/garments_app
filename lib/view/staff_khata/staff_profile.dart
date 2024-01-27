// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:garments_app/controller/garmentsApp.dart';
import 'package:garments_app/model/staff.dart';
import 'package:http/http.dart' as http;

class StaffProfile extends StatefulWidget {
  String staffName;
  StaffProfile({super.key, required this.staffName});

  @override
  State<StaffProfile> createState() => _StaffProfileState();
}

class _StaffProfileState extends State<StaffProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future getProfileDetailsStaff(String staffName) async {
    String finalUrl = "http://$mydeviceIP:8000/getProfileDetailsStaff";
    var url = Uri.parse(finalUrl);
    http.Response response = await http.post(url, body: {
      "staffName": staffName,
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error loading data");
    }
  }

  Future<List<StaffData>> getKhatiyanDetailsStaff(String staffName) async {
    String finalUrl = "http://$mydeviceIP:8000/getKhatiyanDetailsStaff";
    var url = Uri.parse(finalUrl);
    http.Response response = await http.post(url, body: {
      "staffName": staffName,
    });

    if (response.statusCode == 200) {
      List result = jsonDecode(response.body);
      List<StaffData> mydata =
          result.map((e) => StaffData.fromJson(e)).toList();

      return mydata;
    } else {
      throw Exception("Error loading data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text("Staff Profile")),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 70,
            child: FutureBuilder(
              future: getProfileDetailsStaff(widget.staffName),
              builder: (BuildContext context, AsyncSnapshot sn) {
                if (sn.hasData) {
                  List unis = sn.data;
                  return ListView.builder(
                    itemCount: unis.length,
                    itemBuilder: (context, index) => Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.man_2_outlined,
                                color: Colors.cyan, size: 40),
                            title: Text(
                              "Name : ${unis[index]["Name"]}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            subtitle: Row(
                              children: [
                                Text('Designation :${unis[index]["Type"]}'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text('Salary : ${unis[index]["Salary"]}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: FutureBuilder<List<StaffData>>(
                future: getKhatiyanDetailsStaff(widget.staffName),
                builder:
                    (BuildContext context, AsyncSnapshot<List<StaffData>> sn) {
                
                  if (sn.hasData) {
                    return Container(
                      padding: const EdgeInsets.all(5),
                      child: DataClass(datalist: sn.data as List<StaffData>),
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
    );
  }
}

class DataClass extends StatelessWidget {
  final List<StaffData> datalist;
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
