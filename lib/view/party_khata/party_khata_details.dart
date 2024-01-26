// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garments_app/controller/garmentsApp.dart';


import 'package:http/http.dart' as http;

class PartyKhataDetails extends StatefulWidget {
  String shopName;
  PartyKhataDetails({super.key, required this.shopName});

  @override
  State<PartyKhataDetails> createState() => _PartyKhataDetailsState();
}

class _PartyKhataDetailsState extends State<PartyKhataDetails> {
  Future getPartyKhatiyanDetails(String shopName) async {
    String finalUrl = "http://$mydeviceIP:8000/getPartyKhatiyanDetails";
    var url = Uri.parse(finalUrl);
    http.Response response = await http.post(url, body: {
      "shopName": shopName,
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
            Container(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: const Card(
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date"),
                      Text("BillNo"),
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
                  future: getPartyKhatiyanDetails(widget.shopName),
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
                                Text("${unis[index]["billNo"]}"),
                                Text("${unis[index]["Joma"]}"),
                                Text("${unis[index]["Khoroch"]}"),
                                Text("${unis[index]["Balance"]}"),
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
      ),
    );
  }
}
