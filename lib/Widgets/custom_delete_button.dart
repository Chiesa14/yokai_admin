import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yokai_admin/utils/colors.dart';

class CustomDelete extends StatefulWidget {
  final VoidCallback onPressed;
  final String iconSvgPath;
  final double width;
  final double textSize;
  final Color color;
  final bool isPopup;
  final Color? colorText;
  const CustomDelete({
    Key? key,
    required this.onPressed,
    this.iconSvgPath = '',
    this.width = double.infinity,
    this.textSize = 18,
    this.color = Colors.white,
    this.isPopup = false,
    this.colorText = Colors.white,

  }) : super(key: key);

  @override
  _CustomDeleteState createState() => _CustomDeleteState();
}

class _CustomDeleteState extends State<CustomDelete> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // width: widget.width,
        decoration: BoxDecoration(
          color: _isHovered ? hoverColorLigth : headingOrange,
          borderRadius: BorderRadius.circular(8),
          // border: Border.all(color: Color(0xFF9B1AD6)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: _isHovered ? hoverColorLigth : primaryColor,
          borderRadius: BorderRadius.circular(8),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              widget.onPressed();
              setState(() {});
            },
            onHover: (isHovered) {
              setState(() {
                _isHovered = isHovered;
              });
            },
            splashColor: headingOrange,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3,vertical: 3),
              // height: 40,
              child: SvgPicture.asset(
                    'icons/deleteNew.svg',
                    // color: widget.color,
                    // width: double.infinity,
                    // height: double.infinity,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
