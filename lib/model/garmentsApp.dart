import 'package:garments_app/model/dailySheet.dart';
import 'package:garments_app/model/khatiyan.dart';
import 'package:garments_app/model/party.dart';
import 'package:garments_app/model/products.dart';
import 'package:garments_app/model/staff.dart';

class GarmentsApp {
  late List<Products> products;
  late List<PartyPersonal> partyPersonal;
  late List<Khatiyan> khatiyanList;
  late List<Staff> staffList;
  late List<DailySheetData> dailySheetData;

  GarmentsApp.dailySheetDataFromJson(List json) {
    dailySheetData = [];

    for (var v in json) {
      dailySheetData.add(DailySheetData.fromJson(v));
    }
  }
  GarmentsApp.productsFromJson(List json) {
    products = [];

    for (var v in json) {
      products.add(Products.fromJson(v));
    }
  }
  GarmentsApp.partyPersonalFromJson(List json) {
    partyPersonal = [];

    for (var v in json) {
      partyPersonal.add(PartyPersonal.fromJson(v));
    }
  }
  GarmentsApp.khatiyanListFromJson(List json) {
    khatiyanList = [];

    for (var v in json) {
      khatiyanList.add(Khatiyan.fromJson(v));
    }
  }
  GarmentsApp.StaffListFromJson(List json) {
    staffList = [];

    for (var v in json) {
      staffList.add(Staff.fromJson(v));
    }
  }
}
