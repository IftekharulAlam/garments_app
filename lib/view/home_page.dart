// ignore_for_file: prefer_const_constructors, must_be_immutable, use_build_context_synchronously

// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garments_app/view/bill/bill.dart';
import 'package:garments_app/view/chalan.dart';
import 'package:garments_app/view/daily_sheet/daily_sheet.dart';
import 'package:garments_app/view/khatiyan/khatiyan_list.dart';
import 'package:garments_app/view/party_khata/party_khata.dart';
import 'package:garments_app/view/products/products_list.dart';

import 'package:garments_app/view/staff_khata/staff_khata.dart';
import 'package:garments_app/view/voucher.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> itemStrings = [
    'Products',
    'Daily Sheet',
    'Khatiyan',
    'Staff Khata',
    'Party Khata',
    'Bill',
    'Voucher',
    'Chalan'
  ];
  List<Widget> itemWidgets = [
    const ProductsListPage(),
    const DailySheetPage(),
    const KhatiyanListPage(),
    const StaffKhataPage(),
    const PartyKhataPage(),
    const BillPage(),
    const VoucherPage(),
    const ChalanPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("BM Garments")),
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
        padding: EdgeInsets.all(10),
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
