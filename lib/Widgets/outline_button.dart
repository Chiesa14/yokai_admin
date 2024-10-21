import 'package:yokai_admin/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/colors.dart';

class OutlineButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final String iconSvgPath;
  final double width;
  final double textSize;
  final Color color;

  const OutlineButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.iconSvgPath = '',
      this.width = double.infinity,
      this.textSize = 18,
      this.color = primaryColor})
      : super(key: key);

  @override
  State<OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<OutlineButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.width,
        child: MouseRegion(
          onEnter: (_) {
            setState(() {
              _isHovered = true;
            });
          },
          onExit: (_) {
            setState(() {
              _isHovered = false;
            });
          },
          child: Material(
            color: AppColors.transparent,
            borderRadius: BorderRadius.circular(50),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: widget.onPressed,
              splashColor: headingOrange,
              borderRadius: BorderRadius.circular(50),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: _isHovered ? hoverColorLigth : widget.color),
                  borderRadius: BorderRadius.circular(50),
                ),
                height: (widget.width >= MediaQuery.of(context).size.width / 2)
                    ? 50
                    : 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (widget.iconSvgPath.isNotEmpty)
                        ? SvgPicture.asset(widget.iconSvgPath)
                        : SizedBox(),
                    (widget.iconSvgPath.isNotEmpty) ? 1.pw : SizedBox(),
                    Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _isHovered ? hoverColorLigth : widget.color,
                        fontSize: widget.textSize,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
