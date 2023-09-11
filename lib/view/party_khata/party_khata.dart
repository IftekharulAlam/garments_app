import 'package:flutter/material.dart';
import 'package:garments_app/view/party_khata/party_khata_details.dart';

class PartyKhataPage extends StatefulWidget {
  const PartyKhataPage({super.key});

  @override
  State<PartyKhataPage> createState() => _PartyKhataPageState();
}

class _PartyKhataPageState extends State<PartyKhataPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> itemStrings = [
    'New Look',
    'Al-Amin Garments',
    'BM Garments Dokan',
    'Lumi Universe',
    'Boishakhi',
    'Ruposhi Bangla',
    'Mehedi Garments'
  ];
  List<Widget> itemsWidgets = [
    PartyKhataDetails(),
    PartyKhataDetails(),
    PartyKhataDetails(),
    PartyKhataDetails(),
    PartyKhataDetails(),
    PartyKhataDetails(),
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
              'Party Khata',
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
