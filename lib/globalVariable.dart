library my_prj.globals;

import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/constants.dart';
import 'package:yokai_admin/utils/routes.dart';

import 'api/local_storage.dart';
import 'authentication/login.dart';
import 'main.dart';

//=========================Variables============================================

final RxList<String> subjects = RxList<String>.of(["Date Joined"]);
final RxList<String> allsubjectsList = RxList<String>();
final RxList<String> finalexamTitles = RxList<String>();
final RxList<String> topicalexamTitles = RxList<String>();
final RxList<String> otherexamTitles = RxList<String>();
RxMap<String, int> subjectWithId = RxMap<String, int>();
RxMap<String, String> subjectWithStandard = RxMap<String, String>();
Uint8List? filePath;
final List<String> createdby = <String>[
  "Select",
  "Admin",
  "Teacher",
  "All", // "Grade 12",
];

final List<String> grade = <String>[
  "Select",
  "Standard 1",
  "Standard 2",
  "Standard 3",
  "Standard 4",
  "Standard 5",
  "Standard 6",
  "Standard 7",
  "Form 1",
  "Form 2",
  "Form 3",
  "Form 4",
  // "Grade 12",
];
// void showSnackbar(String message, Color color, [int duration = 4000]) {
//   final snackBar = GetSnackBar(
//     // behavior: SnackBarBehavior.floating,
//     margin: EdgeInsets.all(constants.defaultPadding),
//     backgroundColor: color,
//     borderRadius: 4,
//     message: message,
//     duration: Duration(milliseconds: duration),
//     // content: Text(message),
//   );
//   Get.showSnackbar(snackBar);
// }
void showSuccessSnackBar(icon, String message) {
  final snackBar = GetSnackBar(
    margin: const EdgeInsets.all(constants.defaultPadding),
    backgroundColor: const Color(0xffD1FFE1),
    maxWidth: 400, padding: const EdgeInsets.all(25),
    borderRadius: 20,
    // icon: Icon(
    //   icon, size: 32,
    //   color: const Color(0xff0B8233),
    // ),
    messageText: Text(
      message,
      style: GoogleFonts.dmSans(
          fontSize: 16,
          color: const Color(0xff0B8233),
          fontWeight: FontWeight.w500),
    ),
    message: message,
    duration: const Duration(milliseconds: 2000),
  );
  Get.showSnackbar(snackBar);
}

void showSuccessSnackBarIcon(String message, Color color) {
  final snackBar = GetSnackBar(
    margin: const EdgeInsets.all(constants.defaultPadding),
    // backgroundColor: const Color(0xffD1FFE1),
    backgroundColor: color,
    maxWidth: 400, padding: const EdgeInsets.all(25),
    borderRadius: 20,
    icon: SvgPicture.asset( 'icons/check.svg'),
    messageText: Text(
      message,
      style: GoogleFonts.dmSans(
          fontSize: 16,
          color: const Color(0xff0B8233),
          fontWeight: FontWeight.w500),
    ),
    message: message,
    duration: const Duration(milliseconds: 2000),
  );
  Get.showSnackbar(snackBar);
}

void showErrorSnackBar(String message, Color color) {
  if (message != 'Invalid token') {
    final snackBar = GetSnackBar(
    padding: const EdgeInsets.all(25),
    margin: const EdgeInsets.all(constants.defaultPadding),
    backgroundColor: const Color(0xffFFD5D6),
    maxWidth: 550,
    borderRadius: 20,
    icon: SvgPicture.asset('icons/error.svg'),
    messageText: Text(
      message,
      style: GoogleFonts.dmSans(
          fontSize: 16,
          color: const Color(0xff900F0F),
          fontWeight: FontWeight.w500),
    ),
    message: message,
    duration: const Duration(milliseconds: 2000),
  );
    Get.showSnackbar(snackBar);
  } else {
    prefs?.setBool(LocalStorage.isLogin, false);
    prefs?.clear();
    navigator?.pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return const LoginPage();
      },
    ), (route) => false);
  }
}

