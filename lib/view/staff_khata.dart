import 'package:flutter/material.dart';

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

  ];

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
