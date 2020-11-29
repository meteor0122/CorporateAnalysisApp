import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/company.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/repositories/company_bloc.dart';

// class CompanyListView extends StatefulWidget {
//   final List<Company> company;
//   CompanyListView(this.company);
//
//   @override
//   State<StatefulWidget> createState() => CompanyListViewState();
// }

class CompanyListView extends StatelessWidget {
  List<Company> company;

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<CompanyBloc>(context, listen: false);
  //   return Scaffold(
  //     body: Container(
  //       child: ListView.builder(
  //           itemBuilder: (BuildContext context, int index) {
  //             Company company = _bloc.getCompany();
  //             return Dismissible(
  //               key: Key(company.id),
  //               onDismissed: (direction) {
  //                 _bloc.delete(company.id);
  //               },
  //               child: Card(
  //                   child: ListTile(
  //                     onTap: () {
  //                       // TODO: 編集
  //                     },
  //                     title: Text("${company.companyName}"),
  //                     subtitle: Text("${company.previousSales}" + " | " +
  //                         "${company.currentSales}"),
  //                     isThreeLine: true,
  //                   )
  //               ),
  //             );
  //           }
  //       ),
  //     ),
  //   );
  // }

    return Scaffold(
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
                    },
                    child: Card(
                      child: ListTile(
                        onTap:() {
                          // TODO: 編集
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
}