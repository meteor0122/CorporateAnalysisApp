import 'dart:io';
import 'package:flutter_app/models/company.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';


class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // DBがなかったら作る
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // import 'package:path/path.dart'; が必要
    String path = join(documentsDirectory.path, "CompanyDB.db");

    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    return await db.execute(
        "CREATE TABLE Company ("
            "id TEXT PRIMARY KEY,"
            "companyName TEXT,"
            "currentSales INTEGER,"
            "previousSales INTEGER,"
            "currentOrdinaryIncome INTEGER,"
            "previousOrdinaryIncome INTEGER,"
            "overTime INTEGER,"
            "paidDay INTEGER,"
            "averageIncome INTEGER,"
            "nonCurrentAssets INTEGER,"
            "netWorth INTEGER,"
            "otherCapital INTEGER,"
            "currentAssets INTEGER,"
            "currentsLiabilities INTEGER"
            ")"
    );
  }

  static final _tableName = "Company";

  createCompany(Company model) async {
    final db = await database;
    var res = await db.insert(_tableName, model.toMap());
    return res;
  }

  getAllCompany() async {
    final db = await database;
    var res = await db.query(_tableName);
    List<Company> list =
    res.isNotEmpty ? res.map((c) => Company.fromMap(c)).toList() : [];
    return list;
  }

  updateCompany(Company model) async {
    final db = await database;
    var res  = await db.update(
        _tableName,
        model.toMap(),
        where: "id = ?",
        whereArgs: [model.id]
    );
    return res;
  }

  deleteCompany(String id) async {
    final db = await database;
    var res = db.delete(
        _tableName,
        where: "id = ?",
        whereArgs: [id]
    );
    return res;
  }
}