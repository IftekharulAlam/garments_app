import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garments_app/controller/garmentsApp.dart';
import 'package:garments_app/model/khatiyan.dart';
import 'package:garments_app/model/sql_service.dart';

import 'package:garments_app/view/khatiyan/khatiyan_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class KhatiyanListPage extends StatefulWidget {
  const KhatiyanListPage({super.key});

  @override
  State<KhatiyanListPage> createState() => _KhatiyanListPageState();
}

class _KhatiyanListPageState extends State<KhatiyanListPage> {
  late final SqlService mysqlService = SqlService();
  String? datetime;
  int joma = 0;
  int khoroch = 0;
  int balance = 0;
  String type = "Office";
  String details = "Nogod";
  @override
  void initState() {
    datetime = DateFormat("dd-MM-yyyy").format(DateTime.now());

    super.initState();
  }

  Future createKhatiyan(String khatiyanName, String datetime) async {
    String finalUrl = "http://$mydeviceIP:8000/createKhatiyan";
    var url = Uri.parse(finalUrl);
    http.Response response = await http.post(url, body: {
      "khatiyanName": khatiyanName,
      "date": datetime,
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
      Uri.parse("http://$mydeviceIP:8000/getKhatiyanList"),
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
      appBar: AppBar(title: const Text("Khatiyan")),
      body: Column(
        children: <Widget>[
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
                                setState(() {
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
                                    // createKhatiyan(
                                    //     khatiyanName.text, datetime!);

                                    mysqlService.insertKhatiyan(Khatiyan(
                                        khatiyanName: khatiyanName.text,
                                        date: datetime!,
                                        details: details,
                                        joma: joma,
                                        khoroch: khoroch,
                                        balance: balance,
                                        type: type));
                                    khatiyanName.text = "";
                                    Navigator.of(context).pop();
                                  }
                                });
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
              child: FutureBuilder<List<Khatiyan>>(
                future: mysqlService.getKhatiyanList(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Khatiyan>> sn) {
                  if (sn.hasData) {
                    List<Khatiyan> mykhatiyan = sn.data as List<Khatiyan>;
                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      itemCount: mykhatiyan.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KhatiyanViewPage(
                                  khatiyanName: mykhatiyan[index].khatiyanName),
                            ),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(mykhatiyan[index].khatiyanName),
                                ),
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
