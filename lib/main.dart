import 'package:flutter/material.dart';
import 'package:flutter_app/components/add_company.dart';
import 'package:flutter_app/models/company.dart';
import 'package:flutter_app/repositories/company_bloc.dart';
import 'package:provider/provider.dart';
import 'components/graph_view.dart';
import 'components/list_view.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "title",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Company> companyList = [];

  final _pageWidgets = [
    AddCompany(),
    CompanyListView(),
    GraphView.withSampleData(),
  ];

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Provider<CompanyBloc>(
        create: (context) => new CompanyBloc(),
        dispose: (context, bloc) => bloc.dispose(),
        child: Scaffold (
          appBar: AppBar(
            title: Text("Title"),
          ),
          body: IndexedStack(
            index: _currentIndex,
            children: _pageWidgets,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem> [
              BottomNavigationBarItem(icon: Icon(Icons.add), label: '1'),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '2'),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: '3'),
            ],
            currentIndex: _currentIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return  MaterialApp(
  //       title: 'Flutter Demo',
  //       theme: ThemeData(
  //         primarySwatch: Colors.blue,
  //         visualDensity: VisualDensity.adaptivePlatformDensity,
  //       ),
  //       home: Provider<CompanyBloc>(
  //         create: (context) => new CompanyBloc(),
  //         dispose: (context, bloc) => bloc.dispose(),
  //         child: Scaffold (
  //           appBar: AppBar(
  //             title: Text("Title"),
  //           ),
  //           body: IndexedStack(
  //             index: _currentIndex,
  //             children: _pageWidgets,
  //           ),
  //           bottomNavigationBar: BottomNavigationBar(
  //             items: <BottomNavigationBarItem> [
  //               BottomNavigationBarItem(icon: Icon(Icons.add), label: '1'),
  //               BottomNavigationBarItem(icon: Icon(Icons.home), label: '2'),
  //               BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: '3'),
  //             ],
  //             currentIndex: _currentIndex,
  //             onTap: _onItemTapped,
  //             type: BottomNavigationBarType.fixed,
  //           ),
  //         ),
  //       ),
  //   );
  // }

  void _onItemTapped(int index) => setState(() => _currentIndex = index );

  void updateData() {
    final _bloc = Provider.of<CompanyBloc>(context, listen: false);
    setState(() {
      this.companyList = _bloc.getCompany();
    });
  }
}
