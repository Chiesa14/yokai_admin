import 'package:flutter/material.dart';
import 'package:yokai_admin/utils/const.dart';

import '../utils/colors.dart';
import '../utils/text_styles.dart';

// Define your custom widget
class DashboardCountWidget extends StatelessWidget {
  // final double screenHeight;
  // final double screenWidth;
  // final Color backgroundGrey;
  // final Color indigo800;
  final String title;
  final String userCount;
  final void Function()? onTap;

  const DashboardCountWidget({
    Key? key,
    // required this.screenHeight,
    // required this.screenWidth,
    // required this.backgroundGrey,
    // required this.indigo800,
    required this.title,
    required this.userCount,
    required this.onTap,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
     onTap: onTap,
      child: Container(
        height: screenHeight * 0.13,
        width: screenWidth / 6,
        padding: EdgeInsets.all(15),
        // alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: backgroundGrey,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppTextStyle.normalRegular14
                  .copyWith(fontFamily: 'Raleway'),
            ),
            1.ph,
            Text(
              userCount,
              style: AppTextStyle.normalBold40
                  .copyWith(color: indigo800,fontFamily: 'Raleway'),
            ),
          ],
        ),
      ),
    );
  }
}