// ignore_for_file: sort_child_properties_last,, use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:garments_app/view/login_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'BM Garments';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Center(child: Text(_title))),
        body: const LoginPage(),
      ),
    );
  }
}
