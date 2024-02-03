// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:garments_app/model/khatiyan.dart';
import 'package:garments_app/model/products.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlService {
  List<String> myquery = [
    'CREATE TABLE product_table(productModelNo text NOT NULL,productDetails text NOT NULL,productRate int(11) NOT NULL);',
    'CREATE TABLE khatiyan_full(serial INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,date text NOT NULL,khatiyanName text NOT NULL,details text NOT NULL,joma int(11) NOT NULL,khoroch int(11) NOT NULL,balance int(11) NOT NULL,type text NOT NULL)'
  ];
  var database;
  // A method that retrieves all the dogs from the dogs table.
  Future<List<Products>> getProductsList() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('product_table');

    return List.generate(maps.length, (i) {
      return Products(
        productModelNo: maps[i]['productModelNo'],
        productDetails: maps[i]['productDetails'] as String,
        productRate: maps[i]['productRate'] as int,
      );
    });
  }

  Future<List<Khatiyan>> getKhatiyanList() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('khatiyan_full');

    return List.generate(maps.length, (i) {
      return Khatiyan(
        khatiyanName: maps[i]['khatiyanName'],
        date: maps[i]['date'],
        details: maps[i]['details'] as String,
        joma: maps[i]['joma'] as int,
        khoroch: maps[i]['khoroch'] as int,
        balance: maps[i]['balance'] as int,
        type: maps[i]['type'] as String,
      );
    });
  }

  Future<void> insertProduct(Products products) async {
    final Database db = await initializeDB();

    await db.insert('product_table', products.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertKhatiyan(Khatiyan khatiyan) async {
    final Database db = await initializeDB();

    await db.insert('khatiyan_full', khatiyan.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Database> initializeDB() async {
    WidgetsFlutterBinding.ensureInitialized();

    return openDatabase(
      join(await getDatabasesPath(), 'garments.db'),
      onCreate: (db, version) {
        for (int i = 0; i < myquery.length; i++) {
          db.execute(myquery[i]);
        }
      },
      version: 1,
    );
  }
}
