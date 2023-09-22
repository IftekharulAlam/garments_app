import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garments_app/controller/controller.dart';
import 'package:garments_app/model/model.dart';
import 'package:garments_app/view/products/product_view.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  Future<GarmentsApp>? _future;
  Products? _selected;

  TextEditingController productModelNo = TextEditingController();
  TextEditingController productDetails = TextEditingController();
  TextEditingController productRate = TextEditingController();
  TextEditingController productQuantity = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController productSize = TextEditingController();
  TextEditingController productionDate = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var list = [];
  List unismy = [];

  Future createProduct(String productModelNo, String productDetails,
      String productSize, String productRate) async {
    String finalUrl = "http://192.168.0.100:8000/createProduct";
    var url = Uri.parse(finalUrl);
    http.Response response = await http.post(url, body: {
      "productModelNo": productModelNo,
      "productDetails": productDetails,
      "productSize": productSize,
      "productRate": productRate,
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

  Future addProduct(String productModelNo, String productionDate,
      String productSize, String productQuantity) async {
    String finalUrl = "http://192.168.0.100:8000/addProduct";
    var url = Uri.parse(finalUrl);
    http.Response response = await http.post(url, body: {
      "productModelNo": productModelNo,
      "productionDate": productionDate,
      "productSize": productSize,
      "productQuantity": productQuantity
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

  @override
  void initState() {
    _future = getProductsListmy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text("BM Garments")),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: const Text(
              'Products',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                          child: AlertDialog(
                            title: const Text("Create Product"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: TextField(
                                    controller: productModelNo,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Model No',
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: TextField(
                                    controller: productDetails,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Details',
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: TextField(
                                    controller: productSize,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Size',
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: TextField(
                                    controller: productRate,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Rate',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: const Text("Create"),
                                onPressed: () {
                                  setState(() {
                                    list.clear();
                                    if (productModelNo.text.isEmpty ||
                                        productDetails.text.isEmpty ||
                                        productSize.text.isEmpty ||
                                        productRate.text.isEmpty) {
                                    } else {
                                      createProduct(
                                          productModelNo.text,
                                          productDetails.text,
                                          productSize.text,
                                          productRate.text);
                                      productModelNo.text = "";
                                      productDetails.text = "";
                                      productSize.text = "";
                                      productRate.text = "";
                                      Navigator.of(context).pop();
                                    }
                                  });
                                },
                              ),
                              ElevatedButton(
                                child: const Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Add'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                            builder: (context, StateSetter setState) {
                          return AlertDialog(
                            title: const Text("Add Products"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Products List"),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FutureBuilder(
                                        future: _future,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<GarmentsApp> sn) {
                                          if (sn.hasData) {
                                            return DropdownButton<Products>(
                                              items: sn.data!.products
                                                  .map((products) {
                                                return DropdownMenuItem<
                                                    Products>(
                                                  value: products,
                                                  child: Text(products
                                                      .productModelNo
                                                      .toString()),
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
                                                child:
                                                    Text("Error Loading Data"));
                                          }
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: TextField(
                                    controller: productionDate,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Production Date',
                                    ),
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime
                                                  .now(), //get today's date
                                              firstDate: DateTime(
                                                  2000), //DateTime.now() - not to allow to choose before today.
                                              lastDate: DateTime(2101));

                                      if (pickedDate != null) {
                                        String formattedDate =
                                            DateFormat('dd-MM-yyyy').format(
                                                pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                        setState(() {
                                          productionDate.text =
                                              formattedDate; //set foratted date to TextField value.
                                        });
                                      } else {}
                                    },
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: TextField(
                                    controller: productSize,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Size',
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: TextField(
                                    controller: productQuantity,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Quantity',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: const Text("Add"),
                                onPressed: () {
                                  if (_selected!.productModelNo.isEmpty ||
                                      productionDate.text.isEmpty ||
                                      productSize.text.isEmpty ||
                                      productQuantity.text.isEmpty) {
                                  } else {
                                    addProduct(
                                        _selected!.productModelNo.toString(),
                                        productionDate.text,
                                        productSize.text,
                                        productQuantity.text);
                                    productionDate.text = "";
                                    productSize.text = "";
                                    productQuantity.text = "";
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                              ElevatedButton(
                                child: const Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder(
                future: getProductsList(),
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
                                builder: (context) => ProductsViewPage(
                                    productModelNo: unis[index]
                                        ["productModelNo"])),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${unis[index]["productModelNo"]}"),
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
