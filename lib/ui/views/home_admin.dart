import 'package:flutter/material.dart';
import 'package:fuel_app/ui/theme/global.dart';

import 'fuel_price_form.dart';

class HomeAdminView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Global.mediumBlue,
        title: Text('Administrator'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FuelPriceFormView()
              ),
            );
          },
          child: Text('Add New Fuel Price'),
        ),
      ),
    );
  }
}
