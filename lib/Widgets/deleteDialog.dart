import 'package:yokai_admin/Widgets/new_button.dart';
import 'package:flutter/material.dart';
import 'package:yokai_admin/utils/constants.dart' as constants;
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/Widgets/outline_button.dart';

class CustomDeleteWidget extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onCancelPressed;
  final VoidCallback onConfirmPressed;

  const CustomDeleteWidget({
    Key? key,
    required this.title,
    required this.message,
    required this.onCancelPressed,
    required this.onConfirmPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background overlay
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
          ),
        ),
        AlertDialog(
          content: Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: Container(
              width: MediaQuery.of(context).size.width / 6,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: headingOrange,
                    ),
                  ),
                  const SizedBox(
                    height: constants.defaultPadding * 3,
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(
                    height: constants.defaultPadding * 3,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlineButton(
                          textSize: 14,
                          text: 'Cancel',
                          onPressed: onCancelPressed,
                          width: MediaQuery.of(context).size.width / 5,
                        ),
                      ),
                      const SizedBox(
                        width: constants.defaultPadding * 5,
                      ),
                      Expanded(
                        child: CustomButton(
                          isPopup: true,
                          textSize: 14,
                          width: MediaQuery.of(context).size.width / 5,
                          text: 'Confirm',
                          onPressed: onConfirmPressed,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
