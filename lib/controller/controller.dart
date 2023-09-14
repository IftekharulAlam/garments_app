import 'dart:convert';

import 'package:garments_app/model/model.dart';
import 'package:http/http.dart' as http;

Future<GarmentsApp> getProductsListmy() async {
  http.Response response = await http.get(
    Uri.parse("http://192.168.0.100:8000/getProductsList"),
  );

  if (response.statusCode == 200) {
    return GarmentsApp.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Error loading data");
  }
}
