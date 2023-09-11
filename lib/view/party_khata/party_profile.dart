// import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;

class PartyProfilePage extends StatefulWidget {
  const PartyProfilePage({super.key});

  @override
  State<PartyProfilePage> createState() => _PartyProfilePageState();
}

class _PartyProfilePageState extends State<PartyProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> itemStrings = [
    'Owner Name : Sahidul Islam',
    'Phone',
    'Address',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text("BM Garments")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Party Profile',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            ),
          ),
          const Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading:
                      Icon(Icons.man_2_outlined, color: Colors.cyan, size: 40),
                  title: Text(
                    "Supti Enterprice",
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Row(
                    children: [
                      Text('Owner : '),
                    ],
                  ),
                ),
              ],
            ),
          ),
          for (int x = 0; x < itemStrings.length; x++)
            Card(
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(itemStrings[x]),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
