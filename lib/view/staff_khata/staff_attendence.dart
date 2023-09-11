import 'package:flutter/material.dart';

class StaffAttendencePage extends StatefulWidget {
  const StaffAttendencePage({super.key});

  @override
  State<StaffAttendencePage> createState() => _StaffAttendencePageState();
}

class _StaffAttendencePageState extends State<StaffAttendencePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> itemStrings = [
    'Shahidul Islam',
    'Kajol Khan',
    'Selim ',
    'Rubel',
    'Sabbir',
    'Harun',
    'Mehedi'
  ];
  List<Widget> itemsWidgets = [];

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
              'Staff Attendence',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            ),
          ),
          for (int x = 1; x < itemStrings.length; x++)
            GestureDetector(
              onTap: () {
                //items_widgets[x];
              },
              child: Card(
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(itemStrings[x]),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
