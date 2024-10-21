import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yokai_admin/model/get_dashboard_count.dart';
import '../../../api/database.dart';
import '../../../api/local_storage.dart';
import '../../../globalVariable.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';

class DashBoardController {
  static Rx<GetDashboardCount> getHomeDashboardCount = GetDashboardCount().obs;

  static Future<bool> getDashBoardCount() async {
    final headers = {
      "Content-Type": "application/json",
      "AdminToken": '${prefs?.getString(LocalStorage.token).toString()}'
    };
    final String url = '${DatabaseApi.getDashboardCount}';
    customPrint("getDashBoardCount url :: $url");
    try {
      return await http
          .get(Uri.parse(url), headers: headers)
          .then((value) async {
        print("getDashBoardCount :: ${value.body}");
        final jsonData = jsonDecode(value.body);
        if (jsonData["status"].toString() != "true") {
          showErrorSnackBar(jsonData["message"].toString(), colorError);
          return false;
        }
        //showSnackbar("Subscription PlanPrice Details Added Successfully", colorSuccess);
        getHomeDashboardCount(getDashboardCountFromJson(value.body));
        return true;
      });
    } on Exception catch (e) {
      print("getDashBoardCount:: $e");
      // showSnackbar("Some unknown error has occur, try again after some time!", colorError);
      return false;
    }
  }
}
