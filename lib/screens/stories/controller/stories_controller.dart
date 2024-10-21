import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yokai_admin/api/local_storage.dart';
import 'package:yokai_admin/main.dart';
import 'package:yokai_admin/utils/colors.dart';

import '../../../api/database.dart';
import '../../../globalVariable.dart';
import '../../../model/get_all_stories.dart';
import '../../../model/get_story_by_id.dart';

class StoriesController {
  static String date = "Date";
  static final RxList<String> dateList = RxList<String>.of(["Date"]);
  static String chapters = "Chapters";
  static final RxList<String> chaptersList = RxList<String>.of(["Chapters"]);
  static String activities = "Activities";
  static final RxList<String> activitiesList =
      RxList<String>.of(["Activities"]);

  //
  static String dateEdit = "Date";
  static final RxList<String> dateEditList = RxList<String>.of(["Date"]);
  static String chapter = "Chapter No.";
  static final RxList<String> chapterList = RxList<String>.of(["Chapter No."]);
  static String activity = "Activity";
  static final RxList<String> activityList = RxList<String>.of(["Activity"]);
  static String character = "Jerome";
  static final RxList<String> characterList = RxList<String>.of(["Jerome"]);

  static RxInt storiesPage = 0.obs;
  static RxInt characterCountTitle = 0.obs;
  static RxInt characterCountDescription = 0.obs;
  static RxBool isEdit = false.obs;
  static final TextEditingController searchStoriesController = TextEditingController();


  static final TextEditingController titleController = TextEditingController();
  static final TextEditingController descriptionController =
      TextEditingController();
  static RxString storyId = ''.obs;


