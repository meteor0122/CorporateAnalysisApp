import 'dart:async';
import 'package:flutter_app/models/company.dart';
import 'db_provider.dart';

class CompanyBloc {
  List<Company> _allCompanyList = [];
  List<Company> get allCompanyList => _allCompanyList;

  final _companyController = StreamController<List<Company>>.broadcast();
  Stream<List<Company>> get companyStream => _companyController.stream;

  getCompany() async {
    _companyController.sink.add(await DBProvider.db.getAllCompany());
  }

  // void getCompany() async {
  //   _allCompanyList = await DBProvider.db.getAllCompany();
  // }

  CompanyBloc() {
    getCompany();
  }

  dispose() {
    _companyController.close();
  }

  create(Company model) {
    model.assignUUID();
    DBProvider.db.createCompany(model);
    getCompany();
  }

  update(Company model) {
    DBProvider.db.updateCompany(model);
    getCompany();
  }

  delete(String id) {
    DBProvider.db.deleteCompany(id);
    getCompany();
  }
}