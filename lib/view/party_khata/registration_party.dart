import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

class RegistrationPageParty extends StatefulWidget {
  const RegistrationPageParty({super.key});

  @override
  State<RegistrationPageParty> createState() => _RegistrationPagePartyState();
}

class _RegistrationPagePartyState extends State<RegistrationPageParty> {
  static const String _title = 'BM Garments';

  TextEditingController ownerName = TextEditingController();
  TextEditingController shopName = TextEditingController();
  TextEditingController ownerPhone = TextEditingController();
  TextEditingController ownerAddress = TextEditingController();
  TextEditingController shopAddress = TextEditingController();
  TextEditingController shopPhone = TextEditingController();

  Future createParty(
    String ownerName,
    String shopName,
    String ownerPhone,
    String ownerAddress,
    String shopAddress,
    String shopPhone,
  ) async {
    http.Response response = await http
        .post(Uri.parse("http://192.168.0.100:8000/createParty"), body: {
      "ownerName": ownerName,
      "shopName": shopName,
      "ownerPhone": ownerPhone,
      "ownerAddress": ownerAddress,
      "shopAddress": shopAddress,
      "shopPhone": shopPhone
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'BM Garments',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Party Registration',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: shopName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Shop Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: ownerName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Owner Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: ownerPhone,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Owner Phone',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: ownerAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Owner Address',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: shopAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Shop Address',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: shopPhone,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Shop Phone',
                ),
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Create Party'),
                onPressed: () {
                  if (ownerName.text.isEmpty ||
                      shopName.text.isEmpty ||
                      ownerPhone.text.isEmpty ||
                      ownerAddress.text.isEmpty ||
                      shopAddress.text.isEmpty ||
                      shopPhone.text.isEmpty) {
                  } else {
                    createParty(
                      ownerName.text,
                      shopName.text,
                      ownerPhone.text,
                      ownerAddress.text,
                      shopAddress.text,
                      shopPhone.text,
                    );
                    ownerName.text = '';
                    shopName.text = '';
                    ownerPhone.text = '';
                    ownerAddress.text = '';
                    shopAddress.text = '';
                    shopPhone.text = '';
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}