// ignore_for_file: non_constant_identifier_names, unnecessary_new, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garments_app/controller/garmentsApp.dart';


import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class BillCreatePage extends StatefulWidget {
  String myShopName;
  BillCreatePage({super.key, required this.myShopName});

  @override
  State<BillCreatePage> createState() => _BillCreatePageState();
}

class _BillCreatePageState extends State<BillCreatePage> {
  List<TextEditingController> listOfTextField = [];
  List<String> listOFProductModelNo = [];
  List<String> listOFProductRate = [];
  List<String> listOFProductSize = [];
  List<String> listOFProductQuantity = [];
  List<int> listOFProductAmount = [];

  static const String _title = 'Create Bill';
  String? datetime;
  @override
  void initState() {

    datetime = DateFormat("dd-MM-yyyy").format(DateTime.now());
    super.initState();
  }

  int totalAmount = 0;
  TextEditingController ProductDetails = TextEditingController();
  TextEditingController Size = TextEditingController();
  TextEditingController Quantity = TextEditingController();
  TextEditingController Rate = TextEditingController();

  late List unis;
  List<DataColumn> _productListColumns() {
    return [
      const DataColumn(label: Text('ModelNo')),
      const DataColumn(label: Text('Size')),
      const DataColumn(label: Text('Available')),
      const DataColumn(label: Text('Selected')),
      const DataColumn(label: Text('Command')),
    ];
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('Item')),
      const DataColumn(label: Text('Size')),
      const DataColumn(label: Text('Quantity')),
      const DataColumn(label: Text('Rate')),
      const DataColumn(label: Text('Amount')),
      const DataColumn(label: Text('Delete')),
    ];
  }

  List<DataColumn> _createColumns2() {
    return [
      const DataColumn(label: Text('Item')),
      const DataColumn(label: Text('Size')),
      const DataColumn(label: Text('Quantity')),
      const DataColumn(label: Text('Amount')),
    ];
  }

  Future getProductsAvailableList() async {
    http.Response response = await http.get(
      Uri.parse("http://$mydeviceIP:8000/getProductsAvailableList"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error loading data");
    }
  }

  Future createBill(
      String shopName,
      String date,
      List<String> listOFProductModelNo,
      List<String> listOFProductRate,
      List<String> listOFProductSize,
      List<String> listOFProductQuantity,
      int totalAmount2) async {
    late http.Response response;
    for (int i = 0; i < listOFProductModelNo.length; i++) {
      response = await http
          .post(Uri.parse("http://$mydeviceIP:8000/createBill"), body: {
        "shopName": shopName,
        "date": date,
        "listOFProductModelNo": listOFProductModelNo[i],
        "listOFProductRate": listOFProductRate[i],
        "listOFProductSize": listOFProductSize[i],
        "listOFProductQuantity": listOFProductQuantity[i],
        "totalAmount": totalAmount2.toString()
      });
      if (response.statusCode == 200) {
      } else {
        throw Exception("Error loading data");
      }
    }
    addBillToPartyKhatiyan(shopName, date, totalAmount);
    setState(() {
      listOFProductModelNo.clear();
      listOFProductRate.clear();
      listOFProductSize.clear();
      listOFProductQuantity.clear();
      listOFProductAmount.clear();
      totalAmount = 0;
    });
  }

  Future addBillToPartyKhatiyan(
      String shopName, String date, int totalAmount2) async {
    late http.Response response;

    response = await http.post(
        Uri.parse("http://$mydeviceIP:8000/addBillToPartyKhatiyan"),
        body: {
          "shopName": shopName,
          "date": date,
          "totalAmount": totalAmount2.toString()
        });
    if (response.statusCode == 200) {
    } else {
      throw Exception("Error loading data");
    }
  }

  List<DataRow> _createRows() {
    return [
      for (int i = 0; i < listOFProductModelNo.length; i++)
        DataRow(cells: [
          DataCell(Text(listOFProductModelNo[i])),
          DataCell(Text(listOFProductSize[i])),
          DataCell(Text(listOFProductQuantity[i])),
          DataCell(Text(listOFProductRate[i])),
          DataCell(Text(listOFProductAmount[i].toString())),
          DataCell(
            IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    int myProductRate =
                        int.parse(listOFProductRate.elementAt(i));
                    int myProductQuantity =
                        int.parse(listOFProductQuantity.elementAt(i));
                    totalAmount -= myProductRate * myProductQuantity;
                    listOFProductModelNo.removeAt(i);
                    listOFProductRate.removeAt(i);
                    listOFProductQuantity.removeAt(i);
                    listOFProductSize.removeAt(i);
                    listOFProductAmount.removeAt(i);
                  });
                }),
          ),
        ]),
    ];
  }

  List<DataRow> _createRows2() {
    return [
      for (int i = 0; i < listOFProductModelNo.length; i++)
        DataRow(cells: [
          DataCell(Text(listOFProductModelNo[i])),
          DataCell(Text(listOFProductSize[i])),
          DataCell(Text(listOFProductQuantity[i])),
          DataCell(Text(listOFProductAmount[i].toString())),
        ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    'Name : ${widget.myShopName}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Date : $datetime',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            DataTable(
                showBottomBorder: true,
                columnSpacing: 20.0,
                columns: _productListColumns(),
                rows: const []),
            SizedBox(
              height: 200,
              child: FutureBuilder(
                future: getProductsAvailableList(),
                builder: (BuildContext context, AsyncSnapshot sn) {
                  if (sn.hasData) {
                    unis = sn.data;
                    listOfTextField = List.generate(
                        unis.length, (i) => TextEditingController());
                    return ListView.builder(
                      itemCount: unis.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {},
                        child: Card(
                          child: ListTile(
                            title: Row(
                              children: [
                                Text("${unis[index]["productModelNo"]}"),
                                const SizedBox(width: 45),
                                Text("${unis[index]["productSize"]}"),
                                const SizedBox(width: 35),
                                Text("${unis[index]["productAvailable"]}"),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 60,
                                  height: 40,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(fontSize: 18),
                                    controller: listOfTextField[index],
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(
                                        () {
                                          if (int.parse(
                                                  listOfTextField[index].text) >
                                              0) {
                                            int available = int.parse(
                                                unis[index]
                                                    ["productAvailable"]);
                                            int requested = int.parse(
                                                listOfTextField[index].text);
                                            if (requested <= available) {
                                              int myProductRate = int.parse(
                                                  unis[index]["productRate"]);
                                              int myProductQuantity = int.parse(
                                                  listOfTextField[index].text);
                                              listOFProductAmount.add(
                                                  myProductRate *
                                                      myProductQuantity);
                                              listOFProductSize.add(
                                                  unis[index]["productSize"]);
                                              listOFProductModelNo.add(
                                                  unis[index]
                                                      ["productModelNo"]);
                                              listOFProductRate.add(
                                                  unis[index]["productRate"]);
                                              listOFProductQuantity.add(
                                                  listOfTextField[index].text);
                                              totalAmount += myProductRate *
                                                  myProductQuantity;
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "Not Available",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Enter A Number",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.add)),
                              ],
                            ),
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
            SizedBox(
              height: 200,
              child: SingleChildScrollView(
                child: DataTable(
                    showBottomBorder: true,
                    columnSpacing: 20.0,
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
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: ElevatedButton(
                    child: const Text('Save Bill'),
                    onPressed: () {
                      setState(() {
                        if (listOFProductModelNo.isNotEmpty) {
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
                                            child: const Text('Save'),
                                            onPressed: () {
                                              createBill(
                                                  widget.myShopName,
                                                  datetime!,
                                                  listOFProductModelNo,
                                                  listOFProductRate,
                                                  listOFProductSize,
                                                  listOFProductQuantity,
                                                  totalAmount);
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
                    child: const Text('Paid'),
                    onPressed: () {},
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Cancel'),
                    onPressed: () {
                      setState(() {
                        listOFProductModelNo.clear();
                        listOFProductRate.clear();
                        listOFProductSize.clear();
                        listOFProductQuantity.clear();
                        listOFProductAmount.clear();
                        totalAmount = 0;
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
