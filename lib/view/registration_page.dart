import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String dropdownvalue = 'Owner';
  var items = ['Owner', 'Manager', 'Staff', 'Designer'];
  static const String _title = 'BM Garments';
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController nid = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fathersName = TextEditingController();
  TextEditingController mothersName = TextEditingController();
  TextEditingController salary = TextEditingController();
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
        .post(Uri.parse("http://192.168.0.100:8000/registerUser"), body: {
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
                'User Registration',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nid,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'NID',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: address,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                obscureText: true,
                controller: password,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: fathersName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Fathers Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: mothersName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mothers Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: salary,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Salary',
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: DropdownButton(
                  underline: Container(),
                  style: const TextStyle(
                      //te
                      color: Colors.black, //Font color
                      fontSize: 18 //font size on dropdown button
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
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Register'),
                onPressed: () {
                  register(
                      name.text,
                      address.text,
                      phone.text,
                      nid.text,
                      password.text,
                      fathersName.text,
                      mothersName.text,
                      salary.text,
                      dropdownvalue);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Already have account?'),
                TextButton(
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //login screen
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
