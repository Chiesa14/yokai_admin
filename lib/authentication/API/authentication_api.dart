import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yokai_admin/api/database.dart';
import 'package:yokai_admin/api/local_storage.dart';
import 'package:yokai_admin/globalVariable.dart';
import 'package:yokai_admin/main.dart';
import 'package:yokai_admin/utils/colors.dart';

class AuthenticationApi {
  static Future<bool> login(BuildContext context, body) async {
    final String url = DatabaseApi.login;
    final headers = {
      "Content-Type": "application/json",
      // "UserToken": DatabaseApi.authToken
    };
    customPrint("login Url::$url");
    customPrint("login body::${jsonEncode(body)}");
    try {
      return await http
          .post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: headers,
      )
          .then((value) async {
        final jsonData = jsonDecode(value.body);
        if (jsonData["status"].toString() != "true") {
          showErrorSnackBar(jsonData["message"], colorError);
          return false;
        } else {
          showSuccessSnackBarIcon(jsonData["message"], colorSuccess);
          prefs?.clear();
          prefs?.setString(LocalStorage.token, jsonData["token"].toString());
          prefs?.setBool(LocalStorage.isLogin, true);
          customPrint('token :: ${prefs?.getString(LocalStorage.token)}');
        }
        customPrint("login::${value.body}");
        return true;
      });
    } on Exception catch (e) {
      customPrint("Error :: $e");
      // showSnackbar(
      //     context,
      //     "Some unknown error has occur, try again after some time",
      //     colorError);
      return false;
    }
  }
}
