import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Company with ChangeNotifier {
  String id;
  String companyName;
  int currentSales;
  int previousSales;
  int currentOrdinaryIncome;
  int previousOrdinaryIncome;
  int overTime;
  int paidDay;
  int averageIncome;
  int nonCurrentAssets;
  int netWorth;
  int otherCapital;
  int currentAssets;
  int currentsLiabilities;

  Company({
    this.id,
    @required this.companyName,
    @required this.currentSales,
    @required this.previousSales,
    this.currentOrdinaryIncome,
    this.previousOrdinaryIncome,
    this.overTime,
    this.paidDay,
    this.averageIncome,
    this.nonCurrentAssets,
    this.netWorth,
    this.otherCapital,
    this.currentAssets,
    this.currentsLiabilities,
  });

  Company.newCompany() {
    companyName = "";
    currentSales = 0;
    previousSales = 0;
    currentOrdinaryIncome = 0;
    previousOrdinaryIncome = 0;
    overTime = 0;
    paidDay = 0;
    averageIncome = 0;
    nonCurrentAssets = 0;
    netWorth = 0;
    otherCapital = 0;
    currentAssets = 0;
    currentsLiabilities = 0;
  }

  assignUUID() {
    id = Uuid().v4();
  }

  factory Company.fromMap(Map<String, dynamic> json) => Company(
    id: json["id"],
    companyName: json["companyName"],
    currentSales: json["currentSales"],
    previousSales: json["previousSales"],
    currentOrdinaryIncome: json["currentOrdinaryIncome"],
    previousOrdinaryIncome: json["previousOrdinaryIncome"],
    overTime: json["overTime"],
    paidDay: json["paidDay"],
    averageIncome: json["averageIncome"],
    nonCurrentAssets: json["currentOrdinaryIncome"],
    netWorth: json["previousOrdinaryIncome"],
    otherCapital: json["overTime"],
    currentAssets: json["paidDay"],
    currentsLiabilities: json["averageIncome"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "companyName": companyName,
    "currentSales": currentSales,
    "previousSales": previousSales,
    "currentOrdinaryIncome": currentOrdinaryIncome,
    "previousOrdinaryIncome": previousOrdinaryIncome,
    "overTime": overTime,
    "paidDay": paidDay,
    "averageIncome": averageIncome,
    "nonCurrentAssets": nonCurrentAssets,
    "netWorth": netWorth,
    "otherCapital": otherCapital,
    "currentAssets": currentAssets,
    "currentsLiabilities": currentsLiabilities,
  };

}