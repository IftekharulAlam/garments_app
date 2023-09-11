import 'package:flutter/material.dart';
import 'package:garments_app/view/staff_khata/staff_details.dart';

class StaffKhataPage extends StatefulWidget {
  const StaffKhataPage({super.key});

  @override
  State<StaffKhataPage> createState() => _StaffKhataPageState();
}

class _StaffKhataPageState extends State<StaffKhataPage> {
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
  List<Widget> itemsWidgets = [
    StaffDetailsPage(),
    StaffDetailsPage(),
    StaffDetailsPage(),
    StaffDetailsPage(),
    StaffDetailsPage(),
    StaffDetailsPage(),
    StaffDetailsPage(),
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
              'Staff Khata',
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => itemsWidgets[x]));
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
