import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fuel_app/main.dart';
import 'package:fuel_app/model/fuel_price.dart';
import 'package:fuel_app/rest_client/fuel_price_client.dart';
import 'package:fuel_app/ui/theme/global.dart';
import 'package:intl/intl.dart';

import 'home_admin.dart';

class FuelPriceFormView extends StatefulWidget {
  @override
  _FuelPriceFormViewState createState() => _FuelPriceFormViewState();
}

class _FuelPriceFormViewState extends State<FuelPriceFormView> {
  final format = DateFormat("yyyy-MM-dd");
  final _formKey = GlobalKey<FormState>();

  int dateFrom;
  int dateUntil;
  double ron95;
  double ron97;
  double diesel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Global.mediumBlue,
        title: Text('Fuel Price Form'),
      ),
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DateTimeField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.date_range),
                      labelText: 'From',
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                        context: context,
                        firstDate: DateTime(2019),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please Enter From Date';
                      } else {
                        setState(() {
                          this.dateFrom = value.millisecondsSinceEpoch;
                        });
                        return null;
                      }
                    },
                  ),
                  DateTimeField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.date_range),
                      labelText: 'Until',
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                        context: context,
                        firstDate: DateTime(2019),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please Enter Until Date';
                      } else {
                        setState(() {
                          this.dateUntil = value.millisecondsSinceEpoch;
                        });
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.monetization_on),
                      labelText: 'Ron 95 Price',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Ron 95 Price';
                      } else {
                        setState(() {
                          this.ron95 = double.parse(value);
                        });
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.monetization_on),
                      labelText: 'Ron 97 Price',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Ron 97 Price';
                      } else {
                        setState(() {
                          this.ron97 = double.parse(value);
                        });
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.monetization_on),
                      labelText: 'Diesel Price',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Diesel Price';
                      } else {
                        setState(() {
                          this.diesel = double.parse(value);
                        });
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Center(
                      child: ElevatedButton(
                        child: Text('Submit'),
                        onPressed: () async {
                          if(_formKey.currentState.validate()) {
                            var requestBody = FuelPrice(
                              dateFrom: this.dateFrom,
                              dateUntil: this.dateUntil,
                              ron95: this.ron95,
                              ron97: this.ron97,
                              diesel: this.diesel,
                            ).toJson();

                            await createFuelPrice(jsonEncode(requestBody));

                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Submitted'))
                            );

                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => HomeAdminView()
                                )
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }
}