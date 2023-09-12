import 'package:flutter/material.dart';
import 'package:garments_app/view/daily_sheet/daily_sheet_add.dart';
import 'package:garments_app/view/daily_sheet/daily_sheet_view.dart';

class DailySheetPage extends StatefulWidget {
  const DailySheetPage({super.key});

  @override
  State<DailySheetPage> createState() => _DailySheetPageState();
}

class _DailySheetPageState extends State<DailySheetPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> itemStrings = [
    'Date 1/10/13',
    'Date 1/10/13',
    'Date 1/10/13',
    'Date 1/10/13',
    'Date 1/10/13',
  ];
  List<Widget> itemsWidgets = [
    const DailySheetViewPage(),
    const DailySheetViewPage(),
    const DailySheetViewPage(),
    const DailySheetViewPage(),
    const DailySheetViewPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          
          title: const Text("BM Garments")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Daily Sheet',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 25),
            ),
          ),
          Row(
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Khoroch'),
                  onPressed: () {
                    // login(name.text, password.text, dropdownvalue);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DailySheetAddPage()));
                  },
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Joma'),
                  onPressed: () {
                    // login(name.text, password.text, dropdownvalue);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DailySheetAddPage()));
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
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
