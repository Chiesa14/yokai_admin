import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:yokai_admin/utils/constants.dart';


class MyDropDown extends StatefulWidget {
   MyDropDown({
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
  }) : super(key: key);

  final Function(String?) onChange;
  final String? defaultValue;
  final List<String> array;
  final margin;
  final icon;
  final bool enable;
  final String? hintText;
  final double borderWidth;
  Color? color;

  @override
  _MyDropDownState createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
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
          side: BorderSide(color: Color(0xFFFEF5EE), width: widget.borderWidth),
          borderRadius: constants.borderRadius,
        ),
        child: DropdownButton<String>(
          value: selectedValue,
          style: AppTextStyle.normalRegular16
              .copyWith(color: hoverColor),
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
