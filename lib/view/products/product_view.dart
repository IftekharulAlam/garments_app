// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garments_app/controller/garmentsApp.dart';

import 'package:http/http.dart' as http;

class ProductsViewPage extends StatefulWidget {
  String productModelNo;
  ProductsViewPage({super.key, required this.productModelNo});

  @override
  State<ProductsViewPage> createState() => _ProductsViewPageState();
}

Future getProductProductionDetails(String productModelNo) async {
  String finalUrl = "http://$mydeviceIP:8000/getProductProductionDetails";
  var url = Uri.parse(finalUrl);
  http.Response response = await http.post(url, body: {
    "productModelNo": productModelNo,
  });

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Error loading data");
  }
}

Future getProductDetails(String productModelNo) async {
  String finalUrl = "http://$mydeviceIP:8000/getProductDetails";
  var url = Uri.parse(finalUrl);
  http.Response response = await http.post(url, body: {
    "productModelNo": productModelNo,
  });

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Error loading data");
  }
}

class _ProductsViewPageState extends State<ProductsViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BM Garments")),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Product Details',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder(
                future: getProductDetails(widget.productModelNo),
                builder: (BuildContext context, AsyncSnapshot sn) {
                  if (sn.hasData) {
                    List unis = sn.data;
                    return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: unis.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          Card(
                            child: ListTile(
                              title: Text(
                                  "Product Model: ${unis[index]["productModelNo"]}"),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text(
                                  "Product Details: ${unis[index]["productDetails"]}"),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text(
                                  "Product Rate: ${unis[index]["productRate"]}"),
                            ),
                          ),
                        ],
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
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Production Date"),
                    Text("Size"),
                    Text("Quantity"),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: FutureBuilder(
                future: getProductProductionDetails(widget.productModelNo),
                builder: (BuildContext context, AsyncSnapshot sn) {
                  if (sn.hasData) {
                    List unis = sn.data;
                    return ListView.builder(
                      itemCount: unis.length,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${unis[index]["productionDate"]}"),
                              Text("${unis[index]["productSize"]}"),
                              Text("${unis[index]["productQuantity"]}"),
                            ],
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
