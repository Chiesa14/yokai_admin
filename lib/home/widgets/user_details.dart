import 'package:yokai_admin/utils/constants.dart';
import 'package:yokai_admin/utils/text_styles.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    Key? key,
    required this.onPress,
    this.selected,
  }) : super(key: key);
  final Function onPress;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: customGradient,
      ),
      child: ListTile(
        leading: const Icon(
          Icons.account_circle_rounded,
          size: 40,
          color: Colors.white,
        ),
        title: Text(
          "Hello, Admin!",
          style: textStyle.subHeadingColor,
        ),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: colorSuccess),
              margin: const EdgeInsets.only(right: constants.defaultPadding),
              width: 8,
              height: 8,
            ),
            Text(
              "Active Now",
              style: textStyle.smallText,
            ),
          ],
        ),
        // trailing: InkWell(
        //   onTap: () => onPress(),
        //   child: Icon(
        //     Icons.settings,
        //     color: selected ? colorDark : colorSubHeadingText,
        //     size: 20,
        //   ),
        // ),
      ),
    );
  }
}
