import 'package:flutter/material.dart';
import 'package:fuel_app/screens/fuel_price_display.dart';
import 'package:fuel_app/screens/fuel_price_form.dart';

void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     icon: Icon(Icons.menu),
        //     onPressed: () {  }
        // ),
        title: Text('Fuel Price'),
        // backgroundColor: Colors.red,
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FuelPriceDisplayScreen(),
            FuelPriceFormScreen(),
          ],
        ),
      ),
    );
  }
}
