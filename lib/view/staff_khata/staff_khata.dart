import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garments_app/view/staff_khata/staff_profile.dart';

import 'package:http/http.dart' as http;

class StaffKhataPage extends StatefulWidget {
  const StaffKhataPage({super.key});

  @override
  State<StaffKhataPage> createState() => _StaffKhataPageState();
}

class _StaffKhataPageState extends State<StaffKhataPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future getStaffKhatiyanList() async {
    http.Response response = await http.get(
      Uri.parse("http://192.168.0.100:8000/getStaffKhatiyanList"),
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
      appBar: AppBar(title: const Text("BM Garments")),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Staff Khata',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder(
                future: getStaffKhatiyanList(),
                builder: (BuildContext context, AsyncSnapshot sn) {
                  if (sn.hasData) {
                    List unis = sn.data;
                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      itemCount: unis.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StaffProfile(
                                      staffName:
                                          "${unis[index]["staffName"]}")));
                        },
                        child: Card(
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${unis[index]["staffName"]}"),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit))
                              ],
                            ),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.delete)),
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
