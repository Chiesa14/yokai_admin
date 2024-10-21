// import 'package:yokai_admin/screens/student/student%20api/student_api.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CustomTable extends StatefulWidget {
  final int rows;
  final int columns;
  final Color textColor;
  final double fontSize;
  final double fontSizeCol;
  final List<String> rowNames;
  final List<String> columnNames;
  final List<List<dynamic>> initialValues;
  final String firstColname;
  final void Function(int)? onTap;

  CustomTable({
    Key? key,
    required this.rows,
    required this.columns,
    required this.rowNames,
    required this.columnNames,
    required this.initialValues,
    required this.firstColname,
    this.textColor = textBlack,
    this.fontSize = 12,
    this.fontSizeCol = 14,
    this.onTap,
  }) : super(key: key);

  @override
  _CustomTableState createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  bool _sortAscending = true;
  int _sortColumnIndex = -1;
  List<String>? sortedRowNames;
  @override
  void initState() {
    super.initState();
    sortedRowNames = List<String>.from(widget.rowNames);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection:
          widget.columnNames.length > 8 ? Axis.horizontal : Axis.vertical,
      child: SizedBox(
        width: widget.columnNames.length > 8
            ? MediaQuery.of(context).size.width * 2
            : MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Table(
            columnWidths: {
              for (int i = 0; i < widget.columnNames.length; i++)
                i: FlexColumnWidth(
                    (i == 0 && (widget.firstColname == 'Date Created '))
                        ? 0.4
                        : (i == 0 && (widget.firstColname == 'Subject'))
                            ? 2
                            : (i == 2 &&
                                    (widget.columnNames[1] ==
                                            'Specific Objectives' ||
                                        widget.columnNames[1] == 'Email'))
                                ? 1.5
                                : (i == 2 && (widget.columnNames[1] == 'Title'))
                                    ? 2
                                    : (i == 5 &&
                                            (widget.columnNames[4] == 'School'))
                                        ? 1.5
                                        : 1),
            },
            border: const TableBorder(
              horizontalInside: BorderSide(color: Color(0xFF8FC0D1)),
              verticalInside: BorderSide(color: Color.fromARGB(0, 0, 0, 0)),
              // top: BorderSide(color: Color(0xFF8FC0D1)),
              bottom: BorderSide(color: Color(0xFFD3CAD8)),
              // left: BorderSide(color: Color(0xFF8FC0D1)),
              // right: BorderSide(color: Color(0xFF8FC0D1)),
            ),
            children: [
              TableRow(
                decoration: BoxDecoration(color: carlo50),
                children: [
                  TableCell(
                    child: InkWell(
                      onTap: () {
                        _sortColumnIndex = 0;
                        setState(() {
                          _sortAscending = !_sortAscending;
                          _sortTable();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.firstColname,
                          style: AppTextStyle.questionAnswer.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  ...List.generate(
                    widget.columns,
                    (colIndex) => TableCell(
                      child: InkWell(
                        onTap: () {
                          _sortColumnIndex = colIndex + 1;
                          setState(() {
                            _sortAscending = !_sortAscending;
                            _sortTable();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: Text(
                              widget.columnNames[colIndex],
                              style: AppTextStyle.questionAnswer.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ...List.generate(
                widget.rows,
                (rowIndex) => TableRow(
                  children: List.generate(
                    widget.columns + 1,
                    (colIndex) => TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: (colIndex == 0)
                            ? InkWell(
                                onTap: (widget.onTap != null &&
                                        widget.firstColname.contains('Name'))
                                    ? () {
                                        widget.onTap!(rowIndex);
                                        // StudentApi.studentName(
                                        //     widget.rowNames[rowIndex]);
                                      }
                                    : null,
                                child: Text(
                                  textAlign: TextAlign.left,
                                  widget.rowNames[rowIndex],
                                  style: AppTextStyle.questionAnswer
                                      .copyWith(fontSize: widget.fontSizeCol),
                                ),
                              )
                            : Center(
                                child: _buildCellContent(
                                widget.initialValues[rowIndex][colIndex - 1],
                                rowIndex,
                              )),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCellContent(dynamic value, int rowIndex) {
    if (value is String) {
      return InkWell(
        onTap: () {
          print('Cell in row $rowIndex is tapped');
          if (widget.onTap != null) {
            widget.onTap!(rowIndex);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            value,
            textAlign: TextAlign.left,
            style: AppTextStyle.questionAnswer.copyWith(
              fontSize: widget.fontSize,
              color: widget.textColor,
            ),
          ),
        ),
      );
    } else if (value is Widget) {
      return value;
    } else {
      return SizedBox();
    }
  }

  void _sortTable() {
    widget.initialValues.sort((a, b) {
      dynamic valA, valB;
      if (_sortColumnIndex == 0) {
        valA = widget.rowNames.indexOf(a[0]);
        valB = widget.rowNames.indexOf(b[0]);
      } else {
        valA = _getValueForColumn(a, _sortColumnIndex - 1);
        valB = _getValueForColumn(b, _sortColumnIndex - 1);
      }

      if (valA is String && valB is String) {
        if (_sortAscending) {
          return valA.compareTo(valB);
        } else {
          return valB.compareTo(valA);
        }
      } else if (valA is num && valB is num) {
        if (_sortAscending) {
          return valA.compareTo(valB);
        } else {
          return valB.compareTo(valA);
        }
      } else {
        return 0;
      }
    });

    setState(() {
      sortedRowNames = List<String>.from(
          widget.initialValues.map((row) => row[0].toString()));
    });
  }

  dynamic _getValueForColumn(List<dynamic> row, int columnIndex) {
    if (columnIndex < 0 || columnIndex >= row.length) return null;
    return row[columnIndex];
  }
}
