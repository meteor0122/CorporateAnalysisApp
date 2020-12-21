import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/add_company.dart';
import 'package:flutter_app/models/company.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/repositories/company_bloc.dart';

import 'edit_company.dart';

class CompanyListView extends StatelessWidget {
  List<Company> company;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<CompanyBloc>(context, listen: false);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _moveToAddCompany(context, _bloc);
        },
        child: const Icon(Icons.add),

      ),
      key: scaffoldKey,
      body: StreamBuilder<List<Company>>(
        stream: _bloc.companyStream,
        builder: (BuildContext context, AsyncSnapshot<List<Company>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Company company = snapshot.data[index];
                  return Dismissible(
                    key: Key(company.id),
                    onDismissed: (direction) {
                      _bloc.delete(company.id);
                      // showInSnackBar('削除しました');
                      Scaffold.of(context).showSnackBar(SnackBar(content: const Text('削除しました'), duration: Duration(seconds: 3)));
                    },
                    child: Card(
                      child: ListTile(
                        onTap:() {
                          _moveToEditCompany(context, _bloc, company);
                        },
                        title: Text("${company.companyName}"),
                        subtitle: Text("${company.previousSales}" + " | " + "${company.currentSales}"),
                        isThreeLine: true,
                      )
                    ),
                  );
                }
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _moveToEditCompany(BuildContext context, CompanyBloc bloc, Company company) => Navigator.push(
  context,
    MaterialPageRoute(builder: (context) => EditCompany(bloc: bloc, company: company))
  );

  void _moveToAddCompany(BuildContext context, CompanyBloc bloc) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddCompany(bloc: bloc))
  );


  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text(value), duration: Duration(seconds: 3))
    );
  }
}