import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:garments_app/controller/controller.dart';
import 'package:garments_app/model/model.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DailySheetKhorochPage extends StatefulWidget {
  const DailySheetKhorochPage({super.key});

  @override
  State<DailySheetKhorochPage> createState() => _DailySheetKhorochPageState();
}

class _DailySheetKhorochPageState extends State<DailySheetKhorochPage> {
  Future<GarmentsApp>? _future;
  Future<GarmentsApp>? _future2;
  Khatiyan? _selected;
  Staff? _selected2;
  String? datetime;
  String status = "pending";
  int totalAmount = 0;
  Future createDailysheetKhoroch(List<DailySheetJoma> listOfData) async {
    String finalUrl = "http://$mydeviceIP:8000/createDailysheetKhoroch";
    String jsonOfListOfData = jsonEncode(listOfData);
    var url = Uri.parse(finalUrl);

    late http.Response response;
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
      listOFAmount.clear();
      listOFItem.clear();
      totalAmount = 0;
      Navigator.of(context).pop();
    });
  }

  List<DailySheetJoma> myList = [];
  List<String> listOFItem = [];
  List<String> listOFAmount = [];
  TextEditingController name = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController khatiyanAmount = TextEditingController();
  TextEditingController staffAmount = TextEditingController();

  TextEditingController editFromListItem = TextEditingController();
  TextEditingController editFromListAmount = TextEditingController();
  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('Item')),
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
          DataCell(Text(listOFAmount[i])),
          DataCell(
            IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  editFromListItem.text = listOFItem[i];
                  editFromListAmount.text = listOFAmount[i];

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
                              decoration: const InputDecoration(hintText: ""),
                            ),
                            TextField(
                              controller: editFromListAmount,
                              decoration: const InputDecoration(hintText: ""),
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
                                      myList[i] = DailySheetJoma(
                                          item: editFromListItem.text,
                                          amount: editFromListAmount.text,
                                          date: datetime!,
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
      const DataColumn(label: Text('Amount')),
    ];
  }

  List<DataRow> _createRows2() {
    return [
      for (int i = 0; i < listOFItem.length; i++)
        DataRow(cells: [
          DataCell(Text(listOFItem[i])),
          DataCell(Text(listOFAmount[i])),
        ]),
    ];
  }

  @override
  void initState() {
    _future = getKhatiyanListmy();
    _future2 = getStaffKhatiyanListmy();
    datetime = DateFormat("dd-MM-yyyy").format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Sheet Khoroch"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Text(
                'Date : $datetime',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: TextField(
                      controller: name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'New Entry',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextField(
                      controller: amount,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Amount',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: ElevatedButton(
                      child: const Text('Add'),
                      onPressed: () {
                        setState(() {
                          if (name.text.isEmpty && amount.text.isEmpty) {
                          } else {
                            myList.add(DailySheetJoma(
                                item: name.text,
                                amount: amount.text,
                                date: datetime!,
                                status: status));
                            int available = int.parse(amount.text);
                            totalAmount += available;
                            listOFItem.add(name.text);
                            listOFAmount.add(amount.text);
                            name.text = "";
                            amount.text = "";
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Khatiyan List:',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                      future: _future,
                      builder: (BuildContext context,
                          AsyncSnapshot<GarmentsApp> sn) {
                        if (sn.hasData) {
                          return DropdownButton<Khatiyan>(
                            isExpanded: true,
                            items: sn.data!.khatiyanList.map((khatiyanList) {
                              return DropdownMenuItem<Khatiyan>(
                                value: khatiyanList,
                                child:
                                    Text(khatiyanList.khatiyanName.toString()),
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
                          return const Center(
                              child: Text("Error Loading Data"));
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextField(
                      controller: khatiyanAmount,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Amount',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
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
                                status: status));
                            int available = int.parse(khatiyanAmount.text);
                            totalAmount += available;
                            listOFItem.add(_selected!.khatiyanName.toString());
                            listOFAmount.add(khatiyanAmount.text);
                            khatiyanAmount.text = "";
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Staff List:',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                      future: _future2,
                      builder: (BuildContext context,
                          AsyncSnapshot<GarmentsApp> sn) {
                        if (sn.hasData) {
                          return DropdownButton<Staff>(
                            isExpanded: true,
                            items: sn.data!.staffList.map((staffList) {
                              return DropdownMenuItem<Staff>(
                                value: staffList,
                                child: Text(staffList.staffName.toString()),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selected2 = value;
                              });
                            },
                            value: _selected2,
                          );
                        }
                        if (sn.hasError) {
                          return const Center(
                              child: Text("Error Loading Data"));
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    width: 20,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextField(
                      controller: staffAmount,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Amount',
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Add'),
                    onPressed: () {
                      setState(() {
                        if (staffAmount.text.isEmpty) {
                        } else {
                          myList.add(DailySheetJoma(
                              item: _selected2!.staffName.toString(),
                              amount: staffAmount.text,
                              date: datetime!,
                              status: status));
                          int available = int.parse(staffAmount.text);
                          totalAmount += available;
                          listOFItem.add(_selected2!.staffName.toString());
                          listOFAmount.add(staffAmount.text);
                          staffAmount.text = "";
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 200,
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
                      setState(() {
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
                                              createDailysheetKhoroch(
                                                  myList);
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
                      });
                    },
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Cancel'),
                    onPressed: () {
                      setState(() {
                        listOFAmount.clear();
                        listOFItem.clear();
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
