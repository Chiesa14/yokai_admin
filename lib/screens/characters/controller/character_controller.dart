import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../api/database.dart';
import '../../../api/local_storage.dart';
import '../../../globalVariable.dart';
import '../../../main.dart';
import '../../../model/get_all_characters.dart';
import '../../../model/get_characters_by_id.dart';
import '../../../utils/colors.dart';

class CharacterController {
  static final TextEditingController titleController = TextEditingController();
  static final TextEditingController linkController = TextEditingController();
  static final TextEditingController introductionController = TextEditingController();
  static final TextEditingController requirementsController = TextEditingController();
  static final TextEditingController promptsController = TextEditingController();
  static final TextEditingController tagsController = TextEditingController();
  static final TextEditingController searchCharactersController = TextEditingController();
  static RxInt storiesPage = 0.obs;
  static RxInt characterCountTitle = 0.obs;
  static RxInt characterCountLink = 0.obs;
  static RxInt characterCountIntroduction = 0.obs;
  static RxInt characterCountRequirement = 0.obs;
  static RxInt promptsCountRequirement = 0.obs;
  static RxInt characterCountTags = 0.obs;
  static RxString tagsEmptyError = ''.obs;
  static RxBool isEditCharacter = false.obs;
  static RxString characterId = "".obs;
  static RxString storyCharacters = "Select".obs;
  static final RxList<String> storyListCharacters = RxList<String>.of(["Select"]);
  static final RxList<String> storyIdCharacters= RxList<String>.of([]);
  static final RxString storyIdStringCharacters = ''.obs;

  static RxList chDetails = [].obs;
  static RxString chDetailsString = ''.obs;

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

  static Future<bool> createCharacters(context, body) async {
    final String url = "${DatabaseApi.createCharacters}";
    customPrint("createCharacters url:: $url");
    customPrint("createCharacters body:: ${jsonEncode(body)}");

    final headers = {
      "Content-Type": "application/json",
      "AdminToken": "${prefs?.getString(LocalStorage.token)}",
    };
    try {
      return await http
          .post(Uri.parse(url), headers: headers, body: json.encode(body))
          .then((value) async {
        final jsonData = json.decode(value.body);
        print("createCharacters response:: ${jsonEncode(jsonData)}");
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

  static Future<bool> updateCharacters(context, String characterId, body) async {
    final String url = "${DatabaseApi.updateCharactersById}$characterId";
    customPrint("updateCharactersById url:: $url");
    customPrint("updateCharactersById body:: ${jsonEncode(body)}");

    final headers = {
      "Content-Type": "application/json",
      "AdminToken": "${prefs?.getString(LocalStorage.token)}",
    };
    try {
      return await http
          .put(Uri.parse(url), headers: headers, body: json.encode(body))
          .then((value) async {
        final jsonData = json.decode(value.body);
        print("updateCharactersById response:: ${jsonEncode(jsonData)}");
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

  static Rx<GetAllCharacters> getAllCharacters = GetAllCharacters().obs;

  static Future<bool> getCharacters(String search) async {
    final headers = {
      "Content-Type": "application/json",
      "AdminToken": '${prefs?.getString(LocalStorage.token).toString()}'
    };
    final String url = '${DatabaseApi.getCharacters}$search';
    customPrint("getCharacters url :: $url");
    try {
      return await http
          .get(Uri.parse(url), headers: headers)
          .then((value) async {
        print("getCharacters :: ${value.body}");
        final jsonData = jsonDecode(value.body);
        if (jsonData["status"].toString() != "true") {
          showErrorSnackBar(jsonData["message"].toString(), colorError);
          return false;
        }
        //showSnackbar("Subscription PlanPrice Details Added Successfully", colorSuccess);
        getAllCharacters(getAllCharactersFromJson(value.body));
        return true;
      });
    } on Exception catch (e) {
      print("getCharacters:: $e");
      // showSnackbar("Some unknown error has occur, try again after some time!", colorError);
      return false;
    }
  }

  static Rx<GetAllCharactersById> getAllCharactersById = GetAllCharactersById().obs;

  static Future<bool> getCharactersById(String characterId) async {
    final headers = {
      "Content-Type": "application/json",
      "AdminToken": '${prefs?.getString(LocalStorage.token).toString()}'
    };
    final String url = '${DatabaseApi.getCharactersById}$characterId';
    customPrint("getCharactersById url :: $url");
    try {
      return await http
          .get(Uri.parse(url), headers: headers)
          .then((value) async {
        print("getCharactersById :: ${value.body}");
        final jsonData = jsonDecode(value.body);
        if (jsonData["status"].toString() != "true") {
          showErrorSnackBar(jsonData["message"].toString(), colorError);
          return false;
        }
        //showSnackbar("Subscription PlanPrice Details Added Successfully", colorSuccess);
        getAllCharactersById(getAllCharactersByIdFromJson(value.body));
        return true;
      });
    } on Exception catch (e) {
      print("getCharactersById:: $e");
      // showSnackbar("Some unknown error has occur, try again after some time!", colorError);
      return false;
    }
  }

  static Future<bool>  deleteCharacters(
      BuildContext context, String characterId) async {
    final headers = {
      "Content-Type": "application/json",
      "AdminToken": "${prefs?.getString(LocalStorage.token)}",
    };
    String url = "${DatabaseApi.deleteCharactersById}$characterId";
    customPrint("deleteCharactersById URL :: $url");
    try {
      return await http.delete(Uri.parse(url), headers: headers).then((value) {
        customPrint("deleteCharactersById :: ${value.body}");
        final jsonData = jsonDecode(value.body);
        if (value.statusCode != 200) {
          showErrorSnackBar(jsonData["message"].toString(), colorError);
          return false;
        }
        showSuccessSnackBarIcon(jsonData["message"].toString(), colorSuccess);
        return true;
      });
    } on Exception catch (e) {
      customPrint("deleteCharactersById  :: $e");
      showSuccessSnackBarIcon("delete ", colorError);
      return false;
    }
  }
}