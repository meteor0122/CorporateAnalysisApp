import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GraphView extends StatelessWidget {
  final List<charts.Series> seriesList;

  GraphView(this.seriesList);

  /// Creates a [ScatterPlotChart] with sample data and no transition.
  factory GraphView.withSampleData() {
    return new GraphView(
        _createSampleData()
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 150.0),
        child: charts.ScatterPlotChart(seriesList),
      ),
    );
  }

  static List<charts.Series<LinearSales, int>> _createSampleData() {
      final data = [
        new LinearSales(0, 5, 3, 'test1'),
        new LinearSales(-10, 25, 5, 'test2'),
        new LinearSales(-12, 75, 4, 'test3'),
        new LinearSales(13, -225, 0, 'test4'),
        new LinearSales(16, 50, 4, 'test5'),
        new LinearSales(24, 75, 3, 'test6'),
        new LinearSales(25, 100, 3, 'test7'),
        new LinearSales(34, -150, 2, 'test8'),
        new LinearSales(37, 10, 1, 'test9'),
        new LinearSales(-45, -300, 8, 'test10'),
        new LinearSales(52, 15, 4, 'test11'),
        new LinearSales(-56, 200, 7, 'test12'),
      ];

    final maxMeasure = 300;
    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        // Providing a color function is optional.
        colorFn: (LinearSales sales, _) {
          // Bucket the measure column value into 3 distinct colors.
          final bucket = sales.size;

          if (bucket < 3) {
            return charts.MaterialPalette.blue.shadeDefault;
          } else if (bucket < 6) {
            return charts.MaterialPalette.red.shadeDefault;
          } else {
            return charts.MaterialPalette.green.shadeDefault;
          }
        },
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        labelAccessorFn: (LinearSales sales, _) => sales.label,
        data: data,
      )
    ];
  }
}


/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;
  final int size;
  final String label;

  LinearSales(this.year, this.sales, this.size, this.label);
}

