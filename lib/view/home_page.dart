// ignore_for_file: prefer_const_constructors, must_be_immutable, use_build_context_synchronously

// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garments_app/view/bill.dart';
import 'package:garments_app/view/chalan.dart';
import 'package:garments_app/view/daily_sheet/daily_sheet.dart';
import 'package:garments_app/view/party_khata.dart';
import 'package:garments_app/view/staff_khata/staff_attendence.dart';
import 'package:garments_app/view/staff_khata/staff_khata.dart';
import 'package:garments_app/view/voucher.dart';
//import 'package:fluttertoast/fluttertoast.dart';
// import 'package:myapp/createWorkPage.dart';
// import 'package:myapp/myappointListPage.dart';
// import 'package:myapp/myworkers.dart';
// import 'package:myapp/policeComplain.dart';
// import 'package:myapp/searchPage.dart';
// import 'package:myapp/showProfilePage.dart';
//import 'package:http/http.dart' as http;
// import 'package:myapp/updateProfilePageOwner.dart';
// import 'package:myapp/updateProfilePageWorker.dart';

class HomePage extends StatefulWidget {
  // String Username;
  // String Usertype;
  // String UserAddress;
  // String UserIamge;
  // String UserPhone;
  // String UserWorkingHour;
  const HomePage({
    Key? key,
    // required this.Username,
    // required this.Usertype,
    // required this.UserAddress,
    // required this.UserIamge,
    // required this.UserPhone,
    // required this.UserWorkingHour,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> itemStrings = [
    'Daily Sheet',
    'Staff Khata',
    'Party Khata',
    'Staff Attendence',
    'Bill',
    'Voucher',
    'Chalan'
  ];
  List<Widget> itemWidgets = [
    const DailySheetPage(),
    const StaffKhataPage(),
    const PartyKhataPage(),
    const StaffAttendencePage(),
    const BillPage(),
    const VoucherPage(),
    const ChalanPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          // leading: IconButton(
          //   onPressed: () {
          //     _scaffoldKey.currentState?.openDrawer();
          //   },
          //  icon: Icon(Icons.upgrade_sharp)
          // ),
          automaticallyImplyLeading: false,
          title: Center(child: Text("BM Garments"))),
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
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Manager',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            ),
          ),
          for (int x = 0; x < itemStrings.length; x++)
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => itemWidgets[x]));
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
