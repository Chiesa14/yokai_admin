import 'package:yokai_admin/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:yokai_admin/utils/constants.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({Key? key, required this.scaffold}) : super(key: key);

  @override
  _SubjectScreenState createState() => _SubjectScreenState();
  final GlobalKey<ScaffoldState> scaffold;
}

class _SubjectScreenState extends State<SubjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Container(
      //   margin: EdgeInsets.all(Responsive.isMobile(context)
      //                 ? constants.defaultPadding
      //                 : constants.defaultPadding * 2),
      // )
    );
  }
}
