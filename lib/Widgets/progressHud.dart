import 'package:yokai_admin/utils/constants.dart';
import 'package:yokai_admin/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/images.dart';

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final double opacity;
  final Color color;

  const ProgressHUD({
    Key? key,
    required this.child,
    required this.isLoading,
    this.opacity = 0.5,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = List<Widget>.empty(growable: true);
    widgetList.add(child);
    if (isLoading) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: constants.borderRadius,
                side: BorderSide(width: 0.2, color: colorSubHeadingText),
              ),
              child: Padding(
                padding: const EdgeInsets.all(constants.defaultPadding * 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(
                      width: constants.defaultPadding,
                    ),
                    Text(
                      "Please wait...",
                      style: textStyle.subHeadingColor
                          .copyWith(color: colorHeadingText),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
