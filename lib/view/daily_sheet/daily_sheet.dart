// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:garments_app/controller/garmentsApp.dart';
import 'package:garments_app/model/dailySheet.dart';
import 'package:garments_app/view/daily_sheet/daily_sheet_joma_khoroch.dart';
import 'package:garments_app/view/daily_sheet/daily_sheet_joma_khoroch_update.dart';
import 'package:garments_app/view/daily_sheet/daily_sheet_view.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DailySheetPage extends StatefulWidget {
  DailySheetPage({super.key});

  @override
  State<DailySheetPage> createState() => _DailySheetPageState();
}

class _DailySheetPageState extends State<DailySheetPage> {
  String? datetime;
  late String selectedDate = "New";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<DailysheetJomaKhorochList> dailysheetJomaKhorochlist = [];
  Future dailysheetJomaKhorochList() async {
    http.Response response = await http.get(
      Uri.parse("http://$mydeviceIP:8000/dailysheetJomaKhorochList"),
    );

    if (response.statusCode == 200) {
      setState(() {
        List result = jsonDecode(response.body);
        dailysheetJomaKhorochlist =
            result.map((e) => DailysheetJomaKhorochList.fromJson(e)).toList();
        for (var i = 0; i < dailysheetJomaKhorochlist.length; i++) {
          if (dailysheetJomaKhorochlist.elementAt(i).date == datetime) {
            selectedDate = dailysheetJomaKhorochlist.elementAt(i).date;
          } else {
            selectedDate = "New";
          }
        }
      });
    } else {
      throw Exception("Error loading data");
    }
  }

  @override
  void initState() {
    datetime = DateFormat("dd-MM-yyyy").format(DateTime.now());
    dailysheetJomaKhorochList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text("Daily Sheet")),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Joma'),
                  onPressed: () {
                    if (selectedDate == "New") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DailySheetJomaKhorochPage(
                              jomaKhorochType: 'Joma'),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DailySheetJomaKhorochPageUpdate(
                            jomaKhorochType: 'Joma',
                            date: datetime!,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Khoroch'),
                  onPressed: () {
                    if (selectedDate == "New") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DailySheetJomaKhorochPage(
                              jomaKhorochType: 'Khoroch'),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DailySheetJomaKhorochPageUpdate(
                            jomaKhorochType: 'Khoroch',
                            date: datetime!,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              itemCount: dailysheetJomaKhorochlist.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DailySheetViewPage(
                                date: dailysheetJomaKhorochlist[index].date,
                              )));
                },
                child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.edit_document),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(dailysheetJomaKhorochlist[index].date),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        dailysheetJomaKhorochlist[index].date == datetime!
                            ? const Icon(Icons.edit)
                            : const Icon(Icons.edit_off),
                        dailysheetJomaKhorochlist[index].status == "pending"
                            ? const Icon(Icons.pending)
                            : const Icon(Icons.copyright_rounded),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
