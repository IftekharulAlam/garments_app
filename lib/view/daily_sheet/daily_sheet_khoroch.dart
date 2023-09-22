import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  Future createDailysheetKhoroch(List<String> listOFItem,
      List<String> listOFAmount, String datetime) async {
    http.Response response;
    String finalUrl = "http://192.168.0.100:8000/createDailysheetKhoroch";
    var url = Uri.parse(finalUrl);
    for (int x = 0; x < listOFItem.length; x++) {
      response = await http.post(url, body: {
        "datetime": datetime.toString(),
        "listOFItem": listOFItem[x],
        "listOFAmount": listOFAmount[x],
      });
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
    }
  }

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
                        title: const Text('TextField AlertDemo'),
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
                    listOFItem.removeAt(i);
                    listOFAmount.removeAt(i);
                  });
                }),
          ),
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
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Add'),
                      onPressed: () {
                        setState(() {
                          if (name.text.isEmpty && amount.text.isEmpty) {
                          } else {
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
                  flex: 2,
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
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Add'),
                    onPressed: () {
                      setState(() {
                        if (khatiyanAmount.text.isEmpty) {
                        } else {
                          listOFItem.add(_selected!.khatiyanName.toString());
                          listOFAmount.add(khatiyanAmount.text);
                          khatiyanAmount.text = "";
                        }
                      });
                    },
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
                  flex: 2,
                  child: Container(
                    height: 50,
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
              height: 300,
              child: SingleChildScrollView(
                child:
                    DataTable(columns: _createColumns(), rows: _createRows()),
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  setState(() {
                    if (listOFItem.isEmpty && listOFAmount.isEmpty) {
                    } else {
                      createDailysheetKhoroch(
                          listOFItem, listOFAmount, datetime!);
                      listOFAmount.clear();
                      listOFItem.clear();
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}