import 'package:flutter/material.dart';

class TableData {
  String name;
  int age;

  TableData({required this.name, required this.age});
}

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key, required this.scaffold}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
  final GlobalKey<ScaffoldState> scaffold;
}

class _ReportScreenState extends State<ReportScreen> {
  List<TableData> _tableData = [
    TableData(name: 'John', age: 30),
    TableData(name: 'Alice', age: 25),
    TableData(name: 'Bob', age: 35),
  ];

  String _sortCriteria = 'Name'; // Default sorting criteria

  void _sortTableData() {
    setState(() {
      if (_sortCriteria == 'Name') {
        _tableData.sort((a, b) => a.name.compareTo(b.name));
      } else if (_sortCriteria == 'Age') {
        _tableData.sort((a, b) => a.age.compareTo(b.age));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
