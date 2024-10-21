import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CustomRadioListTile extends StatefulWidget {
  final String title;
  final String value;
  final String? groupValue;
  final Function(String?) onChanged;

  const CustomRadioListTile({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  _CustomRadioListTileState createState() => _CustomRadioListTileState();
}

class _CustomRadioListTileState extends State<CustomRadioListTile> {
  @override
  Widget build(BuildContext context) {
    final isSelected = widget.groupValue == widget.value;

    return GestureDetector(
      onTap: () {
        widget.onChanged(widget.value);
      },
      child: Row(
        children: [
          Radio<String>(
            value: widget.value,
            groupValue: widget.groupValue,
            onChanged: widget.onChanged,
            activeColor: headingOrange,
          ),
          SizedBox(width: 2),
          Text(
            widget.title,
            style: AppTextStyle.normalRegular14.copyWith(
              color: isSelected
                  ? headingOrange
                  : labelColor,
              fontWeight: isSelected
                  ? FontWeight.bold
                  : FontWeight.normal, 
            ),
          ),
        ],
      ),
    );
  }
}
