import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/company.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/repositories/company_bloc.dart';

class AddCompany extends StatelessWidget {

  final Company _newCompany = Company.newCompany();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 50.0),
        child: Column(
          children: <Widget>[
            _nameField(context),
            _currentField(context),
            _previousField(context),
            _saveButton(context),
          ],
        ),
      ),
    );
  }

  void _setCompanyName(String name) {
    _newCompany.companyName = name;
  }
  void _setCurrentSales(String sales) {
    _newCompany.currentSales = int.parse(sales);
  }
  void _setPreviousSales(String sales) {
    _newCompany.previousSales = int.parse(sales);
  }

  Widget _saveButton(BuildContext context) => RaisedButton(
    child: Text("保存"),
    onPressed: (){
      CompanyBloc().create(_newCompany);
    },
    color: Colors.indigo,
    textColor: Colors.white,
  );

  Widget _nameField(BuildContext context) => TextField(
    enabled: true,
    maxLength: 10,
    maxLengthEnforced: false,
    style: TextStyle(color: Colors.black54),
    obscureText: false,
    maxLines:1 ,
    decoration: InputDecoration(
      labelText: "企業名",
    ),
    onChanged: _setCompanyName,
  );

  Widget _currentField(BuildContext context) => TextField(
    enabled: true,
    maxLength: 10,
    maxLengthEnforced: false,
    style: TextStyle(color: Colors.black54),
    obscureText: false,
    maxLines:1 ,
    decoration: InputDecoration(
      labelText: "今期売上",
    ),
    keyboardType: TextInputType.number,
    onChanged: _setCurrentSales,
  );

  Widget _previousField(BuildContext context) => TextField(
    enabled: true,
    maxLength: 10,
    maxLengthEnforced: false,
    style: TextStyle(color: Colors.black54),
    obscureText: false,
    maxLines:1 ,
    decoration: InputDecoration(
      labelText: "前期売上",
    ),
    keyboardType: TextInputType.number,
    onChanged: _setPreviousSales,
  );
}