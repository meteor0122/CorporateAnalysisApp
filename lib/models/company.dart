import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Company with ChangeNotifier {
  String id;
  String companyName;
  int currentSales;
  int previousSales;

  Company({
    this.id,
    @required this.companyName,
    @required this.currentSales,
    @required this.previousSales
  });

  Company.newCompany() {
    companyName = "";
    currentSales = 0;
    previousSales = 0;
  }

  assignUUID() {
    id = Uuid().v4();
  }

  factory Company.fromMap(Map<String, dynamic> json) => Company(
      id: json["id"],
      companyName: json["companyName"],
      currentSales: json["currentSales"],
      previousSales: json["previousSales"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "companyName": companyName,
    "currentSales": currentSales,
    "previousSales": previousSales,
  };

}