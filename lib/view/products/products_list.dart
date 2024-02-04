// ignore_for_file: unused_field

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garments_app/controller/garmentsApp.dart';
import 'package:garments_app/controller/products.dart';

import 'package:garments_app/model/garmentsApp.dart';
import 'package:garments_app/model/products.dart';
import 'package:garments_app/model/sql_service.dart';

//import 'package:garments_app/view/products/product_view.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  Future<GarmentsApp>? _future;
  Products? _selected;
  late final SqlService mysqlService = SqlService();
  TextEditingController productModelNo = TextEditingController();
  TextEditingController productDetails = TextEditingController();
  TextEditingController productRate = TextEditingController();
  TextEditingController productQuantity = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController productSize = TextEditingController();
  TextEditingController productionDate = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _picker = ImagePicker();
  String filepath = "";
  File? _image;
  var list = [];
  List unismy = [];
  Future<void> _openImagePicker() async {
    try {
      var pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
          filepath = pickedImage.path;
        });
        // uploadImage(pickedImage.path);
      }
    } catch (e) {
      //print(e);
    }
  }

  Future createProduct(String productModelNo, String productDetails,
      String productRate, filepath) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse("http://$mydeviceIP:8000/createProduct"));

      request.fields.addAll({
        'productModelNo': productModelNo,
        'productDetails': productDetails,
        'productRate': productRate,
      });
      request.files.add(await http.MultipartFile.fromPath('image', filepath));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Added Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        //print(response.reasonPhrase);
      }
    } catch (e) {
      //  print(e);
    }
  }

  Future addProduct(String productModelNo, String productionDate,
      String productSize, String productQuantity, String productRate) async {
    String finalUrl = "http://$mydeviceIP:8000/addProduct";
    var url = Uri.parse(finalUrl);
    http.Response response = await http.post(url, body: {
      "productModelNo": productModelNo,
      "productionDate": productionDate,
      "productSize": productSize,
      "productQuantity": productQuantity,
      "productRate": productRate
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

  Future<List<Products>> getProductsList() async {
    http.Response response = await http.get(
      Uri.parse("http://$mydeviceIP:8000/getProductsList"),
    );
    if (response.statusCode == 200) {
      List result = jsonDecode(response.body);
      List<Products> mydata = result.map((e) => Products.fromJson(e)).toList();

      return mydata;
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
      appBar: AppBar(title: const Text("Products")),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Create Product'),
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
                                Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: ElevatedButton(
                                        child: const Text('Take Picture'),
                                        onPressed: () {
                                          // _openImagePicker();
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: ElevatedButton(
                                        child: const Text('Upload Picture'),
                                        onPressed: () {
                                          _openImagePicker();
                                        },
                                      ),
                                    ),
                                  ],
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
                                    keyboardType: TextInputType.number,
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
                                        filepath == "" ||
                                        productRate.text.isEmpty) {
                                    } else {
                                      // mysqlService.insertProduct(Products(
                                      //     productModelNo: productModelNo.text,
                                      //     productDetails: productDetails.text,
                                      //     productRate:
                                      //         int.parse(productRate.text)));
                                      createProduct(
                                          productModelNo.text,
                                          productDetails.text,
                                          productRate.text,
                                          filepath);
                                      productModelNo.text = "";
                                      productDetails.text = "";

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
                  child: const Text('Add Stock'),
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
                                    Fluttertoast.showToast(
                                        msg: "Production Data Cannot be Empty",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else {
                                    addProduct(
                                        _selected!.productModelNo.toString(),
                                        productionDate.text,
                                        productSize.text,
                                        productQuantity.text,
                                        _selected!.productRate.toString());
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
              child: FutureBuilder<List<Products>>(
                future: getProductsList(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Products>> sn) {
                  if (sn.hasData) {
                    List<Products> products = sn.data as List<Products>;
                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      itemCount: products.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => ProductsViewPage(
                          //           productModelNo:
                          //               products[index].productModelNo)),
                          // );
                        },
                        child: Card(
                          child: ListTile(
                            leading: GestureDetector(
                              child: FlutterLogo(size: 56.0),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                icon: const Icon(Icons.cancel_outlined)),
                                          ],
                                        ),
                                        content: const FlutterLogo(size: 200.0),
                                      );
                                    });
                              },
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(products[index].productModelNo),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit))
                              ],
                            ),
                            subtitle: Text(products[index].productDetails),
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
