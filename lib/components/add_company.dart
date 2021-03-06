import 'package:flutter/material.dart';
import 'package:flutter_app/models/company.dart';
import 'package:flutter_app/repositories/company_bloc.dart';
import 'list_view.dart';


class AddCompany extends StatelessWidget {

  final Company _newCompany = Company.newCompany();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _currentController = new TextEditingController();
  final TextEditingController _previousController = new TextEditingController();
  final TextEditingController _currentOrdinaryIncomeController = new TextEditingController();
  final TextEditingController _previousOrdinaryIncomeController = new TextEditingController();
  final TextEditingController _overTimeController = new TextEditingController();
  final TextEditingController _paidDayController = new TextEditingController();
  final TextEditingController _averageIncomeController = new TextEditingController();
  CompanyBloc bloc;
  CompanyListView companyListView = CompanyListView();

  AddCompany({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("追加"),
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
              _paidDayField(context),
              _overTimeField(context),
              _averageIncome(context),
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
      bloc.create(_newCompany);
  //    companyListView.showInSnackBar('保存しました');
      Navigator.of(context).pop();
    },
    color: Colors.indigo,
    textColor: Colors.white,
  );

  Widget _nameField(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
    child: TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return '入力してください';
        }
        return null;
      },
      enabled: true,
      maxLength: 20,
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

  Widget _averageIncome(BuildContext context) => Container(
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