void nextPage(context, Widget page) {
  Navigator.push(context,
      PageTransition(type: PageTransitionType.rightToLeft, child: page));
}

void nextPageFade(context, Widget page) {
  Navigator.push(
      context, PageTransition(type: PageTransitionType.fade, child: page));
}

PageTransition routeBuilder(Widget page) {
  return PageTransition(child: page, type: PageTransitionType.fade);
}

void routePage(BuildContext context, String query) {
  Navigator.of(context).pushNamed(query);
  customPrint("Route :: $query");
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

Future<void> delay(int time) async {
  await Future.delayed(Duration(milliseconds: time), () {});
}

int basicPageDelay = 1000;
int activityCount = 0;

Widget loadingWidget(
    [String msgTitle = "No Data Found.",
    String msgSubTitle = "No data found or slow internet connection.",
    String image = "images/noHistory.png"]) {
  return Center(
    child: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 10)),
        builder: (c, s) => s.connectionState == ConnectionState.done
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   image,
                  //   width: 55,
                  //   height: 55,
                  // ),
                  // const SizedBox(
                  //   height: 12,
                  // ),
                  Text(
                    msgTitle,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    msgSubTitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  )
                ],
              )
            : const CircularProgressIndicator()),
  );
}

List<String> dynamicToStatic(List projectClimate) {
  List<String> aa = [];
  for (int i = 0; i < projectClimate.length; i++) {
    aa.add(projectClimate[i].toString().trim());
  }
  return aa;
}

bool validateField(context, TextEditingController controller,
    [int validateLength = 0, String fieldType = "default"]) {
  if (controller.text.length > validateLength) {
    switch (fieldType) {
      case "default":
        return true;
      case "phone":
        if (controller.text.length == 10) {
          return true;
        }
        showErrorSnackBar("Phone number should be 10 digits",colorError);

        break;
      case "email":
        if (controller.text.contains(RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
          return true;
        }
        showErrorSnackBar("Provide correct email address",colorError);
        break;
      case "password":
        if (controller.text.length > 8) {
          return true;
        }
        showErrorSnackBar("Password should be 8 digits",colorError);
        break;
    }
  } else {
    showErrorSnackBar("Field Can't be empty...",colorError);
    return false;
  }
  return false;
}

Widget titleTextField(String s, TextEditingController nameController,
    [bool enable = true, final keyBoard = TextInputType.text]) {
  return Column(
    children: [
      Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            s,
            style: const TextStyle(fontSize: 18, color: colorDark),
          ),
        ),
      ),
      Container(
        height: 46,
        decoration: BoxDecoration(
            // color: global.colorLight,
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.only(left: 18, right: 18, top: 6),
        padding: const EdgeInsets.only(left: 14),
        child: TextFormField(
          enabled: enable,
          style: const TextStyle(fontSize: 18),
          controller: nameController,
          keyboardType: keyBoard,
          cursorColor: Colors.black45,
          // textAlign: TextAlign.center,
          decoration: new InputDecoration(
              border: InputBorder.none,
              hintText: " ",
              hintStyle: const TextStyle(color: Colors.grey)),
        ),
      ),
    ],
  );
}

RxBool actionRoom = false.obs;
RxString roomId = ''.obs;
RxString userId = ''.obs;
int selectedButtonIndex = 0;
RxBool dialogOpen = false.obs;
// RxBool isLoading = false.obs;
RxBool imgLoading = false.obs;

// RxBool dialogOpen = false.obs;
List<String> selectedOptionList = [];

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
const adminMail = 'admin@admin.com';
const _chars1 = '1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

String getRandomInt(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars1.codeUnitAt(_rnd.nextInt(_chars1.length))));

Future<bool> checkInternet() async {
  try {
    final result = await InternetAddress.lookup('www.google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      customPrint('connected');
      return Future.value(true);
    }
  } on SocketException catch (_) {
    customPrint('not connected');
    return Future.value(false);
  }
  return Future.value(false);
}

