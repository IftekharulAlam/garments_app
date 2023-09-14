import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garments_app/controller/controller.dart';
import 'package:garments_app/model/model.dart';

import 'package:http/http.dart' as http;

class BillCreatePage extends StatefulWidget {
  const BillCreatePage({super.key});

  @override
  State<BillCreatePage> createState() => _BillCreatePageState();
}

class _BillCreatePageState extends State<BillCreatePage> {
  Future<GarmentsApp>? _future;
  Products? _selected;
  @override
  void initState() {
    _future = getProductsListmy();
    // TODO: implement initState

    super.initState();
  }

  String dropdownvalue = 'Owner';
  var items = ['Owner', 'Manager', 'Staff', 'Designer'];
  static const String _title = 'BM Garments';
  TextEditingController ProductDetails = TextEditingController();
  TextEditingController Size = TextEditingController();
  TextEditingController Quantity = TextEditingController();
  TextEditingController Rate = TextEditingController();

  Future register(
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

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('Item')),
      const DataColumn(label: Text('Rate')),
      const DataColumn(label: Text('Quantity')),
      const DataColumn(label: Text('Amount')),
      const DataColumn(label: Text('Update')),
      const DataColumn(label: Text('Delete')),
    ];
  }

  List<DataColumn> _createColumns3() {
    return [
      const DataColumn(label: Text('')),
      const DataColumn(label: Text('')),
      const DataColumn(label: Text('')),
      const DataColumn(label: Text('')),
      const DataColumn(label: Text('')),
      const DataColumn(label: Text('')),
    ];
  }

  List<DataColumn> _createColumns2() {
    return [
      const DataColumn(label: Text('Total')),
      const DataColumn(label: Text('100')),
    ];
  }

  List<DataRow> _createRows() {
    return [
      DataRow(cells: [
        DataCell(Text('#50')),
        DataCell(Text('200')),
        DataCell(Text('200')),
        DataCell(Text('200')),
        DataCell(
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
        ),
        DataCell(
          IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
        ),
      ]),
      DataRow(cells: [
        DataCell(Text('#50')),
        DataCell(Text('200')),
        DataCell(Text('200')),
        DataCell(Text('200')),
        DataCell(
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
        ),
        DataCell(
          IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
        ),
      ]),
      DataRow(cells: [
        DataCell(Text('#50')),
        DataCell(Text('200')),
        DataCell(Text('200')),
        DataCell(Text('200')),
        DataCell(
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
        ),
        DataCell(
          IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
        ),
      ]),
      DataRow(cells: [
        DataCell(Text('#50')),
        DataCell(Text('200')),
        DataCell(Text('200')),
        DataCell(Text('200')),
        DataCell(
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
        ),
        DataCell(
          IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
        ),
      ]),
      DataRow(cells: [
        DataCell(Text('#50')),
        DataCell(Text('200')),
        DataCell(Text('200')),
        DataCell(Text('200')),
        DataCell(
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
        ),
        DataCell(
          IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
        ),
      ]),
      DataRow(cells: [
        DataCell(Text('#50')),
        DataCell(Text('200')),
        DataCell(Text('200')),
        DataCell(Text('200')),
        DataCell(
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
        ),
        DataCell(
          IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
        ),
      ]),
      DataRow(cells: [
        DataCell(Text('#50')),
        DataCell(Text('200')),
        DataCell(Text('200')),
        DataCell(Text('200')),
        DataCell(
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
        ),
        DataCell(
          IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
        ),
      ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: ListView(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    child: TextField(
                      controller: ProductDetails,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    child: TextField(
                      controller: ProductDetails,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone',
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: ElevatedButton(
                    child: const Text('Add'),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: FutureBuilder(
                      future: _future,
                      builder: (BuildContext context,
                          AsyncSnapshot<GarmentsApp> sn) {
                        if (sn.hasData) {
                          return DropdownButton<Products>(
                            items: sn.data!.products.map((products) {
                              return DropdownMenuItem<Products>(
                                value: products,
                                child: Text(products.productModelNo.toString()),
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
                Container(
                  height: 30,
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: ElevatedButton(
                    child: const Text('Add'),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  child: const Text(
                    'Products List',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: DropdownButton(
                    underline: Container(),
                    style: const TextStyle(
                        //te
                        color: Colors.black, //Font color
                        fontSize: 15 //font size on dropdown button
                        ),
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(value: items, child: Text(items));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  child: const Text(
                    'Size',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: DropdownButton(
                    underline: Container(),
                    style: const TextStyle(
                        //te
                        color: Colors.black, //Font color
                        fontSize: 15 //font size on dropdown button
                        ),
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(value: items, child: Text(items));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  child: const Text(
                    'Available:',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  child: const Text(
                    '10',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.all(5),
                    child: TextField(
                      controller: Size,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Quantity',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: ElevatedButton(
                      child: const Text('Add'),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            const Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.man_2_outlined,
                        color: Colors.cyan, size: 40),
                    title: Text(
                      "Name : Kajol Khan",
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Row(
                      children: [
                        Text('Phone : Senior'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            DataTable(
                columnSpacing: 18.0, columns: _createColumns(), rows: const []),
            SizedBox(
              height: 300,
              child: SingleChildScrollView(
                child: DataTable(
                    headingRowHeight: 0,
                    columnSpacing: 33.0,
                    columns: _createColumns3(),
                    rows: _createRows()),
              ),
            ),
            DataTable(
                columnSpacing: 20.0,
                columns: _createColumns2(),
                rows: const []),
            Row(
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
                    child: const Text('Paid'),
                    onPressed: () {},
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
