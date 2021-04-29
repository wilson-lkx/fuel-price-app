import 'dart:convert';

import 'package:fuel_app/model/user.dart';
import 'package:http/http.dart' as http;

Future<User> login(String email, String password) async {
  var client = http.Client();
  var url = Uri.parse('http://202.186.60.201:8000/api/login?email=$email&password=$password');
  final response = await client.get(url);

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}