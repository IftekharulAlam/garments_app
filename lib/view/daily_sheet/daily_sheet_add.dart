import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garments_app/controller/garmentsApp.dart';
import 'package:garments_app/controller/khatiyan.dart';

import 'package:garments_app/model/dailySheet.dart';
import 'package:garments_app/model/garmentsApp.dart';
import 'package:garments_app/model/khatiyan.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DailySheetAddPage extends StatefulWidget {
  const DailySheetAddPage({super.key});

  @override
  State<DailySheetAddPage> createState() => _DailySheetAddPageState();
}

class _DailySheetAddPageState extends State<DailySheetAddPage> {
  Future<GarmentsApp>? _future;
  Khatiyan? _selected;
  String? datetime;
  String status = "pending";
  int totalAmount = 0;
  Future createDailysheetJoma(List<DailySheetJoma> listOfData) async {
    String finalUrl = "http://$mydeviceIP:8000/createDailysheetJoma";
    String jsonOfListOfData = jsonEncode(listOfData);
    var url = Uri.parse(finalUrl);

    http.Response response;
    response = await http.post(url, body: {"listOFItem": jsonOfListOfData});
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Update Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      throw Exception("Error loading data");
    }

    setState(() {
      myList.clear();
      listOFAmount.clear();
      listOFItem.clear();
      totalAmount = 0;
      Navigator.pop(context);
    });
  }

  List<DailySheetJoma> myList = [];

  List<String> listOFItem = [];
  List<String> listOFDetails = [];
  List<String> listOFAmount = [];
  TextEditingController name = TextEditingController();
  TextEditingController details = TextEditingController(text: 'Nogod');
  TextEditingController khatiyanAmount = TextEditingController();
  TextEditingController editFromListItem = TextEditingController();
  TextEditingController editFromListDetails = TextEditingController();
  TextEditingController editFromListAmount = TextEditingController();

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('Item')),
      const DataColumn(label: Text('Details')),
      const DataColumn(label: Text('Amount')),
      const DataColumn(label: Text('Update')),
      const DataColumn(label: Text('Delete')),
    ];
  }

  List<DataRow> _createRows() {
    return [
      for (int i = 0; i < listOFItem.length; i++)
        DataRow(cells: [
          DataCell(Text(listOFItem[i])),
          DataCell(Text(listOFDetails[i])),
          DataCell(Text(listOFAmount[i])),
          DataCell(
            IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  editFromListItem.text = listOFItem[i];
                  editFromListAmount.text = listOFAmount[i];
                  editFromListDetails.text = listOFDetails[i];

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Update'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              readOnly: true,
                              controller: editFromListItem,
                              decoration: const InputDecoration(hintText: "Item"),
                            ),
                            TextField(
                              controller: editFromListDetails,
                              decoration: const InputDecoration(hintText: "Details"),
                            ),
                            TextField(
                              controller: editFromListAmount,
                              decoration: const InputDecoration(hintText: "Amount"),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  child: const Text('Update'),
                                  onPressed: () {
                                    setState(() {
                                      listOFItem[i] = editFromListItem.text;
                                      listOFAmount[i] = editFromListAmount.text;
                                      listOFDetails[i] = editFromListDetails.text;
                                      for (int i = 0;
                                          i < listOFAmount.length;
                                          i++) {
                                        int available =
                                            int.parse(listOFAmount[i]);
                                        totalAmount += available;
                                      }
                                      myList[i] = DailySheetJoma(
                                          item: editFromListItem.text,
                                          amount: editFromListAmount.text,
                                          date: datetime!,
                                          details: editFromListDetails.text,
                                          status: status);
                                      Navigator.pop(context);
                                    });
                                  },
                                ),
                              ),
                              ElevatedButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                }),
          ),
          DataCell(
            IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    int available = int.parse(listOFAmount[i]);
                    totalAmount -= available;
                    listOFItem.removeAt(i);
                    listOFDetails.removeAt(i);
                    listOFAmount.removeAt(i);
                    myList.removeAt(i);
                  });
                }),
          ),
        ]),
    ];
  }

  List<DataColumn> _createColumns2() {
    return [
      const DataColumn(label: Text('Item')),
      const DataColumn(label: Text('Details')),
      const DataColumn(label: Text('Amount')),
    ];
  }

  List<DataRow> _createRows2() {
    return [
      for (int i = 0; i < listOFItem.length; i++)
        DataRow(cells: [
          DataCell(Text(listOFItem[i])),
          DataCell(Text(listOFDetails[i])),
          DataCell(Text(listOFAmount[i])),
        ]),
    ];
  }

  @override
  void initState() {
    _future = getKhatiyanListAll();
    datetime = DateFormat("dd-MM-yyyy").format(DateTime.now());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Sheet Joma"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            child: Text(
              'Date : $datetime',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            child: const Text(
              'Khatiyan List:',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FutureBuilder(
                  future: _future,
                  builder:
                      (BuildContext context, AsyncSnapshot<GarmentsApp> sn) {
                    if (sn.hasData) {
                      return DropdownButton<Khatiyan>(
                        isExpanded: true,
                        items: sn.data!.khatiyanList.map((khatiyanList) {
                          return DropdownMenuItem<Khatiyan>(
                            value: khatiyanList,
                            child: Text(khatiyanList.khatiyanName.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selected = value;
                          });
                        },
                        value: _selected,
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
              Container(
                height: 70,
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: details,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Details',
                  ),
                ),
              ),
              Container(
                height: 70,
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: khatiyanAmount,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Amount',
                  ),
                ),
              ),
              Container(
                height: 50,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Add'),
                  onPressed: () {
                    setState(() {
                      if (khatiyanAmount.text.isEmpty) {
                      } else {
                        myList.add(DailySheetJoma(
                            item: _selected!.khatiyanName.toString(),
                            amount: khatiyanAmount.text,
                            date: datetime!,
                            details: details.text,
                            status: status));
                        if (listOFItem
                            .contains(_selected!.khatiyanName.toString())) {
                          int a = listOFItem
                              .indexOf(_selected!.khatiyanName.toString());
                          String m = listOFAmount.elementAt(a);
                          int available = int.parse(m);
                          int available2 =
                              int.parse(khatiyanAmount.text) + available;
                          listOFAmount[a] = available2.toString();
      
                          myList[a] = DailySheetJoma(
                              item: _selected!.khatiyanName.toString(),
                              amount: available2.toString(),
                              date: datetime!,
                              details: listOFDetails[a],
                              status: status);
                          totalAmount = 0;
                          for (int i = 0; i < listOFAmount.length; i++) {
                            int available = int.parse(listOFAmount[i]);
                            totalAmount += available;
                          }
                          khatiyanAmount.text = "";
                           details.text = "Nogod";
                        } else {
                          int available = int.parse(khatiyanAmount.text);
                          totalAmount += available;
                          listOFItem.add(_selected!.khatiyanName.toString());
                          listOFDetails.add(details.text);
                          listOFAmount.add(khatiyanAmount.text);
                          khatiyanAmount.text = "";
                          details.text = "Nogod";
                        }
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: DataTable(
                  columnSpacing: 15,
                  columns: _createColumns(),
                  rows: _createRows()),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            child: Text(
              'Total : $totalAmount',
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    setState(
                      () {
                        if (listOFItem.isEmpty && listOFAmount.isEmpty) {
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    DataTable(
                                        showBottomBorder: true,
                                        columnSpacing: 9.0,
                                        columns: _createColumns2(),
                                        rows: _createRows2()),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        'Total : $totalAmount',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 30,
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 0, 5, 0),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                            ),
                                            child: const Text('Submit'),
                                            onPressed: () {
                                              createDailysheetJoma(myList);
                                            },
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 0, 5, 0),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                            ),
                                            child: const Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Clear'),
                  onPressed: () {
                    setState(
                      () {
                        listOFAmount.clear();
                        listOFDetails.clear();
                        myList.clear();
                        listOFItem.clear();
                        totalAmount = 0;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
