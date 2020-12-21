import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/company.dart';
import 'package:flutter_app/repositories/company_bloc.dart';
import 'package:flutter_app/components/list_view.dart';

import 'package:flutter_app/main.dart';

class EditCompany extends StatelessWidget {

  final Company _newCompany = Company.newCompany();
  TextEditingController _nameController;
  TextEditingController _currentController;
  TextEditingController _previousController;
  TextEditingController _currentOrdinaryIncomeController;
  TextEditingController _previousOrdinaryIncomeController;
  TextEditingController _overTimeController;
  TextEditingController _paidDayController;
  TextEditingController _averageIncomeController;

  CompanyBloc bloc;
  final Company company;
  CompanyListView companyListView = CompanyListView();
  HomePage homePage = HomePage();

  EditCompany({Key key, @required this.bloc, @required this.company}){
    _newCompany.id = company.id;
    _nameController = TextEditingController(text: company.companyName);
    _currentController = TextEditingController(text: company.currentSales.toString());
    _previousController = TextEditingController(text: company.previousSales.toString());
    _currentOrdinaryIncomeController = TextEditingController(text: company.currentOrdinaryIncome.toString());
    _previousOrdinaryIncomeController = TextEditingController(text: company.previousOrdinaryIncome.toString());
    _overTimeController = TextEditingController(text: company.overTime.toString());
    _paidDayController = TextEditingController(text: company.paidDay.toString());
    _averageIncomeController = TextEditingController(text: company.averageIncome.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("編集"),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment : CrossAxisAlignment.start,
              children: <Widget>[
                _nameField(context),
                Container(
                  margin: const EdgeInsets.fromLTRB(20.0, 5, 20.0, 0),
                  alignment: Alignment.topLeft,
                  width: 125,
                  decoration: const BoxDecoration(
                    border: const Border(
                      bottom: const BorderSide(
                        color: Colors.indigo,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: const Text(
                    '将来性',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black54
                    ),
                  ),
                ),
                _currentField(context),
                _previousField(context),
                _currentOrdinaryIncomeField(context),
                _previousOrdinaryIncomeField(context),
                Container(
                  margin: const EdgeInsets.fromLTRB(20.0, 5, 20.0, 0),
                  alignment: Alignment.topLeft,
                  width: 125,
                  decoration: const BoxDecoration(
                    border: const Border(
                      bottom: const BorderSide(
                        color: Colors.indigo,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: const Text(
                    '福利厚生',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black54
                    ),
                  ),
                ),
                _overTimeField(context),
                _paidDayField(context),
                _averageIncomeField(context),
                Center(
                  child: _saveButton(context, bloc),
                ),
              ],
            ),
          ),
        ),
      );
  }

  Widget _saveButton(BuildContext context, var bloc) => RaisedButton(
    child: const Text("保存"),
    onPressed: (){
      _newCompany.companyName = _nameController.text;
      _newCompany.currentSales = int.parse(_currentController.text);
      _newCompany.previousSales = int.parse(_previousController.text);
      _newCompany.currentOrdinaryIncome = int.parse(_currentOrdinaryIncomeController.text);
      _newCompany.previousOrdinaryIncome = int.parse(_previousOrdinaryIncomeController.text);
      _newCompany.overTime = int.parse(_overTimeController.text);
      _newCompany.paidDay = int.parse(_paidDayController.text);
      _newCompany.averageIncome = int.parse(_averageIncomeController.text);
      bloc.update(_newCompany);
      // companyListView.showInSnackBar('保存しました');
      Navigator.of(context).pop();

    },
    color: Colors.indigo,
    textColor: Colors.white,
  );

  Widget _nameField(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
    child: TextField(
      enabled: true,
      maxLength: 10,
      maxLengthEnforced: false,
      style: const TextStyle(color: Colors.black54),
      obscureText: false,
      maxLines:1 ,
      decoration: const InputDecoration(
        labelText: "企業名",
      ),
      controller: _nameController,
    ),
  );

  Widget _currentField(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(30.0, 0.0, 20.0, 0.0),
    child: TextField(
      enabled: true,
      maxLength: 10,
      maxLengthEnforced: false,
      style: const TextStyle(color: Colors.black54),
      obscureText: false,
      maxLines:1 ,
      decoration: const InputDecoration(
        labelText: "今期売上",
      ),
      keyboardType: TextInputType.number,
      controller: _currentController,
    ),
  );

  Widget _previousField(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(30.0, 0.0, 20.0, 0.0),
    child: TextField(
      enabled: true,
      maxLength: 10,
      maxLengthEnforced: false,
      style: const TextStyle(color: Colors.black54),
      obscureText: false,
      maxLines:1 ,
      decoration: const InputDecoration(
        labelText: "前期売上",
      ),
      keyboardType: TextInputType.number,
      controller: _previousController,
    ),
  );

  Widget _currentOrdinaryIncomeField(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(30.0, 0.0, 20.0, 0.0),
    child: TextField(
      enabled: true,
      maxLength: 10,
      maxLengthEnforced: false,
      style: const TextStyle(color: Colors.black54),
      obscureText: false,
      maxLines:1 ,
      decoration: const InputDecoration(
        labelText: "当期経常利益",
      ),
      keyboardType: TextInputType.number,
      controller: _currentOrdinaryIncomeController,
    ),
  );

  Widget _previousOrdinaryIncomeField(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(30.0, 0.0, 20.0, 0.0),
    child: TextField(
      enabled: true,
      maxLength: 10,
      maxLengthEnforced: false,
      style: const TextStyle(color: Colors.black54),
      obscureText: false,
      maxLines:1 ,
      decoration: const InputDecoration(
        labelText: "前期経常利益",
      ),
      keyboardType: TextInputType.number,
      controller: _previousOrdinaryIncomeController,
    ),
  );

  Widget _overTimeField(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(30.0, 0.0, 20.0, 0.0),
    child: TextField(
      enabled: true,
      maxLength: 10,
      maxLengthEnforced: false,
      style: const TextStyle(color: Colors.black54),
      obscureText: false,
      maxLines:1 ,
      decoration: const InputDecoration(
        labelText: "残業時間",
      ),
      keyboardType: TextInputType.number,
      controller: _overTimeController,
    ),
  );

  Widget _paidDayField(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(30.0, 0.0, 20.0, 0.0),
    child: TextField(
      enabled: true,
      maxLength: 10,
      maxLengthEnforced: false,
      style: const TextStyle(color: Colors.black54),
      obscureText: false,
      maxLines:1 ,
      decoration: const InputDecoration(
        labelText: "有給取得日数",
      ),
      keyboardType: TextInputType.number,
      controller: _paidDayController,
    ),
  );

  Widget _averageIncomeField(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(30.0, 0.0, 20.0, 0.0),
    child: TextField(
      enabled: true,
      maxLength: 10,
      maxLengthEnforced: false,
      style: const TextStyle(color: Colors.black54),
      obscureText: false,
      maxLines:1 ,
      decoration: const InputDecoration(
        labelText: "平均年収",
      ),
      keyboardType: TextInputType.number,
      controller: _averageIncomeController,
    ),
  );
}