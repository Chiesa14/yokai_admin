import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yokai_admin/utils/constants.dart';
import 'package:yokai_admin/utils/text_styles.dart';

import '../../utils/colors.dart';

class SideOptions extends StatefulWidget {
  const SideOptions({
    Key? key,
    required this.title,
    required this.icon,
    required this.selected,
    required this.onPress,
  }) : super(key: key);
  final String title;
  final String icon;
  final bool selected;
  final Function onPress;

  @override
  State<SideOptions> createState() => _SideOptionsState();
}

class _SideOptionsState extends State<SideOptions> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: InkWell(
        onTap: () => widget.onPress(),
        onHover: (value) {
          if (value && !hover) {
            setState(() {
              hover = true;
            });
          } else {
            setState(() {
              hover = false;
            });
          }
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                // semanticContainer: true,
                // elevation: 0,
                decoration: BoxDecoration(
                  gradient: widget.selected ? customGradient : null,
                ),
                // color: hover
                //         ? primaryColorLite
                //         : Color(0xffF1F8FA),
                // margin: const EdgeInsets.only(
                //     left: constants.defaultPadding * 2,
                //     right: constants.defaultPadding * 2,
                //     top: constants.defaultPadding),
                // clipBehavior: Clip.antiAliasWithSaveLayer,
                // shape: RoundedRectangleBorder(
                //   borderRadius: constants.borderRadius,
                // ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: constants.defaultPadding * 2,
                    ),
                    SvgPicture.asset(
                      widget.icon,
                      // color: widget.selected ? colorWhite : primaryColor,
                      color: widget.selected ? colorWhite : indigo800,
                      height: 20,
                    ),
                    const SizedBox(
                      width: constants.defaultPadding * 2,
                    ),
                    Expanded(
                      child: Text(
                        widget.title,
                        softWrap: true,
                        style: textStyle.smallTextColorDark.copyWith(
                            color: widget.selected
                                ? colorWhite
                                : indigo800,
                            fontWeight: widget.selected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            fontSize: widget.selected ? 15 : 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: border,
              thickness: 1,
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
