import 'package:flutter/material.dart';
import 'package:garments_app/view/bill/bill_create.dart';

class BillPage extends StatefulWidget {
  const BillPage({super.key});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> itemStrings = [
    'Bill No 1728',
    'Bill No 1728',
    'Bill No 1728',
    'Bill No 1728',
    'Bill No 1728',
  ];
  List<Widget> itemsWidgets = [];

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
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Bill',
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
              child: const Text('Create New Bill'),
              onPressed: () {
                // login(name.text, password.text, dropdownvalue);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BillCreatePage()));
              },
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
