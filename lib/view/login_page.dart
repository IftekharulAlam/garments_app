// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garments_app/view/home_page.dart';
import 'package:garments_app/view/registration_page.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String dropdownvalue = 'Owner';
  var items = ['Owner', 'Manager', 'Staff', 'Designer'];
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  Future login() async {
    String finalUrl = "http://192.168.0.100:8000/login";
    var url = Uri.parse(finalUrl);
    var response = await http.post(url, body: {
      "name": name.text,
      "password": password.text,
      "userType": dropdownvalue
    });

    var data = json.decode(response.body);

    if (data[0]["message"] == "Wrong") {
      Fluttertoast.showToast(
          msg: "Login Unsuccessful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Login successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => HomePage(
      //         Username: "${data[0]["name"]}",
      //         Usertype: dropdownvalue,
      //         UserAddress: "${data[0]["address"]}",
      //         UserIamge: "${data[0]["profilePic"]}",
      //         UserPhone: "${data[0]["phone"]}",
      //         UserWorkingHour: "${data[0]["workingHour"]}"),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'BM Garments',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
              controller: password,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'User Type:',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
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
            ],
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: const Text('Login'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: const Text('Register'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistrationPage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}