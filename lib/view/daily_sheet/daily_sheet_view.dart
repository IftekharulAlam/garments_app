// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';

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
      return jsonDecode(response.body);
    } else {
      throw Exception("Error loading data");
    }
  }

  Future getKhorochDataList(String date) async {
    String finalUrl = "http://$mydeviceIP:8000/getKhorochDataList";
    var url = Uri.parse(finalUrl);
    http.Response response = await http.post(url, body: {
      "date": date,
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
      appBar: AppBar(
        title: const Text("Daily Sheet"),
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
              child: FutureBuilder(
                future: getJomaDataList(widget.date),
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
                              Text("${unis[index]["item"]}"),
                              Text("${unis[index]["amount"]}"),
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
              child: FutureBuilder(
                future: getKhorochDataList(widget.date),
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
                              Text("${unis[index]["item"]}"),
                              Text("${unis[index]["amount"]}"),
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
          ],
        ),
      ),
    );
  }
}
