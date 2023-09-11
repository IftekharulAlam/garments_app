import 'package:flutter/material.dart';

class ChalanPage extends StatefulWidget {
  const ChalanPage({super.key});

  @override
  State<ChalanPage> createState() => _ChalanPageState();
}

class _ChalanPageState extends State<ChalanPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> itemStrings = [
    'Chalan No 1728',
    'Chalan No 1728',
    'Chalan No 1728',
    'Chalan No 1728',
    'Chalan No 1728',
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
              'Chalan',
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
