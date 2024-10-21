
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/colors.dart';

Future<bool?> buildToast({
  required String messageText,
  double fontSize = 13,
}) {
  return Fluttertoast.showToast(
      msg: messageText,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: errorColor,
      textColor: Colors.white,
      fontSize: fontSize);
}