  static Future<bool> createStories(context, body) async {
    final String url = "${DatabaseApi.createStories}";
    customPrint("createStories url:: $url");
    customPrint("createStories body:: ${jsonEncode(body)}");

    final headers = {
      "Content-Type": "application/json",
      "AdminToken": "${prefs?.getString(LocalStorage.token)}",
    };
    try {
      return await http
          .post(Uri.parse(url), headers: headers, body: json.encode(body))
          .then((value) async {
        final jsonData = json.decode(value.body);
        print("createStories response:: ${jsonEncode(jsonData)}");
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
  static RxString storyIdForUpdateStory = ''.obs;
  static Future<bool> updateStories(context, String storiesId, body) async {
    final String url = "${DatabaseApi.updateStories}$storiesId";
    customPrint("updateStories url:: $url");
    customPrint("updateStories body:: ${jsonEncode(body)}");

    final headers = {
      "Content-Type": "application/json",
      "AdminToken": "${prefs?.getString(LocalStorage.token)}",
    };
    try {
      return await http
          .put(Uri.parse(url), headers: headers, body: json.encode(body))
          .then((value) async {
        final jsonData = json.decode(value.body);
        print("updateStories response:: ${jsonEncode(jsonData)}");
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

  static Future<bool>  deleteStories(
      BuildContext context, String storyId) async {
    final headers = {
      "Content-Type": "application/json",
      "AdminToken": "${prefs?.getString(LocalStorage.token)}",
    };
    String url = "${DatabaseApi.deleteStories}$storyId";
    customPrint("deleteStories URL :: $url");
    try {
      return await http.delete(Uri.parse(url), headers: headers).then((value) {
        customPrint("deleteStories :: ${value.body}");
        final jsonData = jsonDecode(value.body);
        if (value.statusCode != 200) {
          showErrorSnackBar(jsonData["message"].toString(), colorError);
          return false;
        }
        showSuccessSnackBarIcon(jsonData["message"].toString(), colorSuccess);
        return true;
      });
    } on Exception catch (e) {
      customPrint("deleteStories  :: $e");
      showSuccessSnackBarIcon("delete ", colorError);
      return false;
    }
  }

  static Rx<GetStoryById> getStoriesById = GetStoryById().obs;
  static Rx<GetAllStory> getAllStoriesBy = GetAllStory().obs;

  static Future<bool> getStoryByStoriesId(String storiesId) async {
    final headers = {
      "Content-Type": "application/json",
      "UserToken": '${prefs?.getString(LocalStorage.token).toString()}'
    };
    final String url = '${DatabaseApi.getStoriesByStoryId}$storiesId';
    customPrint("getStoryByStoryId url :: $url");
    try {
      return await http
          .get(Uri.parse(url), headers: headers)
          .then((value) async {
        print("getStoryByStoryId :: ${value.body}");
        final jsonData = jsonDecode(value.body);
        if (jsonData["status"].toString() != "true") {
          showErrorSnackBar(jsonData["message"].toString(), colorError);
          return false;
        }
        //showSnackbar("Subscription PlanPrice Details Added Successfully", colorSuccess);
        getStoriesById(getStoryByIdFromJson(value.body));
        return true;
      });
    } on Exception catch (e) {
      print("getStoryByStoryId:: $e");
      // showSnackbar("Some unknown error has occur, try again after some time!", colorError);
      return false;
    }
  }

  static Future<bool> getAllStory(String search) async {
    final headers = {
      "Content-Type": "application/json",
      // "UserToken": '${prefs?.getString(LocalStorage.token).toString()}'
      "AdminToken": '${prefs?.getString(LocalStorage.token).toString()}'
    };
    final String url = '${DatabaseApi.getStories}?search=$search';
    customPrint("getAllStory url :: $url");
    try {
      return await http
          .get(Uri.parse(url), headers: headers)
          .then((value) async {
        print("getAllStory :: ${value.body}");
        final jsonData = jsonDecode(value.body);
        if (jsonData["status"].toString() != "true") {
          showErrorSnackBar(jsonData["message"].toString(), colorError);
          return false;
        }
        //showSnackbar("Subscription PlanPrice Details Added Successfully", colorSuccess);
        getAllStoriesBy(getAllStoryFromJson(value.body));
        return true;
      });
    } on Exception catch (e) {
      print("getAllStory:: $e");
      // showSnackbar("Some unknown error has occur, try again after some time!", colorError);
      return false;
    }
  }

  static Future getAllStoriesData() async {
    await getAllStory('').then((value) {
    });
  }

  static Future getStoriesDataById(String storyId) async {
    await getStoryByStoriesId(storyId).then((value) {
    });
  }

  // static RxBool loadingImage = false.obs;
  static Uint8List? _fileBytesImage;
  static String? _fileNameImage;
  static RxString uploadUrlImage = ''.obs;
  static RxString uploadUrlImageUrl = ''.obs;
  static RxString uploadUrlImageUrlEdit = ''.obs;
  static RxString selectUrlImage = ''.obs;

  static Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      // Handle the picked video file
      // setState(() {
      _fileBytesImage = result.files.single.bytes;
      _fileNameImage = result.files.single.name;
      selectUrlImage("$_fileNameImage");
      uploadUrlImage.value = _fileNameImage!;
      // });
    } else {
      // Handle no video picked
      print('No video selected.');
      _fileBytesImage = null;
      _fileNameImage = '';
      selectUrlImage("$_fileNameImage");
      uploadUrlImage.value = _fileNameImage!;
      return;
    }
  }

  static Future<void> uploadImage() async {
    if (_fileBytesImage == null) {
      return;
    }
    // isLoading(true);
    final url = Uri.parse(DatabaseApi.uploadDocument);

    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(
        http.MultipartFile.fromBytes(
          'images',
          _fileBytesImage!,
          filename: _fileNameImage!,
        ),
      );
      customPrint("BITES ${_fileBytesImage!.buffer.lengthInBytes}");
      // isLoading(true);
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        final jsonData = json.decode(responseBody);
        uploadUrlImage('');
        uploadUrlImage(jsonData['image_urls']
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll("{", '')
            .replaceAll("}", '')
            .replaceAll("url:", '')
            .replaceAll(" /", ''));
        // isLoading(false);
        customPrint('images uploaded successfully!  ${responseBody}');
        customPrint('images uploaded successfully  ${uploadUrlImage.value}');
        // isLoading(false);
        showSuccessSnackBar('icons/check.svg', 'File uploaded successfully!');
      } else {
        customPrint(
            'Failed to upload file. Status code: ${response.statusCode}');
      }
    } catch (e) {
      customPrint('Error uploading file: $e');
    }
  }
}
