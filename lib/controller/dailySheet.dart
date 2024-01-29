import 'dart:convert';

import 'package:garments_app/controller/garmentsApp.dart';
import 'package:garments_app/model/dailySheet.dart';
import 'package:http/http.dart' as http;

Future<List> fetchDate(String date) async {
  String finalUrl = "http://$mydeviceIP:8000/getJomaDataList";
  var url = Uri.parse(finalUrl);
  http.Response response = await http.post(url, body: {
    "date": date,
  });

  if (response.statusCode == 200) {
    return DailySheetData.fromJson(jsonDecode(response.body)) as List;
  } else {
    throw Exception("Error loading data");
  }
}