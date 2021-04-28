import 'dart:convert';

import 'package:fuel_app/model/fuel_price.dart';
import 'package:http/http.dart' as http;

Future<List<FuelPrice>> fetchFuelPriceByDate(int date) async {
  var client = http.Client();
  var url = Uri.parse('http://202.186.60.201:8000/api/fuel-prices?date=$date');
  final response = await client.get(url);

  if (response.statusCode == 200) {
    return (json.decode(response.body) as List).map((i) => FuelPrice.fromJson(i)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

createFuelPrice(String json) async {
  print('$json');
  var client = http.Client();
  var url = Uri.parse('http://202.186.60.201:8000/api/fuel-prices');
  final response = await client.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json
  );
  if (response.statusCode != 201) {
    throw Exception('Failed to create data');
  }
}