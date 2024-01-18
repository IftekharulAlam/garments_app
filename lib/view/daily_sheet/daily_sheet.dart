import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garments_app/controller/controller.dart';
import 'package:garments_app/view/daily_sheet/daily_sheet_add.dart';
import 'package:garments_app/view/daily_sheet/daily_sheet_khoroch.dart';
import 'package:garments_app/view/daily_sheet/daily_sheet_view.dart';

import 'package:http/http.dart' as http;

class DailySheetPage extends StatefulWidget {
  const DailySheetPage({super.key});

  @override
  State<DailySheetPage> createState() => _DailySheetPageState();
}

Future dailysheetJomaKhorochList() async {
  http.Response response = await http.get(
    Uri.parse("http://$mydeviceIP:8000/dailysheetJomaKhorochList"),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Error loading data");
  }
}

class _DailySheetPageState extends State<DailySheetPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text("BM Garments")),
      body: Column(
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
                            builder: (context) =>
                                const DailySheetKhorochPage()));
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
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder(
                future: dailysheetJomaKhorochList(),
                builder: (BuildContext context, AsyncSnapshot sn) {
                  if (sn.hasData) {
                    List unis = sn.data;
                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      itemCount: unis.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  DailySheetViewPage(date :unis[index]["date"])));
                        },
                        child: Card(
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${unis[index]["date"]}"),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit))
                              ],
                            ),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.delete)),
                          ),
                        ),
                      ),
                    );
                  }
                  if (sn.hasError) {
                    return const Center(child: Text("Error Loading Data"));
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
