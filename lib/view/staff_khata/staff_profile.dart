import 'package:flutter/material.dart';

class StaffProfile extends StatefulWidget {
  const StaffProfile({super.key});

  @override
  State<StaffProfile> createState() => _StaffProfileState();
}

class _StaffProfileState extends State<StaffProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> itemStrings = [
    'Name : Sahidul Islam',
    'NID : 123456789',
    'Phone',
    'Address',
    'Fathers Name',
    'Mothers Name',
  ];
  List<Widget> itemWidgets = [];

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
              'Staff Profile',
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
                    "Name : Kajol Khan",
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Row(
                    children: [
                      Text('Designation : Senior'),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Salary : 20000'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          for (int x = 1; x < itemStrings.length; x++)
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
