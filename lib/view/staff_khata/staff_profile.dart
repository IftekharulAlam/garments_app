// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garments_app/controller/controller.dart';
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

  Future getKhatiyanDetailsStaff(String staffName) async {
    String finalUrl = "http://$mydeviceIP:8000/getKhatiyanDetailsStaff";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text("BM Garments")),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Staff Profile',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            ),
          ),
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
          Container(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: const Card(
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Date"),
                    Text("Joma"),
                    Text("Khoroch"),
                    Text("Balance"),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: FutureBuilder(
                future: getKhatiyanDetailsStaff(widget.staffName),
                builder: (BuildContext context, AsyncSnapshot sn) {
                  if (sn.hasData) {
                    List unis = sn.data;
                    return ListView.builder(
                      itemCount: unis.length,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${unis[index]["Date"]}"),
                              Text("${unis[index]["Joma"]}"),
                              Text("${unis[index]["Khoroch"]}"),
                            ],
                          ),
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
          ),
        ],
      ),
    );
  }
}
