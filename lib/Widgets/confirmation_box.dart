import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yokai_admin/utils/const.dart';

import '../utils/colors.dart';
import '../utils/text_styles.dart';
import './new_button.dart';
import 'new_button2.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final String cancelButtonText;
  final String confirmButtonText;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final String customImageAsset;
  final bool displayIcon;
  final Color tileColor;
  const ConfirmationDialog(
      {required this.title,
      required this.content,
      required this.cancelButtonText,
      required this.confirmButtonText,
      required this.onCancel,
      required this.onConfirm,
      this.tileColor = textDark,
      this.customImageAsset = 'images/appLogo_yokai.png',
      this.displayIcon = false});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      //  height: MediaQuery.of(context).size.height * 0.4,
      titlePadding: title.isEmpty ? EdgeInsets.zero : null,
      backgroundColor: colorWhite,
      title: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (displayIcon == true) Image.asset(customImageAsset, height: 80),
            Text(
              title,
              style: AppTextStyle.normalSemiBold16.copyWith(color: tileColor),
            ),
          ],
        ),
      ),
      content: content,
      actions: <Widget>[
        // Padding(
        //   padding: EdgeInsets.symmetric(
        //       horizontal: cancelButtonText == 'Delete' ? 10 : 12, vertical: 4),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       ElevatedButton(
        //         onPressed: onConfirm,
        //         style: ElevatedButton.styleFrom(
        //           padding:
        //               const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        //           backgroundColor: primaryColor,
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(20),
        //           ),
        //           shadowColor: Color(0x0C101828),
        //           elevation: 2,
        //         ),
        //         child: Text(
        //           confirmButtonText,
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontSize: confirmButtonText.length > 14 ? 12 : 14,
        //             fontFamily: 'Montserrat',
        //             fontWeight: FontWeight.w600,
        //             height: 0,
        //           ),
        //         ),
        //       ),
        //       ElevatedButton(
        //         onPressed: onCancel,
        //         style: ElevatedButton.styleFrom(
        //           padding: EdgeInsets.zero,
        //           backgroundColor: Colors.white,
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(20),
        //           ),
        //           side: BorderSide(
        //               width: 1,
        //               color: cancelButtonText == 'Delete'
        //                   ? headingOrange
        //                   : Color(0xFFA9B6B7)),
        //           shadowColor: Color(0x0C101828),
        //           elevation: 2,
        //         ),
        //         child: Container(
        //           height: 40,
        //           padding:
        //               const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        //           clipBehavior: Clip.antiAlias,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(8),
        //           ),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               cancelButtonText == 'Delete'
        //                   ? SvgPicture.asset('icons/delete_icon.svg')
        //                   : SizedBox(),
        //               0.5.pw,
        //               Text(
        //                 cancelButtonText,
        //                 style: TextStyle(
        //                   color: cancelButtonText == 'Delete'
        //                       ? headingOrange
        //                       : Color(0xFF495355),
        //                   fontSize: 14,
        //                   fontFamily: 'Montserrat',
        //                   fontWeight: FontWeight.w400,
        //                   height: 0,
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        3.ph,
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 10),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomButton(
                  width: screenWidth / 9,
                  textSize: 14,
                  onPressed: onConfirm,
                  text: 'Confirm',
                ),
              ),
              SizedBox(
                width: screenWidth / 20,
              ),
              Expanded(
                child: CustomButton2(
                  width: screenWidth / 10,
                  textSize: 14,
                  color: indigo700,
                  colorText: indigo700,
                  onPressed: onCancel,
                  text: 'Cancel',
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
