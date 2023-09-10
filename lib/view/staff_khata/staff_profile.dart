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
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              icon: const Icon(Icons.account_circle_outlined)),
          automaticallyImplyLeading: false,
          title: const Center(child: Text("BM Garments"))),
      drawer: Drawer(
        child: ListView(
          children: const [
            Column(
              children: [
                // DrawerHeader(
                //    child: Image.memory(base64.decode(widget.UserIamge))),
                ListTile(
                  // title: Center(child: Text(widget.Username)),
                  title: Center(child: Text("Profile")),
                ),
                ListTile(
                  title:
                      // Center(child: Text(" Address : ${widget.UserAddress}")),
                      Center(child: Text("Daily Sheet")),
                ),
                ListTile(
                  title: Center(child: Text("Khatiayn")),
                  // title: Center(child: Text(" Phone : ${widget.UserPhone}")),
                ),
              ],
            ),
          ],
        ),
      ),
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