Future<void> copyToClipboard(context, copyText) async {
  await Clipboard.setData(ClipboardData(text: copyText));
  showSuccessSnackBar(null, '$copyText Copied to clipboard');
}

int getJsonLength(jsonText) {
  int len = 0;
  try {
    while (jsonText[len] != null) {
      len++;
    }
    // customPrint("Len :: $len");
  } catch (e) {
    // customPrint("Len Catch :: $len");
    return len;
  }
  return 0;
}

String stringToJson(String key, String value) {
  String dff = ("\"" + key + "\"\r" + ": \"" + value + "\"\r").toString();
  String jsonText = '"$key": "$value"';
  customPrint("Dff :: $jsonText");
  return jsonText;
}

bool debugMode = false;

checkDebugMode() {
  assert(() {
    debugMode = true;
    return true;
  }());
}

void customPrint(text) {
  if (debugMode) {
    if (kDebugMode) {
      print(text);
    }
  }
}

void customLog(text) {
  if (debugMode) {
    if (kDebugMode) {
      print(text);
    }
  }
}

String getStringCont(String cont) {
  return cont.replaceAll("+91", "").toString().trim();
}

int getStringInt(String text) {
  try {
    String data = "";
    data = text.replaceAll(RegExp(r'[^0-9]'), '');
    return int.parse(data);
  } catch (e) {
    return 0;
  }
}

class SplitArray {
  static List list1 = [];
  static List list2 = [];
  static List mergeList = [];

  static void split(List array, [String delim = "{}"]) {
    list1.clear();
    list2.clear();
    for (int i = 0; i < array.length; i++) {
      list1.add(array[i].toString().split(delim)[0]);
      list2.add(array[i].toString().split(delim)[1]);
    }
    customPrint("List 1 :: $list1");
    customPrint("List 2 :: $list2");
  }

  static void add(List array1, List array2, [String delim = "{}"]) {
    mergeList.clear();
    for (int i = 0; i < array1.length; i++) {
      mergeList.add(array1[i] + delim + array2[i]);
    }
  }
}

bool validateMyFields(BuildContext context,
    List<TextEditingController> controllerList, List<String> fieldsName) {
  for (int i = 0; i < controllerList.length; i++) {
    if (controllerList[i].text.trim().isEmpty) {
      showErrorSnackBar("${fieldsName[i].toString()} can't be empty",colorError);
      i = controllerList.length + 1;
      return false;
    }
  }
  return true;
}

// extension StringExtension on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
//   }
// }

String checkNull(String? text, [String res = "00"]) {
  if (text == null ||
      text.toString().trim() == "" ||
      text.toString().trim().isEmpty) {
    return res;
  }

  return text;
}

showConfirmDialog(BuildContext context, String messageKey, Function onYes) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(messageKey),
        content: Text("Do you really want to $messageKey?"),
        actions: [
          TextButton(
            child: const Text(
              "Yes",
              style: TextStyle(color: colorDark),
            ),
            onPressed: () {
              Navigator.pop(context);
              onYes();
            },
          ),
          TextButton(
            child: const Text(
              "No",
              style: TextStyle(color: colorDark),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}

clearTextEditingControllerArray(List<TextEditingController> controller) {
  for (int i = 0; i < controller.length; i++) {
    controller[i].clear();
  }
}

showSuccessDialog(BuildContext context, String messageKey, Function? onYes) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          width: 222,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                semanticContainer: true,
                elevation: 0,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                    borderRadius: constants.borderRadius * 100),
                margin: EdgeInsets.zero,
                color: colorSuccess,
                child: const Padding(
                  padding: EdgeInsets.all(constants.defaultPadding),
                  child: Icon(
                    Icons.done,
                    color: colorWhite,
                    size: 55,
                  ),
                ),
              ),
              const SizedBox(
                height: constants.defaultPadding,
              ),
              Text("You have successfully $messageKey"),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              "Ok",
              style: TextStyle(color: colorDark),
            ),
            onPressed: () async {
              Navigator.pop(context);
              if (onYes != null) {
                onYes();
              }
            },
          ),
        ],
      );
    },
  );
}

