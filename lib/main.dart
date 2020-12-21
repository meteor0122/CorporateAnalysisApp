import 'package:flutter/material.dart';
import 'package:flutter_app/models/company.dart';
import 'package:flutter_app/repositories/company_bloc.dart';
import 'package:provider/provider.dart';
import 'components/graph_view.dart';
import 'components/list_view.dart';

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
    CompanyListView(),
    GraphView(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Provider<CompanyBloc>(
        create: (context) => new CompanyBloc(),
        dispose: (context, bloc) => bloc.dispose(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("企業分析"),
          ),
          body: IndexedStack(
            index: _currentIndex,
            children: _pageWidgets,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem> [
              const BottomNavigationBarItem(icon: const Icon(Icons.list), label: 'リスト'),
              const BottomNavigationBarItem(icon: const Icon(Icons.bar_chart), label: 'グラフ'),
            ],
            currentIndex: _currentIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) => setState(() => _currentIndex = index);

}
