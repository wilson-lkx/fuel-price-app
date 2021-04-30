import 'package:flutter/material.dart';
import 'package:fuel_app/ui/theme/global.dart';

import 'fuel_price_chart.dart';
import 'fuel_price_display.dart';

class HomeUserView extends StatefulWidget {
  final String username;

  HomeUserView({@required this.username});

  @override
  _HomeUserViewState createState() => _HomeUserViewState();
}

class _HomeUserViewState extends State<HomeUserView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Global.mediumBlue,
        title: Text('Welcome, ${widget.username}'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Global.mediumBlue,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Fuel Price',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Fuel Price Chart',
          )
        ],
      ),
      body: _getBody(),
    );
  }

  _getBody() {
    switch(_currentIndex) {
      case 0 : return FuelPriceView();
      case 1 : return FuelPriceChartView();
    }
  }
}
