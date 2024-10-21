import 'package:flutter/cupertino.dart';
import 'package:yokai_admin/globalVariable.dart';
import 'package:yokai_admin/home/widgets/user_details.dart';
import 'package:yokai_admin/main.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:yokai_admin/utils/constants.dart';

import '../utils/text_styles.dart';

class AppNameContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: customGradient,
      ),
      height: 65,
      child: Row(
        children: [
          // Expanded(
          //   flex: 2,
          //   child: UserDetails(
          //     onPress: () {
          //       activityCount = 0;
          //       customPrint("text");
          //     },
          //   ),
          // ),
          Expanded(
            flex: 2,
            child: ListTile(
              leading: const Icon(
                Icons.account_circle_rounded,
                size: 40,
                color: Colors.white,
              ),
              title: const Text(
                "Hello, Admin!",
                style: AppTextStyle.subHeadingColor,
              ),
              subtitle: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: colorSuccess),
                    margin:
                        const EdgeInsets.only(right: constants.defaultPadding),
                    width: 8,
                    height: 8,
                  ),
                  const Text(
                    "Active Now",
                    style: AppTextStyle.smallText,
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
          ),
          const Expanded(
            flex: 8,
            child: Center(
              child: Text(
                'Yokaizen Admin Panel',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Opens Sans',
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Image.asset(
              'images/logowithbg.png',
              height: MediaQuery.of(context).size.height,
              width: 50,
            ),
          )
        ],
      ),
    );
  }
}
