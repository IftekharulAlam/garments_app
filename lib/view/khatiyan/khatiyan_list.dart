import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garments_app/view/khatiyan/khatiyan_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

class KhatiyanListPage extends StatefulWidget {
  const KhatiyanListPage({super.key});

  @override
  State<KhatiyanListPage> createState() => _KhatiyanListPageState();
}

class _KhatiyanListPageState extends State<KhatiyanListPage> {
  Future createKhatiyan(String khatiyanName) async {
    String finalUrl = "http://192.168.0.100:8000/createKhatiyan";
    var url = Uri.parse(finalUrl);
    http.Response response = await http.post(url, body: {
      "khatiyanName": khatiyanName,
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

  Future getKhatiyanList() async {
    http.Response response = await http.get(
      Uri.parse("http://192.168.0.100:8000/getKhatiyanList"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error loading data");
    }
  }

  TextEditingController khatiyanName = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text("BM Garments")),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            child: const Text(
              'Khatiyan',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: const Text('Create Khatiyan'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("New Khatiyan"),
                      content: Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: khatiyanName,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Khatiyan Name',
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              child: const Text("Create"),
                              onPressed: () {
                                if (khatiyanName.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Name Cannot be Blank",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  createKhatiyan(khatiyanName.text);
                                  khatiyanName.text = "";
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: ElevatedButton(
                                child: const Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder(
                future: getKhatiyanList(),
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
                                  builder: (context) => KhatiyanViewPage(
                                      khatiyanName:
                                          "${unis[index]["khatiyanName"]}")));
                        },
                        child: Card(
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${unis[index]["khatiyanName"]}"),
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
