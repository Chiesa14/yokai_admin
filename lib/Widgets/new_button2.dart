import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yokai_admin/utils/colors.dart';

class CustomButton2 extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final String iconSvgPath;
  final double width;
  final double textSize;
  final Color color;
  final bool isPopup;
  final Color? colorText;
  const CustomButton2({
    Key? key,
    required this.text,
    required this.onPressed,
    this.iconSvgPath = '',
    this.width = double.infinity,
    this.textSize = 18,
    this.color = Colors.white,
    this.isPopup = false,
    this.colorText = Colors.white,

  }) : super(key: key);

  @override
  _CustomButton2State createState() => _CustomButton2State();
}

class _CustomButton2State extends State<CustomButton2> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.width,
        decoration: BoxDecoration(
          color: _isHovered ? hoverColorLigth : headingOrange,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Color(0xFF9B1AD6)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: _isHovered ? AppColors.white : AppColors.white,
          borderRadius: BorderRadius.circular(50),
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
            borderRadius: BorderRadius.circular(50),
            child: Container(
              height: (widget.width >= MediaQuery.of(context).size.width / 5 &&
                  widget.isPopup == false)
                  ? 50
                  : 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.iconSvgPath.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SvgPicture.asset(
                      widget.iconSvgPath,
                      color: widget.color,
                      width: 20,
                      height: 20,
                    ),
                  )
                      : SizedBox(),
                  Expanded(
                    child: Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: widget.colorText,
                        fontSize: widget.textSize,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
