import 'dart:convert';

import 'package:garments_app/model/model.dart';
import 'package:http/http.dart' as http;

String mydeviceIP = "192.168.0.100";
Future<GarmentsApp> getProductsListmy() async {
  http.Response response = await http.get(
    Uri.parse("http://$mydeviceIP:8000/getProductsList"),
  );

  if (response.statusCode == 200) {
    return GarmentsApp.productsFromJson(jsonDecode(response.body));
  } else {
    throw Exception("Error loading data");
  }
}

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

Future<GarmentsApp> getKhatiyanListmy() async {
  http.Response response = await http.get(
    Uri.parse("http://$mydeviceIP:8000/getKhatiyanList"),
  );

  if (response.statusCode == 200) {
    return GarmentsApp.khatiyanListFromJson(jsonDecode(response.body));
  } else {
    throw Exception("Error loading data");
  }
}

Future<GarmentsApp> getStaffKhatiyanListmy() async {
  http.Response response = await http.get(
    Uri.parse("http://$mydeviceIP:8000/getStaffKhatiyanList"),
  );

  if (response.statusCode == 200) {
    return GarmentsApp.StaffListFromJson(jsonDecode(response.body));
  } else {
    throw Exception("Error loading data");
  }
}

Future<DailySheetJoma> fetchDate() async {
  http.Response response = await http.get(
    Uri.parse("http://$mydeviceIP:8000/getStaffKhatiyanList"),
  );

  if (response.statusCode == 200) {
    return DailySheetJoma.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Error loading data");
  }
}
