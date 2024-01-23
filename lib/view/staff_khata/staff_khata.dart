import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garments_app/controller/controller.dart';
import 'package:garments_app/view/staff_khata/staff_attendence.dart';
import 'package:garments_app/view/staff_khata/staff_profile.dart';

import 'package:http/http.dart' as http;

class StaffKhataPage extends StatefulWidget {
  const StaffKhataPage({super.key});

  @override
  State<StaffKhataPage> createState() => _StaffKhataPageState();
}

class _StaffKhataPageState extends State<StaffKhataPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future getStaffList() async {
    http.Response response = await http.get(
      Uri.parse("http://$mydeviceIP:8000/getStaffList"),
    );

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
      appBar: AppBar(title: const Text("Staff Khata")),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder(
                future: getStaffList(),
                builder: (BuildContext context, AsyncSnapshot sn) {
                  if (sn.hasData) {
                    List unis = sn.data;
                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      itemCount: unis.length,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          title: Text("${unis[index]["Name"]}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  child: const Text('Attendence'),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const StaffAttendencePage()));
                                  },
                                ),
                              ),
                              ElevatedButton(
                                child: const Text('Profile'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StaffProfile(
                                              staffName:
                                                  "${unis[index]["Name"]}")));
                                },
                              ),
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
