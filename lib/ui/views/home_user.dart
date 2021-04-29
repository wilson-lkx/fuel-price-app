import 'package:flutter/material.dart';

import 'fuel_price_chart.dart';
import 'fuel_price_display.dart';

class HomeUserView extends StatefulWidget {
  @override
  _HomeUserViewState createState() => _HomeUserViewState();
}

class _HomeUserViewState extends State<HomeUserView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome '),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.red.shade300,
        selectedItemColor: Colors.red.shade700,
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
