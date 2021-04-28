import 'package:flutter/material.dart';
import 'package:fuel_app/rest_client/fuel_price_client.dart';
import 'package:intl/intl.dart';

class FuelPriceDisplayScreen extends StatefulWidget {
  @override
  _FuelPriceDisplayScreenState createState() => _FuelPriceDisplayScreenState();
}

class _FuelPriceDisplayScreenState extends State<FuelPriceDisplayScreen> {
  final dateFormat = DateFormat("dd-MM-yyyy");
  DateTime currentDate = DateTime.now();
  String ron95 = '-';
  String ron97 = '-';
  String diesel = '-';

  @override
  void initState() {
    super.initState();
    asyncFuelPrice();
  }

  void asyncFuelPrice() {
    fetchFuelPriceByDate(currentDate.millisecondsSinceEpoch).then((value) {
      setState(() {
        ron95 = value.isNotEmpty ? value.first.ron95.toStringAsFixed(2) : '-';
        ron97 = value.isNotEmpty ? value.first.ron97.toStringAsFixed(2) : '-';
        diesel = value.isNotEmpty ? value.first.diesel.toStringAsFixed(2) : '-';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: _buildDatePicker(),
        ),
        Flexible(
            child: Card(
                color: Colors.yellow,
                child: ListTile(
                  title: Text('Price of RON95/litre'),
                  subtitle: Text('RM $ron95'),
                )
            )
        ),
        Flexible(
            child: Card(
                color: Colors.green,
                child: ListTile(
                  title: Text('Price of RON97/litre'),
                  subtitle: Text('RM $ron97'),
                )
            )
        ),
        Flexible(
            child: Card(
                color: Colors.black45,
                child: ListTile(
                  title: Text('Price of DIESEL/litre'),
                  subtitle: Text('RM $diesel'),
                )
            )
        ),
      ],
    );
  }

  Widget _buildListTitle(String title, String subtitle) {
    return Flexible(
        child: Card(
            child: ListTile(
              title: Text(title),
              subtitle: Text(subtitle),
            )
        )
    );
  }

  _buildDatePicker() {
    return TextButton.icon(
      icon: Icon(Icons.calendar_today),
      onPressed: () async {
        final DateTime pickedDate = await showDatePicker(
            context: context,
            firstDate: DateTime(2019),
            initialDate: currentDate,
            lastDate: DateTime(2100)
        );
        if (pickedDate != null && pickedDate != currentDate) {
          setState(() {
            currentDate = pickedDate;
            asyncFuelPrice();
          });
        }
      },
      label: Text(
          dateFormat.format(currentDate)
      ),
    );
  }
}
