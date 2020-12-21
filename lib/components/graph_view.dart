import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/company.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/repositories/company_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<CompanyBloc>(context, listen: false);
    return Scaffold(
      body: StreamBuilder<List<Company>>(
        stream: _bloc.companyStream,
        builder: (BuildContext context, AsyncSnapshot<List<Company>> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
                child: Column (
                  children: <Widget>[
                    welFareChart(context, snapshot.data),
                    SizedBox(height: 50),
                    futureChart(context, snapshot.data),
                    SizedBox(height: 50),
                    stabilityChart(context, snapshot.data),
                  ]
                ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class Future {
  final double increasedYield;
  final double profitGrowthRate;
  final double ordinaryRate;
  final String label;
  final Color color;

  Future(this.increasedYield, this.profitGrowthRate, this.ordinaryRate, this.label, this.color);
}

class Welfare {
  final int overTime;
  final int paidDay;
  final String label;
  final Color color;

  Welfare(this.overTime, this.paidDay, this.label, this.color);
}

class Stability {
  final double capitalAdequacyRatio;
  final double currentAssetRatio;
  final Color color;
  final String label;

  Stability(this.capitalAdequacyRatio, this.currentAssetRatio, this.color, this.label);
}

Widget futureChart(BuildContext context, List<Company> company) => SfCartesianChart(
  title: ChartTitle(
    text: '将来性',
  ),
  primaryYAxis: NumericAxis(
    title: AxisTitle(
        text: '増収率'
    ),
    //maximum: increasedYieldMax(company),
  ),
  primaryXAxis: NumericAxis(
    title: AxisTitle(
        text: '増益率'
    ),
    //maximum: profitGrowthRate(company),
  ),
  tooltipBehavior: TooltipBehavior(
    enable: true,
    format: '増収率 : point.y\r\n増益率 : point.x',
  ),
  series: <ScatterSeries>[
    ScatterSeries<Future, double>(
      dataSource: createFutureData(company),
      xValueMapper: (Future welfare, _) => welfare.increasedYield,
      yValueMapper: (Future welfare, _) => welfare.profitGrowthRate,
      pointColorMapper: (Future welfare, _) => welfare.color,
      dataLabelMapper: (Future welfare, _) => welfare.label,
      dataLabelSettings: DataLabelSettings(
          isVisible: true
      ),
    ),
  ],
);

Widget welFareChart(BuildContext context, List<Company> company) => SfCartesianChart(
  title: ChartTitle(
    text: '福利厚生',
  ),
  primaryYAxis: NumericAxis(
    title: AxisTitle(
        text: '残業時間'
    ),
    minimum: 0,
    maximum: overTimeMax(company).toDouble(),
  ),
  primaryXAxis: NumericAxis(
    title: AxisTitle(
        text: '有給取得'
    ),
    minimum: 0,
    maximum: paidDayMax(company).toDouble(),
  ),
  tooltipBehavior: TooltipBehavior(
    enable: true,
    format: '残業時間 : point.y\r\n有給取得 : point.x',
  ),
  series: <ScatterSeries>[
    ScatterSeries<Welfare, int>(
      dataSource: createWelfareData(company),
      xValueMapper: (Welfare welfare, _) => welfare.paidDay,
      yValueMapper: (Welfare welfare, _) => welfare.overTime,
      pointColorMapper: (Welfare welfare, _) => welfare.color,
      dataLabelMapper: (Welfare welfare, _) => welfare.label,
      dataLabelSettings: DataLabelSettings(
          isVisible: true
      ),
    ),
  ],
);

Widget stabilityChart(BuildContext context, List<Company> company) => SfCartesianChart(
  title: ChartTitle(
    text: '安定性',
  ),
  primaryYAxis: NumericAxis(
    title: AxisTitle(
        text: '自己資本比率'
    ),
    minimum: 0,
    maximum: overTimeMax(company).toDouble(),
  ),
  primaryXAxis: NumericAxis(
    title: AxisTitle(
        text: '流動資産比率'
    ),
    minimum: 0,
    maximum: paidDayMax(company).toDouble(),
  ),
  tooltipBehavior: TooltipBehavior(
    enable: true,
    format: '自己資本比率 : point.y\r\n流動資産比率 : point.x',
  ),
  series: <ScatterSeries>[
    ScatterSeries<Stability, double>(
      dataSource: createStabilityData(company),
      xValueMapper: (Stability stability, _) => stability.capitalAdequacyRatio,
      yValueMapper: (Stability stability, _) => stability.currentAssetRatio,
      pointColorMapper: (Stability stability, _) => stability.color,
      dataLabelMapper: (Stability stability, _) => stability.label,
      dataLabelSettings: DataLabelSettings(
          isVisible: true
      ),
    ),
  ],
);

double increasedYieldMax(List<Company> company) {
  const double margin = 10.0;
  double increasedYield = 0.0;
  List<double> list = List<double>();

  for (int i = 0; i < company.length; i++) {
    increasedYield = (company[i].currentSales - company[i].previousSales) / company[i].previousSales * 100;
    list.add(increasedYield);
  }

  return list.reduce(max) + margin;
}

double profitGrowthRate(List<Company> company) {
  const double margin = 10.0;
  double profitGrowthRate = 0.0;
  List<double> list = List<double>();

  for (int i = 0; i < company.length; i++) {
    profitGrowthRate = ((company[i].currentOrdinaryIncome / company[i].previousOrdinaryIncome) - 1) * 100;
    list.add(profitGrowthRate);
  }

  return list.reduce(max) + margin;
}

int paidDayMax(List<Company> company) {
  const int margin = 10;
  List<int> list = List<int>();

  for (int i = 0; i < company.length; i++) {
    list.add(company[i].paidDay);
  }

  return list.reduce(max) + margin;
}

int overTimeMax(List<Company> company) {
  const int margin = 10;
  List<int> list = List<int>();

  for (int i = 0; i < company.length; i++) {
    list.add(company[i].overTime);
  }

  return list.reduce(max) + margin;
}

List<Future> createFutureData(List<Company> company) {
  List<Future> data = List<Future>();
  double increasedYield = 0.00;
  double profitGrowthRate = 0.00;
  double ordinaryRate = 0.00;
  Color color;

  for (int i = 0; i < company.length; i++) {
    increasedYield = (company[i].currentSales - company[i].previousSales) / company[i].previousSales * 100;
    profitGrowthRate = ((company[i].currentOrdinaryIncome / company[i].previousOrdinaryIncome) - 1) * 100;
    ordinaryRate = (company[i].currentOrdinaryIncome / company[i].currentSales) * 100;

    if (ordinaryRate < 0) {
      color = Colors.purple;
    } else if (ordinaryRate < 5) {
      color = Colors.blue;
    } else if (ordinaryRate < 10) {
      color = Colors.green;
    } else if (ordinaryRate < 15) {
      color = Colors.orange;
    } else {
      color = Colors.pink;
    }

    data.add(Future(increasedYield, profitGrowthRate, ordinaryRate, company[i].companyName, color));
  }
  return data;
}

List<Welfare> createWelfareData(List<Company> company) {
  List<Welfare> data = List<Welfare>();
  int overTime;
  int paidDay;
  int averageIncome;
  Color color;

  for (int i = 0; i < company.length; i++) {
    overTime = company[i].overTime;
    paidDay = company[i].paidDay;
    averageIncome = company[i].averageIncome;
    if (averageIncome < 700) {
      color = Colors.lightBlue;
    } else if (averageIncome < 800) {
      color = Colors.green;
    } else if (averageIncome < 900) {
      color = Colors.orangeAccent;
    } else if (averageIncome < 1000) {
      color = Colors.redAccent;
    } else {
      color = Colors.pink;
    }
    data.add(Welfare(overTime, paidDay, company[i].companyName, color));
  }
  return data;
}

List<Stability> createStabilityData(List<Company> company) {
  List<Stability> data = List<Stability>();
  double capitalAdequacyRatio;
  double currentAssetRatio;
  double fixedRatio;
  Color color;

  for (int i = 0; i < company.length; i++) {
    capitalAdequacyRatio = company[i].nonCurrentAssets / company[i].netWorth * 100;
    currentAssetRatio = company[i].netWorth / (company[i].otherCapital + company[i].netWorth) * 100;
    fixedRatio = company[i].currentAssets / company[i].currentsLiabilities * 100;
    if (fixedRatio < 60) {
      color = Colors.lightBlue;
    } else if (fixedRatio < 70) {
      color = Colors.green;
    } else if (fixedRatio < 80) {
      color = Colors.orangeAccent;
    } else if (fixedRatio < 90) {
      color = Colors.redAccent;
    } else {
      color = Colors.pink;
    }
    data.add(Stability(capitalAdequacyRatio, currentAssetRatio, color, company[i].companyName));
  }
  return data;
}
