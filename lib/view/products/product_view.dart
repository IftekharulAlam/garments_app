// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garments_app/controller/garmentsApp.dart';
import 'package:garments_app/model/products.dart';

import 'package:http/http.dart' as http;

class ProductsViewPage extends StatefulWidget {
  String productModelNo;
  ProductsViewPage({super.key, required this.productModelNo});

  @override
  State<ProductsViewPage> createState() => _ProductsViewPageState();
}

Future<List<ProductProductionData>> getProductProductionDetails(String productModelNo) async {
  String finalUrl = "http://$mydeviceIP:8000/getProductProductionDetails";
  var url = Uri.parse(finalUrl);
  http.Response response = await http.post(url, body: {
    "productModelNo": productModelNo,
  });

  if (response.statusCode == 200) {
     List result = jsonDecode(response.body);
      List<ProductProductionData> mydata =
          result.map((e) => ProductProductionData.fromJson(e)).toList();

      return mydata;
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
         
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: FutureBuilder<List<ProductProductionData>>(
                future: getProductProductionDetails(widget.productModelNo),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ProductProductionData>> sn) {
                  if (sn.hasData) {
                    return Container(
                      padding: const EdgeInsets.all(5),
                      child: DataClass(datalist: sn.data as List<ProductProductionData>),
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

class DataClass extends StatelessWidget {
  final List<ProductProductionData> datalist;
  const DataClass({super.key, required this.datalist});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: FittedBox(
        child: DataTable(
            sortColumnIndex: 1,
            showCheckboxColumn: false,
            border: TableBorder.all(width: 1.0),
            columns: const [
              DataColumn(
                label: Text(
                  "Date",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  "Size",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  "Quantity",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: datalist
                .map((data) => DataRow(cells: [
                      DataCell(
                        Text(
                          data.productionDate,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ),
                      DataCell(
                        Text(
                          data.productSize,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ),
                      DataCell(
                        Text(
                          '${data.productQuantity}',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ]))
                .toList()),
      ),
    );
  }
}
