import 'dart:convert';

import 'package:garments_app/controller/garmentsApp.dart';
import 'package:garments_app/model/garmentsApp.dart';
import 'package:http/http.dart' as http;

Future<GarmentsApp> getPartyListtmy() async {
  http.Response response = await http.get(
    Uri.parse("http://$mydeviceIP:8000/getPartyList"),
  );

  if (response.statusCode == 200) {
    return GarmentsApp.partyPersonalFromJson(jsonDecode(response.body));
  } else {
    throw Exception("Error loading data");
  }
}