import 'package:flutter/material.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({super.key});

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> itemStrings = [
    'Voucher No 1728',
    'Voucher No 1728',
    'Voucher No 1728',
    'Voucher No 1728',
    'Voucher No 1728',
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
              'Voucher',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: const Text('Create New Voucher'),
              onPressed: () {},
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