List<String> stringToList(String str, [String delim = ","]) {
  String removedBrackets = str.replaceAll("[", "");
  removedBrackets = removedBrackets.replaceAll("]", "");
  List<String> parts = removedBrackets.split(delim);
  parts.remove("");
  customPrint("parts :: $parts");
  return parts;
}

String stringToListString(String str, [String delim = ","]) {
  String removedBrackets = str.replaceAll("[", "");
  removedBrackets = removedBrackets.replaceAll("]", "");
  List<String> parts = removedBrackets.split(delim);
  parts.remove("");
  customPrint("parts :: $parts");
  return removedBrackets;
}

String listToString(List list) {
  String data = "";
  for (int i = 0; i < list.length; i++) {
    data = "$data${list[i]},";
  }

  customPrint("listToString :: $data");

  return data;
}

bool kIsValidEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool kIsValidDouble(String value) {
  bool ans = false;
  try {
    double.parse(value);
    ans = true;
  } on Exception catch (e) {
    ans = false;
  }
  return ans;
}

bool kIsValidTimeslot(String value, [bool range = false]) {
  if (value.toLowerCase().contains("am") ||
      value.toLowerCase().contains("pm")) {
    return false;
  }

  if (getStringInt(value).toString().length != 4 && !range) {
    return false;
  }
  if (!value.contains(":")) {
    return false;
  }

  if (range) {
    if (!value.contains("-")) {
      return false;
    }
  }

  return true;
}

bool kIsValidCourtDuration(String value) {
  if (value != "Km" && value != "Mt") {
    return false;
  }
  return true;
}

String addZero(val) {
  int value = int.parse(val.toString());
  if (value < 10) {
    return "0$value";
  }
  return "$value";
}

List<String> apiKeyList = [
  "c7967fa0-1a4e-4eda-aed4-f2335fa3ca1a",
  "4cd15d28-95fa-4c8d-87eb-121af613dfce",
  "9da45650-69eb-47fc-b411-9e37b7a176fa",
  "b3ee8410-2453-4496-9031-197123e01abf"
      "b3ee8410-2453-4496-9031-197123e01abf"
];

String getRandomCrickDataApiKey() {
  String key = apiKeyList[Random().nextInt(apiKeyList.length)];
  customPrint("getRandomCrickDataApiKey :: $key");
  return key;
}

int calculateTotalMarks({required String totalMarks}) {
  List<String> marks = totalMarks.split(',');
  int sum = 0;
  for (int i = 0; i < marks.length; i++) {
    sum = sum + int.parse(marks[i]);
  }
  return sum;
}



final List<String> tabTitles = [
  'DASHBOARD',
  'USERS',
  'STORIES',
  'CHAPTERS',
  'ACTIVITIES',
  'CHARACTERS',
  'Logout'
  // 'Characters',
  // 'Activities',
  // 'Flash Cards',
  // 'Lesson Plans',
  // 'Report',
  // 'Logout'
];
final List<String> tabIcons = [
  'icons/side_dashboard.svg',
  'icons/side_student.svg',
  'icons/bookStory.svg',
  'icons/chapters.svg',
  'icons/side_micro.svg',
  'icons/charat.svg',
  'icons/logout.svg',
  // 'icons/side_final.svg',
  // 'icons/side_video.svg',
  // 'icons/side_flashcard.svg',
  // 'icons/side_plan.svg',
  // 'icons/side_report.svg',
];
 List<String> adminRoute = [
  Routes.dashboard,
  Routes.users,
  Routes.stories,
  Routes.chapters,
  Routes.activities,
  Routes.characters,
  // Routes.finalexam,
  // Routes.lessonvideo,
  // Routes.flashcard,
  // Routes.lessonplan,
  // Routes.report,
  // Routes.logout,
];