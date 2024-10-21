import 'dart:convert';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../api/database.dart';
import '../../../api/local_storage.dart';
import '../../../globalVariable.dart';
import '../../../main.dart';
import '../../../model/get_activity_by_activity_id.dart';
import '../../../model/get_all_activity.dart';
import '../../../utils/colors.dart';

class ActivitiesController{
  //
  static String storyChapter = "Select";
  static RxString storyChapterForSearch = "".obs;
  static final RxList<String> storyListChapter = RxList<String>.of(["Select"]);
  static final RxString storyIdStringChapter = ''.obs;
  static final RxList<String> storyIdChapter = RxList<String>.of([]);
  //
  static final TextEditingController searchActivityController = TextEditingController();
  //
  static RxInt activitiesPage = 0.obs;
  static RxString activityIdForEditActivity = ''.obs;
  static RxInt activityCountTitle = 0.obs;
  static RxInt activityCountDescription = 0.obs;
  static RxBool isEdit = false.obs;
  static String date = "Date";
  static final RxList<String> dateList = RxList<String>.of(["Date"]);
  static String chapterNo = "Chapter No.";
  static final RxList<String> chapterNoList = RxList<String>.of(["Chapter No."]);

  static String story = "The mystery deepens in wonderland";
  static final RxList<String> storyList = RxList<String>.of(["The mystery deepens in wonderland"]);
  static final RxList<String> storyId = RxList<String>.of([]);
  static final RxString storyIdString = ''.obs;

  static String chapter = "Select";
  static final RxList<String> chaptersList = RxList<String>.of(["Select"]);
  static final RxList<String> chapterId = RxList<String>.of([]);
  static final RxString chapterIdString = ''.obs;

  static final TextEditingController titleController = TextEditingController();
  static final TextEditingController timeController = TextEditingController();
  static final TextEditingController descriptionController = TextEditingController();

  static final RxString responseActivityId = ''.obs;


