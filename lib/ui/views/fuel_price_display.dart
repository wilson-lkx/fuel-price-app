import 'package:flutter/material.dart';
import 'package:fuel_app/rest_client/fuel_price_client.dart';
import 'package:fuel_app/ui/theme/global.dart';
import 'package:intl/intl.dart';

class FuelPriceView extends StatefulWidget {
  @override
  _FuelPriceViewState createState() => _FuelPriceViewState();
}

class _FuelPriceViewState extends State<FuelPriceView> {
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
    var size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: _buildDatePicker(),
          ),
          SizedBox(
            width: 150,
            height: 80,
            child: Card(
                color: Colors.yellow,
                child: Center(
                  child: ListTile(
                    title: Text('RON95', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
                    subtitle: Text('RM $ron95', style: TextStyle(fontSize: 16, color: Colors.white), textAlign: TextAlign.center),
                  ),
                )
            ),
          ),
          SizedBox(
            width: 150,
            height: 80,
            child: Card(
                color: Colors.green,
                child: Center(
                  child: ListTile(
                    title: Text('RON97', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
                    subtitle: Text('RM $ron97', style: TextStyle(fontSize: 16, color: Colors.white), textAlign: TextAlign.center),
                  ),
                )
            ),
          ),
          SizedBox(
            width: 150,
            height: 80,
            child: Card(
                color: Colors.black,
                child: Center(
                  child: ListTile(
                    title: Text('DIESEL', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
                    subtitle: Text('RM $diesel', style: TextStyle(fontSize: 16, color: Colors.white), textAlign: TextAlign.center),
                  ),
                )
            ),
          ),
        ],
      ),
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
      icon: Icon(Icons.calendar_today_outlined, color: Global.mediumBlue),
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
        dateFormat.format(currentDate),
        style: TextStyle(
            color: Global.mediumBlue
        ),
      ),
    );
  }
}
