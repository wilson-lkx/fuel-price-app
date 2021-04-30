import 'dart:convert';

import 'package:fuel_app/model/role.dart';
import 'package:fuel_app/model/user_info.dart';
import 'package:http/http.dart' as http;

Future<UserInfo> getInfoByUserId(int userId) async {
  var client = http.Client();
  var url = Uri.parse('http://202.186.60.201:8000/api/user/info?userId=$userId');
  final response = await client.get(url);

  if (response.statusCode == 200) {
    return UserInfo.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}