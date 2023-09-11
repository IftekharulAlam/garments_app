import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garments_app/view/products/product_view.dart';
import 'package:http/http.dart' as http;

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  String dropdownvalue = 'Owner';

  var items = ['Owner', 'Manager', 'Staff', 'Designer'];
  TextEditingController productModelNo = TextEditingController();
  TextEditingController productDetails = TextEditingController();
  TextEditingController productRate = TextEditingController();
  TextEditingController productQuantity = TextEditingController();
  TextEditingController name = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> itemStrings = [
    'Products',
  ];
  List<Widget> itemWidgets = [
    const ProductsViewPage(),
  ];
  var list = [];

  bool isChecked = false;
  bool isCheckedSizeXL = false;
  bool isCheckedSizeXXL = false;
  bool isCheckedSizeM = false;
  bool isCheckedSizeS = false;
  Future createProduct(String productModelNo, String productDetails,
      String productRate, String productSize) async {
    String finalUrl = "http://192.168.0.100:8000/createProduct";
    var url = Uri.parse(finalUrl);
    http.Response response = await http.post(url, body: {
      "productModelNo": productModelNo,
      "productDetails": productDetails,
      "productRate": productRate,
      "productSize": productSize
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
      // body: {"userType": userType, "userPhone": userPhone}
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      throw Exception("Error loading data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text("BM Garments")),
      drawer: Drawer(
        child: ListView(
          children: const [
            Column(
              children: [
                // DrawerHeader(
                //    child: Image.memory(base64.decode(widget.UserIamge))),
                ListTile(
                  // title: Center(child: Text(widget.Username)),
                  title: Center(child: Text("Profile")),
                ),
                ListTile(
                  title:
                      // Center(child: Text(" Address : ${widget.UserAddress}")),
                      Center(child: Text("Daily Sheet")),
                ),
                ListTile(
                  title: Center(child: Text("Khatiayn")),
                  // title: Center(child: Text(" Phone : ${widget.UserPhone}")),
                ),
              ],
            ),
          ],
        ),
      ),
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
                                Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 0, 0),
                                        child: const Text("XL")),
                                    StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setState) {
                                      return Center(
                                        child: Checkbox(
                                          checkColor: Colors.white,
                                          value: isCheckedSizeXL,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isCheckedSizeXL = value!;
                                            });
                                          },
                                        ),
                                      );
                                    }),
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: const Text("XXL")),
                                    StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setState) {
                                      return Center(
                                        child: Checkbox(
                                          checkColor: Colors.white,
                                          value: isCheckedSizeXXL,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isCheckedSizeXXL = value!;
                                            });
                                          },
                                        ),
                                      );
                                    }),
                                    Container(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: const Text("M"),
                                    ),
                                    StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setState) {
                                      return Center(
                                        child: Checkbox(
                                          checkColor: Colors.white,
                                          value: isCheckedSizeM,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isCheckedSizeM = value!;
                                            });
                                          },
                                        ),
                                      );
                                    }),
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: const Text("S")),
                                    StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setState) {
                                      return Center(
                                        child: Checkbox(
                                          checkColor: Colors.white,
                                          value: isCheckedSizeS,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isCheckedSizeS = value!;
                                            });
                                          },
                                        ),
                                      );
                                    }),
                                  ],
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
                                        productRate.text.isEmpty) {
                                    } else {
                                      if (isCheckedSizeXL == true) {
                                        list.add("XL");
                                      }
                                      if (isCheckedSizeXXL == true) {
                                        list.add("XXL");
                                      }
                                      if (isCheckedSizeM == true) {
                                        list.add("M");
                                      }
                                      if (isCheckedSizeS == true) {
                                        list.add("S");
                                      }

                                      createProduct(
                                          productModelNo.text,
                                          productDetails.text,
                                          productRate.text,
                                          list.join(","));
                                      productModelNo.text = "";
                                      productDetails.text = "";
                                      productRate.text = "";
                                      isCheckedSizeXL = false;
                                      isCheckedSizeXXL = false;
                                      isCheckedSizeM = false;
                                      isCheckedSizeS = false;
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
                                    child: DropdownButton(
                                      underline: Container(),
                                      style: const TextStyle(
                                          //te
                                          color: Colors.black, //Font color
                                          fontSize:
                                              18 //font size on dropdown button
                                          ),
                                      value: dropdownvalue,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                            value: items, child: Text(items));
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
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: TextField(
                                  controller: name,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Production Date',
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: TextField(
                                  controller: name,
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
                                Navigator.of(context).pop();
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
                      },
                    );
                  },
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Update Products"),
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
                                    child: DropdownButton(
                                      underline: Container(),
                                      style: const TextStyle(
                                          //te
                                          color: Colors.black, //Font color
                                          fontSize:
                                              18 //font size on dropdown button
                                          ),
                                      value: dropdownvalue,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                            value: items, child: Text(items));
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
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: TextField(
                                  controller: name,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Rate',
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: TextField(
                                  controller: name,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Size',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text("Update"),
                              onPressed: () {
                                Navigator.of(context).pop();
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
                        onTap: () {},
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
