import 'package:flutter/material.dart';

class CustomEditableTable extends StatefulWidget {
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

  CustomEditableTable({
    Key? key,
    required this.rows,
    required this.columns,
    required this.rowNames,
    required this.columnNames,
    required this.initialValues,
    required this.firstColname,
    this.textColor = Colors.black,
    this.fontSize = 12,
    this.fontSizeCol = 14,
    this.onTap,
  }) : super(key: key);

  @override
  _CustomEditableTableState createState() => _CustomEditableTableState();
}

class _CustomEditableTableState extends State<CustomEditableTable> {
  late List<List<dynamic>> _values;

  @override
  void initState() {
    super.initState();
    _values = List<List<dynamic>>.from(widget.initialValues);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: _createColumns(),
        rows: _createRows(),
        headingTextStyle: TextStyle(
          color: widget.textColor,
          fontSize: widget.fontSizeCol,
        ),
        dataTextStyle: TextStyle(
          color: widget.textColor,
          fontSize: widget.fontSize,
        ),
      ),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
        label: Text(widget.firstColname),
      ),
      ...widget.columnNames.map((name) => DataColumn(label: Text(name))).toList(),
    ];
  }

  List<DataRow> _createRows() {
    return List<DataRow>.generate(
      widget.rows,
      (rowIndex) => DataRow(
        cells: [
          DataCell(Text(widget.rowNames[rowIndex])),
          ...List<DataCell>.generate(
            widget.columns,
            (colIndex) => DataCell(
              _values[rowIndex][colIndex] is String
                  ? EditableTextCell(
                      initialValue: _values[rowIndex][colIndex],
                      onChanged: (newValue) {
                        setState(() {
                          _values[rowIndex][colIndex] = newValue;
                        });
                      },
                    )
                  : Text(_values[rowIndex][colIndex].toString()),
              onTap: widget.onTap != null ? () => widget.onTap!(rowIndex) : null,
            ),
          ),
        ],
      ),
    );
  }
}

class EditableTextCell extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  EditableTextCell({required this.initialValue, required this.onChanged});

  @override
  _EditableTextCellState createState() => _EditableTextCellState();
}

class _EditableTextCellState extends State<EditableTextCell> {
  late TextEditingController _controller;
  late bool _isEditing;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _isEditing = false;
  }

  @override
  Widget build(BuildContext context) {
    return _isEditing
        ? TextField(
            controller: _controller,
            onSubmitted: (newValue) {
              setState(() {
                _isEditing = false;
                widget.onChanged(newValue);
              });
            },
          )
        : InkWell(
            onTap: () {
              setState(() {
                _isEditing = true;
              });
            },
            child: Text(_controller.text),
          );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}