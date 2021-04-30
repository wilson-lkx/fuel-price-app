import 'package:flutter/material.dart';
import 'package:fuel_app/model/fuel_price.dart';
import 'package:fuel_app/rest_client/fuel_price_client.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FuelPriceChartView extends StatefulWidget {
  @override
  _FuelPriceChartViewState createState() => _FuelPriceChartViewState();
}

class _FuelPriceChartViewState extends State<FuelPriceChartView> {
  List<_ChartData> chartData;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    List<FuelPrice> fuelPrices = await fetchAllFuelPrice();
    List<_ChartData> chartDataList = fuelPrices.map((e) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(e.dateFrom);
      return _ChartData(dateTime, e.ron95, e.ron97, e.diesel);
    }).toList();
    setState(() {
      chartData = chartDataList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Fuel Price From 2019 - now'),
      legend: Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat('dd-MM-yyyy'),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 2,
          majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          labelFormat: 'RM {value}',
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<LineSeries<_ChartData, DateTime>> _getDefaultLineSeries() {
    return <LineSeries<_ChartData, DateTime>>[
      LineSeries<_ChartData, DateTime>(
          color: Colors.yellow,
          animationDuration: 2500,
          dataSource: chartData,
          xValueMapper: (_ChartData prices, _) => prices.x,
          yValueMapper: (_ChartData prices, _) => prices.y1,
          width: 2,
          name: 'RON95',
          markerSettings: MarkerSettings(isVisible: false)
      ),
      LineSeries<_ChartData, DateTime>(
          color: Colors.green,
          animationDuration: 2500,
          dataSource: chartData,
          width: 2,
          name: 'RON97',
          xValueMapper: (_ChartData prices, _) => prices.x,
          yValueMapper: (_ChartData prices, _) => prices.y2,
          markerSettings: MarkerSettings(isVisible: false)
      ),
      LineSeries<_ChartData, DateTime>(
          color: Colors.black,
          animationDuration: 2500,
          dataSource: chartData,
          width: 2,
          name: 'DIESEL',
          xValueMapper: (_ChartData prices, _) => prices.x,
          yValueMapper: (_ChartData prices, _) => prices.y3,
          markerSettings: MarkerSettings(isVisible: false)
      ),
    ];
  }
}

class _ChartData {
  _ChartData(this.x, this.y1, this.y2, this.y3);
  final DateTime x;
  final double y1;
  final double y2;
  final double y3;
}