  static Future<bool> createActivity(context, body) async {
    final String url = "${DatabaseApi.createActivity}";
    customPrint("createActivity url:: $url");
    customPrint("createActivity body:: ${jsonEncode(body)}");
    responseActivityId('');
    final headers = {
      "Content-Type": "application/json",
      "AdminToken": "${prefs?.getString(LocalStorage.token)}",
    };
    try {
      return await http
          .post(Uri.parse(url), headers: headers, body: json.encode(body))
          .then((value) async {
        final jsonData = json.decode(value.body);
        print("createActivity response:: ${jsonEncode(jsonData)}");
        if (value.statusCode != 200) {
          showErrorSnackBar(jsonData["message"].toString(), colorError);
          return false;
        } else if (jsonData["status"] == "false") {
          showErrorSnackBar(jsonData["message"].toString(), colorError);
          return false;
        }
// getbackTestingStock(getBackTestingStockFromJson(value.body));
        responseActivityId(jsonData["data"]["id"].toString());
        customPrint("responseActivityId :: ${responseActivityId.value}");
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

  static Future<bool> updateActivityById(
      context, body, String activityId) async {
    final String url = "${DatabaseApi.updateActivity}$activityId";
    customPrint("updateActivityById url:: $url");
    customPrint("updateActivityById body:: ${jsonEncode(body)}");
    customPrint("token :: ${prefs?.getString(LocalStorage.token)}");
    responseActivityId('');
    final headers = {
      "accept": "application/json",
      "AdminToken": "${prefs?.getString(LocalStorage.token)}",
      "Content-Type": "application/json"
    };
    try {
      return await http
          .put(Uri.parse(url), headers: headers, body: json.encode(body))
          .then((value) async {
        final jsonData = json.decode(value.body);
        print("updateActivityById response:: ${jsonEncode(jsonData)}");
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

  static Future<bool> updateActivityDetailsById(
      context, body, String activityId) async {
    final String url = "${DatabaseApi.updateActivityDetailsById}$activityId";
    customPrint("updateActivityDetailsById url:: $url");
    customPrint("updateActivityDetailsById body:: ${jsonEncode(body)}");
    customPrint("token :: ${prefs?.getString(LocalStorage.token)}");
    responseActivityId('');
    final headers = {
      "accept": "application/json",
      "AdminToken": "${prefs?.getString(LocalStorage.token)}",
      "Content-Type": "application/json"
    };
    try {
      return await http
          .put(Uri.parse(url), headers: headers, body: json.encode(body))
          .then((value) async {
        final jsonData = json.decode(value.body);
        print("updateActivityDetailsById response:: ${jsonEncode(jsonData)}");
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
  static Future<List<Map<String, dynamic>>> convertFileToJson(
      Uint8List bytes, String fileName) async
  {
    try {
      List<List<dynamic>> rows;
      if (fileName.endsWith('.csv')) {
        String content = utf8.decode(bytes);
        rows = CsvToListConverter().convert(content);
      } else {
        print('Unsupported file format: $fileName');
        return [];
      }

      List<String> headers = rows[0].map((cell) => cell.toString()).toList();
      List<Map<String, dynamic>> jsonData = [];
      List<Map<String, dynamic>> requestBodyList = [];
      Map<String, dynamic>? currentQuestion;

      for (var i = 1; i < rows.length; i++) {
        var row = rows[i];
        Map<String, dynamic> data = {};

        for (var j = 0; j < headers.length; j++) {
          // data[headers[j]] = row[j].toString().replaceAll(",", ";");
          data[headers[j]] = row[j].toString();
          customPrint("data :: ${data}");

        }

        if (data['Questions'] != '') {
          if (currentQuestion != null) {
            jsonData.add({
              'Questions': currentQuestion['Questions'],
              'Options': currentQuestion['Options'],
              'explanation': currentQuestion['explanation'],
              'correct_answer': currentQuestion['correct_answer']
            });
            customPrint("jsonData :: ${jsonData}");
          }
          currentQuestion = {
            'Questions': data['Questions'],
            'Options': data['Options'],
            'explanation': data['explanation'],
            'correct_answer': data['correct_answer']
          };
          customPrint("currentQuestion :: ${currentQuestion}");

        } else {
          currentQuestion!['Options'] += '; ${data['Options']}';
        }
      }

      if (currentQuestion != null) {
        jsonData.add({
          'Questions': currentQuestion['Questions'],
          'Options': currentQuestion['Options'],
          'explanation': currentQuestion['explanation'],
          'correct_answer': currentQuestion['correct_answer']
        });
      }

      // Encode the jsonData to JSON string
      String jsonString = jsonEncode(jsonData);

      // Decode the JSON string back to List<Map<String, dynamic>>
      List<Map<String, dynamic>> decodedJsonData =
          (jsonDecode(jsonString) as List)
              .map((item) => item as Map<String, dynamic>)
              .toList();

      for (var item in decodedJsonData) {
        List<String> options = item['Options'].split(';');

        Map<String, String> optionKeys = {
          "option_a": encodeApiString(
              inputString: options.isNotEmpty ? options[0].trim() : ""),
          "option_b": encodeApiString(
              inputString: options.isNotEmpty ? options[1].trim() : ""),
          "option_c": encodeApiString(
              inputString: options.isNotEmpty ? options[2].trim() : ""),
          "option_d": encodeApiString(
              inputString: options.isNotEmpty ? options[3].trim() : ""),
        };
// String explanation = item["correct_answer"].toString().r
        customPrint("encodeExplanation :: ${item['explanation']}");
        String encodeAnswer =
            encodeApiString(inputString: "${item["correct_answer"]}");
        customPrint("encodeAnswer :: $encodeAnswer");
        Map<String, dynamic> requestBody = {
          "activity_id": ActivitiesController.responseActivityId.value,
          "question": encodeApiString(inputString: item["Questions"]),
          ...optionKeys,
          "explation": encodeApiString(inputString: item["explanation"]),
          "correct_answer": encodeAnswer
        };
        requestBodyList.add(requestBody);

        ///body for print
        Map<String, dynamic> requestBodyForPrint = {
          "activity_id": ActivitiesController.responseActivityId.value,
          "question": item["Questions"],
          "option_a": options.isNotEmpty ? options[0].trim() : "",
          "option_b": options.isNotEmpty ? options[1].trim() : "",
          "option_c": options.isNotEmpty ? options[2].trim() : "",
          "option_d": options.isNotEmpty ? options[3].trim() : "",
          "explation": item["explanation"],
          "correct_answer": item["correct_answer"]
        };
        customPrint('requestBodyPrint :: ${requestBodyForPrint}');
      }

      print('requestBodyList :: ${requestBodyList.length}');

      for (var requestBody in requestBodyList) {
        await ActivitiesController.createActivityDetails(requestBody);
      }
      return decodedJsonData;
    } catch (e) {
      print('Error during file conversion: $e');
      return [];
    }
  }

/// data encode decode
  static String encodeApiString({required String inputString}) {
    List<int> encoded = utf8.encode(inputString);
    return encoded.toString();
  }
  static String decodeApiString({required String hexString}) {
    customPrint('decoded List before :: $hexString');
    try {
      List<int> hexValues = hexString
          .replaceAll('[', '')
          .replaceAll(']', '')
          .split(',')
          .map((e) => int.parse(e.trim()))
          .toList();
      customPrint('decoded List after:: $hexValues');

      String decoded = utf8.decode(hexValues);
      customPrint('decoded testing :: $decoded');
      return decoded;
    } catch (e) {
      print('Error decoding API string: $e');
      return 'Error decoding API string : $e';
    }
  }
  ///


  static Future<bool> createActivityDetails( body) async {
    final String url = "${DatabaseApi.createActivityDetails}";
    customPrint("createActivityDetails url:: $url");
    print("createActivityDetails body:: ${jsonEncode(body)}");

    final headers = {
      "accept": "application/json",
      "AdminToken": "${prefs?.getString(LocalStorage.token)}",
      "Content-Type": "application/json"
    };
    try {
      return await http
          .post(Uri.parse(url), headers: headers, body: json.encode(body))
          .then((value) async {
        final jsonData = json.decode(value.body);
        print("createActivityDetails response:: ${jsonEncode(jsonData)}");
        if (value.statusCode != 200) {
          showErrorSnackBar(jsonData["message"].toString(), colorError);
          return false;
        } else if (jsonData["status"] == "false") {
          showErrorSnackBar(jsonData["message"].toString(), colorError);
          return false;
        }
// getbackTestingStock(getBackTestingStockFromJson(value.body));
        customPrint(jsonData["message"].toString());
        // showSnackbar(jsonData["message"].toString(), colorSuccess);
        return true;
      });
    } on Exception catch (e) {
      customPrint("Error :: $e");
// showSnackbar(context,
// "Some unknown error has occur, try again after some time", colorRed);
      return false;
    }
  }

  static Future<bool> updateActivity(context, String activityId,body) async {
    final String url = "${DatabaseApi.updateActivity}$activityId";
    customPrint("updateActivity url:: $url");
    customPrint("updateActivity body:: ${jsonEncode(body)}");

    final headers = {
      "Content-Type": "application/json",
      "AdminToken": "${prefs?.getString(LocalStorage.token)}",
    };
    try {
      return await http
          .put(Uri.parse(url), headers: headers, body: json.encode(body))
          .then((value) async {
        final jsonData = json.decode(value.body);
        print("updateActivity response:: ${jsonEncode(jsonData)}");
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

  static Future<bool>  deleteActivity(
      BuildContext context, String activityId) async {
    final headers = {
      "Content-Type": "application/json",
      "AdminToken": "${prefs?.getString(LocalStorage.token)}",
    };
    String url = "${DatabaseApi.deleteActivityById}$activityId";
    customPrint("deleteActivity URL :: $url");
    try {
      return await http.delete(Uri.parse(url), headers: headers).then((value) {
        customPrint("deleteActivity :: ${value.body}");
        final jsonData = jsonDecode(value.body);
        if (value.statusCode != 200) {
          showErrorSnackBar(jsonData["message"].toString(), colorError);
          return false;
        }
        showSuccessSnackBarIcon(jsonData["message"].toString(), colorSuccess);
        return true;
      });
    } on Exception catch (e) {
      customPrint("deleteActivity  :: $e");
      showErrorSnackBar("delete ", colorError);
      return false;
    }
  }

  static Future<bool> deleteActivityDetailsByDetailId(
      BuildContext context, String activityDetailId) async {
    final headers = {
      "Content-Type": "application/json",
      "AdminToken": "${prefs?.getString(LocalStorage.token)}",
    };
    String url = "${DatabaseApi.deleteActivityDetailById}$activityDetailId";
    customPrint("AdminToken :: ${prefs?.getString(LocalStorage.token)}");
    customPrint("deleteActivityDetailsById URL :: $url");
    try {
      return await http.delete(Uri.parse(url), headers: headers).then((value) {
        customPrint("deleteActivityDetailsById :: ${value.body}");
        final jsonData = jsonDecode(value.body);
        if (value.statusCode != 200) {
          showErrorSnackBar(jsonData["message"].toString(), colorError);
          return false;
        }
        showSuccessSnackBarIcon(jsonData["message"].toString(), colorSuccess);
        return true;
      });
    } on Exception catch (e) {
      customPrint("deleteActivityDetailsById  :: $e");
      showSuccessSnackBarIcon("delete ", colorError);
      return false;
    }
  }

  ///pick cover image
  static Uint8List? _fileBytesImageCover;
  static String? _fileNameImageCover;
  static RxString uploadUrlImageCover = ''.obs;
  static RxString uploadUrlImageUrlCover = ''.obs;
  static RxString uploadUrlImageUrlEditCover = ''.obs;
  static RxString selectUrlImageCover = ''.obs;

  static Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      // Handle the picked video file
      // setState(() {
      _fileBytesImageCover = result.files.single.bytes;
      _fileNameImageCover = result.files.single.name;
      selectUrlImageCover("$_fileNameImageCover");
      uploadUrlImageCover.value = _fileNameImageCover!;
      // });
    } else {
      // Handle no video picked
      print('No video selected.');
      _fileBytesImageCover = null;
      _fileNameImageCover = '';
      selectUrlImageCover("$_fileNameImageCover");
      uploadUrlImageCover.value = _fileNameImageCover!;
      return;
    }
  }

  static Future<void> uploadImage() async {
    if (_fileBytesImageCover == null) {
      print('return');
      return;
    }
    print('return :: not');
    // isLoading(true);
    final url = Uri.parse(DatabaseApi.uploadDocument);

    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(
        http.MultipartFile.fromBytes(
          'images',
          _fileBytesImageCover!,
          filename: _fileNameImageCover!,
        ),
      );
      customPrint("BITES ${_fileBytesImageCover!.buffer.lengthInBytes}");
      // isLoading(true);
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        final jsonData = json.decode(responseBody);
        uploadUrlImageCover('');
        uploadUrlImageCover(jsonData['image_urls']
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll("{", '')
            .replaceAll("}", '')
            .replaceAll("url:", '')
            .replaceAll(" /", ''));
        // isLoading(false);
        customPrint('images uploaded successfully!  ${responseBody}');
        customPrint(
            'images uploaded successfully  ${uploadUrlImageCover.value}');
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

  ///pick cover image
  static Uint8List? _fileBytesImageEng;
  static String? _fileNameImageEng;
  static RxString uploadUrlImageEng = ''.obs;
  static RxString uploadUrlImageUrlEng = ''.obs;
  static RxString uploadUrlImageUrlEditEng = ''.obs;
  static RxString selectUrlImageEng = ''.obs;
  static RxString selectFileNameImageEng = ''.obs;

  static Future<void> pickFileEngCsv() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['xlsx', 'csv']);

    if (result != null && result.files.single.bytes != null) {

      Uint8List fileBytes = result.files.single.bytes!;
      String fileName = result.files.single.name;
      PlatformFile file = result.files.first;
      filePath = file.bytes;
      print("fileBytes :: $fileBytes");
      print("fileName :: $fileName");
      _fileBytesImageEng = result.files.single.bytes;
      _fileNameImageEng = result.files.single.name;
      selectUrlImageEng("$_fileNameImageEng");
      uploadUrlImageEng.value = _fileNameImageEng!;
      selectFileNameImageEng(file.name);
    } else {
      // User canceled the picker
      print('File picking cancelled');
    }
  }

  static Future<void> uploadEngCsv() async {
    if (_fileBytesImageEng == null) {
      return;
    }
    // isLoading(true);
    final url = Uri.parse(DatabaseApi.uploadDocument);

    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(
        http.MultipartFile.fromBytes(
          'images',
          _fileBytesImageEng!,
          filename: _fileNameImageEng!,
        ),
      );
      customPrint("BITES ${_fileBytesImageEng!.buffer.lengthInBytes}");
      // isLoading(true);
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        final jsonData = json.decode(responseBody);
        uploadUrlImageEng('');
        uploadUrlImageEng(jsonData['image_urls']
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll("{", '')
            .replaceAll("}", '')
            .replaceAll("url:", '')
            .replaceAll(" /", ''));
        // isLoading(false);
        customPrint('images uploaded successfully!  ${responseBody}');
        customPrint('images uploaded successfully  ${uploadUrlImageEng.value}');
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

  ///pick cover image
  static Uint8List? _fileBytesImageJap;
  static String? _fileNameImageJap;
  static RxString uploadUrlImageJap= ''.obs;
  static RxString uploadUrlImageUrlJap = ''.obs;
  static RxString uploadUrlImageUrlEditJap = ''.obs;
  static RxString selectUrlImageJap = ''.obs;
  static RxString selectFileNameImageJap = ''.obs;

  static Future<void> pickFileJapCsv() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['xlsx', 'csv']);

    if (result != null && result.files.single.bytes != null) {
      Uint8List fileBytes = result.files.single.bytes!;
      String fileName = result.files.single.name;
      PlatformFile file = result.files.first;
      print("fileBytes :: $fileBytes");
      print("fileName :: $fileName");
      _fileBytesImageJap = result.files.single.bytes;
      _fileNameImageJap = result.files.single.name;
      selectUrlImageJap("$_fileNameImageJap");
      uploadUrlImageJap.value = _fileNameImageJap!;
      selectFileNameImageJap(file.name);
    } else {
      // User canceled the picker
      print('File picking cancelled');
    }
  }

  static Future<void> uploadJapCsv() async {
    if (_fileBytesImageJap == null) {
      return;
    }
    // isLoading(true);
    final url = Uri.parse(DatabaseApi.uploadDocument);

    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(
        http.MultipartFile.fromBytes(
          'images',
          _fileBytesImageJap!,
          filename: _fileNameImageJap!,
        ),
      );
      customPrint("BITES ${_fileBytesImageJap!.buffer.lengthInBytes}");
      // isLoading(true);
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        final jsonData = json.decode(responseBody);
        uploadUrlImageJap('');
        uploadUrlImageJap(jsonData['image_urls']
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll("{", '')
            .replaceAll("}", '')
            .replaceAll("url:", '')
            .replaceAll(" /", ''));
        // isLoading(false);
        customPrint('images uploaded successfully!  ${responseBody}');
        customPrint('images uploaded successfully  ${uploadUrlImageJap.value}');
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


  ///pick stamp image
  static Uint8List? _fileBytesImageStamp;
  static String? _fileNameImageStamp;
  static RxString uploadUrlImageStamp = ''.obs;
  static RxString uploadUrlImageUrlStamp = ''.obs;
  static RxString uploadUrlImageUrlEditStamp = ''.obs;
  static RxString selectUrlImageStamp = ''.obs;


  static Future<void> pickStampImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      // Handle the picked video file
      // setState(() {
      _fileBytesImageStamp = result.files.single.bytes;
      _fileNameImageStamp = result.files.single.name;
      selectUrlImageStamp("$_fileNameImageStamp");
      uploadUrlImageStamp.value = _fileNameImageStamp!;
      // });
    } else {
      // Handle no video picked
      print('No video selected.');
      _fileBytesImageStamp = null;
      _fileNameImageStamp = '';
      selectUrlImageStamp("$_fileNameImageStamp");
      uploadUrlImageStamp.value = _fileNameImageStamp!;
      return;
    }
  }

  static Future<void> uploadStampImage() async {
    if (_fileBytesImageStamp == null) {
      print('return');
      return;
    }
    print('return :: not');
    // isLoading(true);
    final url = Uri.parse(DatabaseApi.uploadDocument);

    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(
        http.MultipartFile.fromBytes(
          'images',
          _fileBytesImageStamp!,
          filename: _fileNameImageStamp!,
        ),
      );
      customPrint("BITES ${_fileBytesImageStamp!.buffer.lengthInBytes}");
      // isLoading(true);
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        final jsonData = json.decode(responseBody);
        uploadUrlImageStamp('');
        uploadUrlImageStamp(jsonData['image_urls']
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll("{", '')
            .replaceAll("}", '')
            .replaceAll("url:", '')
            .replaceAll(" /", ''));
        // isLoading(false);
        customPrint('images uploaded successfully!  ${responseBody}');
        customPrint(
            'images uploaded successfully  ${uploadUrlImageStamp.value}');
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



  ///pick stamp Audio
  static Uint8List? _fileBytesAudioStamp;
  static String? _fileNameAudioStamp;
  static RxString uploadUrlAudioStamp = ''.obs;
  static RxString uploadUrlAudioUrlStamp = ''.obs;
  static RxString uploadUrlAudioUrlEditStamp = ''.obs;
  static RxString selectUrlAudioStamp = ''.obs;
  static RxString selectFileNameAudioStamp = ''.obs;


  static Future<void> pickStampAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,  // Change to allow only audio files
    );

    if (result != null) {
      // Handle the picked audio file
      selectFileNameAudioStamp('');
      _fileBytesAudioStamp = result.files.single.bytes;
      _fileNameAudioStamp = result.files.single.name;
      selectUrlAudioStamp(_fileNameAudioStamp);
      uploadUrlAudioStamp.value = _fileNameAudioStamp!;
      customPrint("_fileNameAudioStamp ::  $_fileNameAudioStamp");
      selectFileNameAudioStamp(_fileNameAudioStamp);
    } else {
      // Handle no audio picked
      print('No audio selected.');
      _fileBytesAudioStamp = null;
      _fileNameAudioStamp = '';
      selectUrlAudioStamp(_fileNameAudioStamp);
      uploadUrlAudioStamp.value = _fileNameAudioStamp!;
      return;
    }
  }

  static Future<void> uploadStampAudio() async {
    if (_fileBytesAudioStamp == null) {
      print('return');
      return;
    }
    print('return :: not');
    // isLoading(true);
    final url = Uri.parse(DatabaseApi.uploadDocument);

    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(
        http.MultipartFile.fromBytes(
          'images',
          _fileBytesAudioStamp!,
          filename: _fileNameAudioStamp!,
        ),
      );
      customPrint("BITES ${_fileBytesAudioStamp!.buffer.lengthInBytes}");
      // isLoading(true);
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        final jsonData = json.decode(responseBody);
        uploadUrlAudioStamp('');
        uploadUrlAudioStamp(jsonData['image_urls']
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll("{", '')
            .replaceAll("}", '')
            .replaceAll("url:", '')
            .replaceAll(" /", ''));
        // isLoading(false);
        customPrint('images uploaded successfully!  ${responseBody}');
        customPrint(
            'images uploaded successfully  ${uploadUrlAudioStamp.value}');
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



  ///pick end image
  static Uint8List? _fileBytesImageEnd;
  static String? _fileNameImageEnd;
  static RxString uploadUrlImageEnd = ''.obs;
  static RxString uploadUrlImageUrlEnd = ''.obs;
  static RxString uploadUrlImageUrlEditEnd = ''.obs;
  static RxString selectUrlImageEnd = ''.obs;


  static Future<void> pickEndImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      // Handle the picked video file
      // setState(() {
      _fileBytesImageEnd = result.files.single.bytes;
      _fileNameImageEnd = result.files.single.name;
      selectUrlImageEnd("$_fileNameImageEnd");
      uploadUrlImageEnd.value = _fileNameImageEnd!;
      // });
    } else {
      // Handle no video picked
      print('No video selected.');
      _fileBytesImageEnd = null;
      _fileNameImageEnd = '';
      selectUrlImageEnd("$_fileNameImageEnd");
      uploadUrlImageEnd.value = _fileNameImageEnd!;
      return;
    }
  }

  static Future<void> uploadEndImage() async {
    if (_fileBytesImageEnd == null) {
      print('return');
      return;
    }
    print('return :: not');
    // isLoading(true);
    final url = Uri.parse(DatabaseApi.uploadDocument);

    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(
        http.MultipartFile.fromBytes(
          'images',
          _fileBytesImageEnd!,
          filename: _fileNameImageEnd!,
        ),
      );
      customPrint("BITES ${_fileBytesImageEnd!.buffer.lengthInBytes}");
      // isLoading(true);
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        final jsonData = json.decode(responseBody);
        uploadUrlImageEnd('');
        uploadUrlImageEnd(jsonData['image_urls']
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll("{", '')
            .replaceAll("}", '')
            .replaceAll("url:", '')
            .replaceAll(" /", ''));
        // isLoading(false);
        customPrint('images uploaded successfully!  ${responseBody}');
        customPrint(
            'images uploaded successfully  ${uploadUrlImageEnd.value}');
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



  static Rx<GetAllActivity> getActivityAll =
      GetAllActivity().obs;

  static Future<bool> getAllActivity(String search, String storyId) async {
    final headers = {
      "Content-Type": "application/json",
      "AdminToken": '${prefs?.getString(LocalStorage.token).toString()}'
    };
    final String url =
        '${DatabaseApi.getAllActivity}${(search != '') ? '?search=$search' : ''}${(search == '' && storyId != '') ? '?story_id=$storyId' : (storyId != '') ? '&story_id=$storyId' : ''}';
    customPrint("getAllActivity url :: $url");
    try {
      return await http
          .get(Uri.parse(url), headers: headers)
          .then((value) async {
        print("getAllActivity :: ${value.body}");
        final jsonData = jsonDecode(value.body);
        if (jsonData["status"].toString() != "true") {
          showErrorSnackBar(jsonData["message"].toString(), colorError);
          return false;
        }
        //showSnackbar("Subscription PlanPrice Details Added Successfully", colorSuccess);
        getActivityAll(getAllActivityFromJson(value.body));
        return true;
      });
    } on Exception catch (e) {
      print("getAllActivity:: $e");
      // showSnackbar("Some unknown error has occur, try again after some time!", colorError);
      return false;
    }
  }



  static Rx<GetActivityById> getActivityById =
      GetActivityById().obs;

  static Future<bool> getActivityByActivityId(String activityId) async {
    final headers = {
      "Content-Type": "application/json",
      "UserToken": '${prefs?.getString(LocalStorage.token).toString()}'
    };
    final String url = '${DatabaseApi.getActivityById}$activityId';
    customPrint("getActivityById url :: $url");
    customPrint("token :: ${prefs?.getString(LocalStorage.token).toString()}");
    try {
      return await http
          .get(Uri.parse(url), headers: headers)
          .then((value) async {
        print("getActivityById :: ${value.body}");
        final jsonData = jsonDecode(value.body);
        if (jsonData["status"].toString() != "true") {
          showErrorSnackBar(jsonData["message"].toString(), colorError);
          return false;
        }
        //showSnackbar("Subscription PlanPrice Details Added Successfully", colorSuccess);
        getActivityById(getActivityByIdFromJson(value.body));
        return true;
      });
    } on Exception catch (e) {
      print("getActivityById:: $e");
      // showSnackbar("Some unknown error has occur, try again after some time!", colorError);
      return false;
    }
  }


}