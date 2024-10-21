import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../../api/database.dart';
import '../../../api/local_storage.dart';
import '../../../globalVariable.dart';
import '../../../main.dart';
import '../../../model/get_all_blocked_user.dart';
import '../../../model/get_all_user.dart';
import '../../../utils/colors.dart';

class UserController{
  static RxBool isBlocked = false.obs;
 static String selectedSubject = "Date Joined";
 static openWhatsApp() async {
  const phoneNumber = 'whatsapp://send?phone=+255652313846';

  try {
   await launch(phoneNumber);
  } catch (e) {
   print('Error launching WhatsApp: $e');
  }
 }
 static final TextEditingController searchUserController = TextEditingController();
  static Rx<GetAllUser> getAllUserModel = GetAllUser().obs;

  static Future<bool> getAllUser(String search) async {
    final headers = {
      "Content-Type": "application/json",
      "accept": "application/json",
      "AdminToken": '${prefs?.getString(LocalStorage.token).toString()}'
    };
    final String url =
        "${DatabaseApi.getAllUser}$search";
    customPrint("getAllUser url :: $url");
    customPrint("token url :: ${prefs?.getString(LocalStorage.token).toString()}");
    try {
      return await http
          .get(Uri.parse(url), headers: headers)
          .then((value) async {
        print("getAllUser :: ${value.body}");
        final jsonData = jsonDecode(value.body);
        if (jsonData["status"].toString() != "true") {
          showErrorSnackBar(jsonData["message"].toString(), colorError);
          return false;
        }
        //showSnackbar("Subscription PlanPrice Details Added Successfully", colorSuccess);
        getAllUserModel(getAllUserFromJson(value.body));
        return true;
      });
    } on Exception catch (e) {
      print("getAllUser:: $e");
      // showSnackbar("Some unknown error has occur, try again after some time!", colorError);
      return false;
    }
  }

  static Rx<GetAllBlockedUser> getAllBlockedUserModel = GetAllBlockedUser().obs;

  static Future<bool> getAllBlockedUser(String search) async {
    final headers = {
      "Content-Type": "application/json",
      "accept": "application/json",
      "AdminToken": '${prefs?.getString(LocalStorage.token).toString()}'
    };
    final String url =
        "${DatabaseApi.getAllBlockedUser}$search";
    customPrint("getAllBlockedUser url :: $url");
    customPrint("token url :: ${prefs?.getString(LocalStorage.token).toString()}");
    try {
      return await http
          .get(Uri.parse(url), headers: headers)
          .then((value) async {
        print("getAllBlockedUser :: ${value.body}");
        final jsonData = jsonDecode(value.body);
        if (jsonData["status"].toString() != "true") {
          showErrorSnackBar(jsonData["message"].toString(), colorError);
          return false;
        }
        //showSnackbar("Subscription PlanPrice Details Added Successfully", colorSuccess);
        getAllBlockedUserModel(getAllBlockedUserFromJson(value.body));
        return true;
      });
    } on Exception catch (e) {
      print("getAllBlockedUser:: $e");
      // showSnackbar("Some unknown error has occur, try again after some time!", colorError);
      return false;
    }
  }

 static Future<bool> deleteUser(
     BuildContext context, String id) async {
  final headers = {
   "Content-Type": "application/json",
   "accept": "application/json",
   "AdminToken":'${prefs?.getString(LocalStorage.token).toString()}'
  };
  String url = "${DatabaseApi.deleteUserByToken}$id";
  customPrint("deleteUser URL :: $url");
  customPrint("deleteUser headers :: $headers");
  try {
   return await http.delete(Uri.parse(url), headers: headers).then((value) {
    customPrint("deleteUser :: ${value.body}");
    final jsonData = jsonDecode(value.body);
    if (value.statusCode != 200) {
     showErrorSnackBar(jsonData["message"].toString(), colorError);
     return false;
    } else if (jsonData["status"] == "false") {
     showErrorSnackBar(jsonData["message"].toString(), colorError);
     return false;
    }
    showSuccessSnackBarIcon(jsonData["message"].toString(), colorSuccess);
    return true;
   });
  } on Exception catch (e) {
   customPrint("deleteUser  :: $e");
   showErrorSnackBar("delete ", colorError);
   return false;
  }
 }

 static Future<bool> deleteAndBlockUser(context, body) async {
  final String url = "${DatabaseApi.deleteAndBlockUser}";
  customPrint("deleteAndBlockUser url:: $url");
  customPrint("deleteAndBlockUser body:: ${jsonEncode(body)}");

  final headers = {
   "Content-Type": "application/json",
   "AdminToken": "${prefs?.getString(LocalStorage.token)}",
  };
  try {
   return await http
       .put(Uri.parse(url), headers: headers, body: json.encode(body))
       .then((value) async {
    final jsonData = json.decode(value.body);
    print("deleteAndBlockUser response:: ${jsonEncode(jsonData)}");
    if (value.statusCode != 200) {
     showErrorSnackBar(jsonData["message"].toString(), colorError);
     return false;
    } else if (jsonData["status"] == "false") {
     showErrorSnackBar(jsonData["message"].toString(), colorError);
     return false;
    }
// getbackTestingStock(getBackTestingStockFromJson(value.body));

    showSuccessSnackBarIcon(jsonData["message"].toString(), colorSuccess);
    return true;
   });
  } on Exception catch (e) {
   customPrint("Error :: $e");
// showSnackbar(context,
// "Some unknown error has occur, try again after some time", colorRed);
   return false;
  }
 }
}