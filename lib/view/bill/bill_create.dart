// ignore_for_file: non_constant_identifier_names, unnecessary_new, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

class BillCreatePage extends StatefulWidget {
  String myShopName;
  BillCreatePage({super.key, required this.myShopName});

  @override
  State<BillCreatePage> createState() => _BillCreatePageState();
}

class _BillCreatePageState extends State<BillCreatePage> {
  Future getProductsList() async {
    http.Response response = await http.get(
      Uri.parse("http://192.168.0.100:8000/getProductsList"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error loading data");
    }
  }

  static const String _title = 'BM Garments';

  int totalAmount = 0;
  TextEditingController ProductDetails = TextEditingController();
  TextEditingController Size = TextEditingController();
  TextEditingController Quantity = TextEditingController();
  TextEditingController Rate = TextEditingController();

  Future createBill(
      String name,
      String address,
      String phone,
      String nid,
      String password,
      String fathersName,
      String mothersName,
      String salary,
      String type) async {
    http.Response response = await http
        .post(Uri.parse("http://192.168.0.50:8080/registerUser"), body: {
      "name": name,
      "address": address,
      "phone": phone,
      "nid": nid,
      "password": password,
      "fathersName": fathersName,
      "mothersName": mothersName,
      "salary": salary,
      "type": type,
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
      return jsonDecode(response.body);
    } else {
      throw Exception("Error loading data");
    }
  }

  List<TextEditingController> listOfTextField = [];
  List<String> listOFProductModelNo = [];
  List<String> listOFProductRate = [];
  List<String> listOFProductSize = [];
  List<String> listOFProductQuantity = [];
  List<int> listOFProductAmount = [];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            child: Text(
              'Name : ${widget.myShopName}',
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
          ),
          DataTable(
              showBottomBorder: true,
              columnSpacing: 20.0,
              columns: _productListColumns(),
              rows: const []),
          SizedBox(
            height: 200,
            child: FutureBuilder(
              future: getProductsList(),
              builder: (BuildContext context, AsyncSnapshot sn) {
                if (sn.hasData) {
                  List unis = sn.data;
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
                                width: 50,
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
                                          int myProductRate = int.parse(
                                              unis[index]["productRate"]);
                                          int myProductQuantity = int.parse(
                                              listOfTextField[index].text);
                                          listOFProductAmount.add(
                                              myProductRate *
                                                  myProductQuantity);
                                          listOFProductSize
                                              .add(unis[index]["productSize"]);
                                          listOFProductModelNo.add(
                                              unis[index]["productModelNo"]);
                                          listOFProductRate
                                              .add(unis[index]["productRate"]);
                                          listOFProductQuantity
                                              .add(listOfTextField[index].text);
                                          totalAmount +=
                                              myProductRate * myProductQuantity;
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
                  onPressed: () {},
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: ElevatedButton(
                   style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: const Text('Paid'),
                  onPressed: () {
                    setState(() {});
                  },
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: const Text('Cancel'),
                  onPressed: () {
                    setState(() {});
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
