import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:yokai_admin/utils/constants.dart';


class MyDropDownNew extends StatefulWidget {
  MyDropDownNew({
    Key? key,
    required this.onChange,
    this.defaultValue,
    required this.array,
    this.margin,
    this.hintText,
    this.icon,
    this.color,
    this.enable = true,
    this.borderWidth = 2.0,
    this.onTap,
  }) : super(key: key);

  final Function(String?) onChange;
  final String? defaultValue;
  final List<String> array;
  final margin;
  final icon;
  final bool enable;
  final String? hintText;
  final double borderWidth;
  final void Function()? onTap;
  Color? color;

  @override
  _MyDropDownNewState createState() => _MyDropDownNewState();
}

class _MyDropDownNewState extends State<MyDropDownNew> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color:widget.color,
        margin: widget.margin ?? const EdgeInsets.only(),
        semanticContainer: true,
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFFD0D5DD), width: widget.borderWidth),
          borderRadius: constants.borderRadius,
        ),
        child: DropdownButton<String>(
          value: selectedValue,
          dropdownColor: colortextfield,
          underline: Container(),
          hint: Padding(
            padding: const EdgeInsets.only(left: constants.defaultPadding),
            child: Text('${widget.hintText}'),
          ),
          padding: EdgeInsets.only(right: 10),
          icon: widget.icon ??
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: arrow,
                size: 25,
              ),
          isExpanded: true,
          items: widget.array.toSet().toList().map((String value) {
            return DropdownMenuItem<String>(
              // enabled: widget.enable,
              value: value,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: constants.defaultPadding,
                  right: constants.defaultPadding,
                ),
                child: Text(
                  value,
                  style:
                  AppTextStyle.normalRegular16.copyWith(color: hintColor),
                ),
              ),
            );
          }).toList(),
          onTap: widget.onTap,
          onChanged: widget.enable
              ? (value) {
            setState(() {
              selectedValue = value;
            });
            widget.onChange(value);
          }
              : null,
        ),
      ),
    );
  }
}
