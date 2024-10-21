import 'dart:convert';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yokai_admin/Widgets/progressHud.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/const.dart';

import '../../../Widgets/addquesdialog.dart';
import '../../../Widgets/custom_delete_button.dart';
import '../../../Widgets/customquestion_card.dart';
import '../../../Widgets/my_textfield.dart';
import '../../../Widgets/new_button.dart';
import '../../../Widgets/outline_button.dart';
import '../../../api/database.dart';
import '../../../globalVariable.dart';
import '../../../utils/constants.dart';
import '../../../utils/text_styles.dart';
import '../Controller/activities_Controller.dart';
import 'audio_ui.dart';

class ActivitiesDetailsPage extends StatefulWidget {
  const ActivitiesDetailsPage({super.key});

  @override
  State<ActivitiesDetailsPage> createState() => _ActivitiesDetailsPageState();
}

class _ActivitiesDetailsPageState extends State<ActivitiesDetailsPage> {
  List<Map<String, dynamic>> jsonData = [];

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['xlsx', 'csv']);

    if (result != null && result.files.single.bytes != null) {
      Uint8List fileBytes = result.files.single.bytes!;
      String fileName = result.files.single.name;
      print("fileBytes :: $fileBytes");
      print("fileName :: $fileName");
      List<Map<String, dynamic>> jsonDataFetched =
          await convertFileToJson(fileBytes, fileName);
      setState(() {
        jsonData = jsonDataFetched;
      });
    } else {
      // User canceled the picker
      print('File picking cancelled');
    }
  }

  Future<List<Map<String, dynamic>>> convertFileToJson(
      Uint8List bytes, String fileName) async {
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
          data[headers[j]] = row[j].toString().replaceAll(',', ';');
        }

        if (data['Questions'] != '') {
          if (currentQuestion != null) {
            jsonData.add({
              'Questions': currentQuestion['Questions'],
              'Options': currentQuestion['Options'],
              'correct_answer': currentQuestion['correct_answer']
            });
          }
          currentQuestion = {
            'Questions': data['Questions'],
            'Options': data['Options'],
            'correct_answer': data['correct_answer']
          };
        } else {
          currentQuestion!['Options'] += '; ${data['Options']}';
        }
      }

      if (currentQuestion != null) {
        jsonData.add({
          'Questions': currentQuestion['Questions'],
          'Options': currentQuestion['Options'],
          'correct_answer': currentQuestion['correct_answer']
        });
      }

      for (var item in jsonData) {
        List<String> options = item['Options'].split(';');

        Map<String, String> optionKeys = {
          "option_a": options.isNotEmpty ? options[0].trim() : "",
          "option_b": options.length > 1 ? options[1].trim() : "",
          "option_c": options.length > 2 ? options[2].trim() : "",
          "option_d": options.length > 3 ? options[3].trim() : "",
          "option_e": options.length > 4 ? options[4].trim() : "",
          "option_f": options.length > 5 ? options[5].trim() : "",
        };

        Map<String, dynamic> requestBody = {
          "activity_id": ActivitiesController.responseActivityId.value,
          "question": item["Questions"],
          ...optionKeys,
          // "correct_answer": item["correct_answer"]
        };
        requestBodyList.add(requestBody);
      }
      print('requestBodyList :: ${requestBodyList.length}');
      for (var requestBody in requestBodyList) {
        // await ActivitiesController.createActivityDetails( requestBody);
      }
      showSuccessSnackBar('', 'Exam added Successfully!');
      return jsonData;
    } catch (e) {
      print('Error during file conversion: $e');
      return [];
    }
  }

  RxBool isLoading = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() {
    ActivitiesController.titleController.clear();
    ActivitiesController.descriptionController.clear();
    ActivitiesController.uploadUrlImageUrlCover('');
    ActivitiesController.uploadUrlImageCover('');
    ActivitiesController.uploadUrlImageStamp('');
    ActivitiesController.uploadUrlImageEnd('');
    ActivitiesController.uploadUrlAudioStamp('');
    ActivitiesController.selectFileNameAudioStamp('');
    if (ActivitiesController.isEdit.isTrue) {
      if (ActivitiesController.activityIdForEditActivity.isNotEmpty) {
        isLoading(true);
        ActivitiesController.getActivityByActivityId(
                ActivitiesController.activityIdForEditActivity.value)
            .then(
          (value) {
            ActivitiesController.descriptionController.text =
                ActivitiesController
                        .getActivityById.value.data?.shortDiscription
                        .toString() ??
                    '';
            ActivitiesController.titleController.text = ActivitiesController
                    .getActivityById.value.data?.title
                    .toString() ??
                '';
            ActivitiesController.uploadUrlImageUrlCover(ActivitiesController
                    .getActivityById.value.data?.activityImage
                    .toString() ??
                '');
            ActivitiesController.uploadUrlImageCover(ActivitiesController
                    .getActivityById.value.data?.activityImage
                    .toString() ??
                '');

            ///
            // ActivitiesController.uploadUrlImageUrlStamp(ActivitiesController
            //         .getActivityById.value.data?.image
            //         .toString() ??
            //     '');
            ActivitiesController.uploadUrlImageStamp(ActivitiesController
                    .getActivityById.value.data?.image
                    .toString() ??
                '');
            ActivitiesController.uploadUrlImageEnd(ActivitiesController
                    .getActivityById.value.data?.endImage
                    .toString() ??
                '');
            //
            // ActivitiesController.uploadUrlAudioUrlStamp(ActivitiesController
            //         .getActivityById.value.data?.audio
            //         .toString() ??
            //     '');
            if ((ActivitiesController.getActivityById.value.data?.audio
                            .toString() ??
                        '') !=
                    "null" &&
                (ActivitiesController.getActivityById.value.data?.audio
                            .toString() ??
                        '') !=
                    '') {
              ActivitiesController.uploadUrlAudioStamp(
                  ActivitiesController.getActivityById.value.data?.audio.toString() ?? '');
              customPrint(
                  'uploadUrlAudioStamp ::${ActivitiesController.uploadUrlAudioStamp.value}');
            }

            ///
            customPrint(
                'uploadUrlImageUrlCover ::${ActivitiesController.uploadUrlImageUrlCover.value}');
            // if(  ActivitiesController
            //       .getActivityById
            //       .value
            //       .data){
            //   ActivitiesController.uploadUrlImageUrlCover(
            //       ActivitiesController
            //           .getActivityById
            //           .value
            //           .data
            //           ?.
            //           .toString() ??
            //           '');
            //   ActivitiesController.uploadUrlImageCover(
            //   ActivitiesController
            //       .getActivityById
            //       .value
            //       .data
            //       ?.
            //       .toString() ??
            //   '');
            // }
            isLoading(false);
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Obx( () {
        return ProgressHUD(
          isLoading: isLoading.value,
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Row(
                            children: [
                              GestureDetector(
                              onTap: () async {
                                await ActivitiesController.getAllActivity(
                                        '', '')
                                    .then((value) {
                                  if (value) {
                                    ActivitiesController.storyChapter =
                                        'Select';
                                    ActivitiesController.activitiesPage(0);
                                    isLoading(false);
                                  }
                                });
                                ActivitiesController.activitiesPage(0);
                                },
                                child: SvgPicture.asset(
                                  'icons/back.svg',
                                  height: 35,
                                  width: 35,
                                ),
                              ),
                              1.pw,
                              Text(
                                'Activity Details',
                                style: AppTextStyle.normalBold28
                                    .copyWith(color: carlo400),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: CustomButton(
                            // text: ' Edit Activity',
                            text: ' Save Changes',
                            textSize: 14,
                          onPressed: () async {
                            isLoading(true);
                            final List<TextEditingController> controllerList = [
                              ActivitiesController.titleController,
                              ActivitiesController.descriptionController
                            ];
                            final List<String> fieldsName = [
                              'Activity Title',
                              'Short Description'
                            ];
                            bool valid = validateMyFields(
                                context, controllerList, fieldsName);
                            if (!valid) {
                              isLoading(false);
                              return;
                            }
                            final body = {
                              "story_id": ActivitiesController
                                      .getActivityById.value.data?.storyId
                                      .toString() ??
                                  '',
                              "chapter_id": ActivitiesController
                                      .getActivityById.value.data?.chapterId
                                      .toString() ??
                                  '',
                              "title":
                                  ActivitiesController.titleController.text,
                              "time": ActivitiesController
                                      .getActivityById.value.data?.time
                                      .toString() ??
                                  '',
                              "short_discription": ActivitiesController
                                  .descriptionController.text,
                                "activity_image": ActivitiesController
                                  .uploadUrlImageCover.value,
                              "image": ActivitiesController
                                  .uploadUrlImageStamp.value,
                              "audio":
                                  ActivitiesController.uploadUrlAudioStamp.value,
                              "end_image":
                              ActivitiesController.uploadUrlImageEnd.value
                            };
                            await ActivitiesController
                                    .updateActivityById(
                                        context,
                                        body,
                                        ActivitiesController
                                                .getActivityById.value.data?.id
                                                .toString() ??
                                            '')
                                .then(
                              (value) async {
                                await ActivitiesController.getAllActivity('','')
                                    .then((value) async {
                                  ActivitiesController.storyChapter = 'Select';
                                  ActivitiesController.storyIdString('');
                                  ActivitiesController.chapterIdString('');
                                  ActivitiesController.uploadUrlImageCover('');
                                  ActivitiesController.titleController.clear();
                                  ActivitiesController.timeController.clear();
                                  ActivitiesController.descriptionController
                                      .clear();
                                  ActivitiesController.uploadUrlImageEng('');
                                  ActivitiesController.uploadUrlImageJap('');
                                  ActivitiesController.activitiesPage(0);
                                  ActivitiesController.uploadUrlImageUrlCover(
                                      '');
                                  ActivitiesController.selectFileNameImageEng(
                                      '');
                                  ActivitiesController.selectFileNameImageJap(
                                      '');
                                  isLoading(false);
                                });
                              },
                            );
                          },
                        ),
                        ),
                      ],
                    ),
                    5.ph,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      // Text(
                      //   'Name: ${ActivitiesController.getActivityById.value.data?.title.toString() ?? ''}',
                      //   style: AppTextStyle.normalRegular20.copyWith(
                      //       color: ironColor, fontWeight: FontWeight.w500),
                      // ),
                      CustomInfoField(
                        maxCharacters: 50,
                        maxLength: 50,
                        length:
                            ActivitiesController.titleController.text.length,
                        counter: true,
                        controller: ActivitiesController.titleController,
                        hint: "Healthy Coping Mechanisms",
                        label: 'Name',
                        onChanged: (value) {
                          ActivitiesController.activityCountTitle(value.length);
                        },
                      ),
                      2.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Story : ${ActivitiesController.getActivityById.value.data?.storyName.toString() ?? ''}',
                              style: AppTextStyle.normalRegular16.copyWith(
                                  color: ironColor, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Character : - ---',
                              style: AppTextStyle.normalRegular16.copyWith(
                                  color: ironColor, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Last Updated : ${DateFormat('dd-MM-yyyy').format(DateTime.tryParse(ActivitiesController.getActivityById.value.data?.updatedAt.toString() ?? '') ?? DateTime.now())}',
                              style: AppTextStyle.normalRegular16.copyWith(
                                  color: ironColor, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        2.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Chapter :  ${ActivitiesController.getActivityById.value.data?.chapterNo.toString() ?? ''}',
                              style: AppTextStyle.normalRegular16.copyWith(
                                  color: ironColor, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Time: ${ActivitiesController.getActivityById.value.data?.time.toString() ?? ''} Minutes',
                              style: AppTextStyle.normalRegular16.copyWith(
                                  color: ironColor, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      2.ph,
                      SizedBox(
                        height: 230,
                        child: Row(
                          children: [
                            (ActivitiesController
                                        .uploadUrlImageUrlCover.isEmpty ||
                                    ActivitiesController
                                            .uploadUrlImageUrlCover.value ==
                                        'null')
                                ? Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Activity Image",
                                          style: AppTextStyle.normalRegular16
                                              .copyWith(
                                                  color: ironColor,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        0.5.ph,
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              ActivitiesController.pickImage()
                                                  .then((value) {
                                                ActivitiesController
                                                    .uploadUrlImageUrlCover('');
                                                ActivitiesController
                                                    .uploadUrlImageCover('');
                                                isLoading(true);
                                                ActivitiesController
                                                        .uploadImage()
                                                    .then((value) {
                                                  customPrint(
                                                      'imageUrl :: ${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlImageCover}');
                                                  ActivitiesController
                                                      .uploadUrlImageUrlCover(
                                                          '${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlImageCover}');
                                                  isLoading(false);
                                                });
                                              });
                                            },
                                            child: Container(
                                              height: 170,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                color: containerBack,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    'icons/add.svg',
                                                    color: indigo700,
                                                  ),
                                                  Text(
                                                    'Click to upload\ncover image',
                                                    style: AppTextStyle
                                                        .normalRegular15
                                                        .copyWith(
                                                            color: labelColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        0.5.ph,
                                        Text(
                                          'Square Image\n(Recommended size 1080×608)',
                                          //textStyle.labelStyle,
                                          style: textStyle.labelStyle.copyWith(
                                              color: bordercolor, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Activity Image",
                                          style: AppTextStyle.normalRegular16
                                              .copyWith(
                                                  color: ironColor,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        0.5.ph,
                                        Container(
                                          height: 170,
                                          width: 200,
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: containerBack,
                                            border: Border.all(
                                                color: containerBorder),
                                          ),
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.network(
                                                  '${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlImageCover}',
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: CustomDelete(
                                                  onPressed: () {
                                                    ActivitiesController
                                                        .uploadUrlImageUrlCover(
                                                            '');
                                                    ActivitiesController
                                                        .uploadUrlImageCover(
                                                            '');
                                                  },
                                                ),
                                              ),
                                              // GestureDetector(
                                              //     onTap: () {
                                              //       ActivitiesController
                                              //           .uploadUrlImageUrlStamp('');
                                              //     },
                                              //     child: SvgPicture.asset(
                                              //         'icons/deleteNew.svg')),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            2.pw,
                            (ActivitiesController.uploadUrlImageStamp.isEmpty ||
                                    ActivitiesController
                                            .uploadUrlImageStamp.value ==
                                        'null' ||
                                    ActivitiesController
                                        .uploadUrlImageStamp.isEmpty)
                                ? Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Stamp Image",
                                          style: AppTextStyle.normalRegular16
                                              .copyWith(
                                                  color: ironColor,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        0.5.ph,
                                        Expanded(
                                          child: MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: GestureDetector(
                                              onTap: () {
                                                ActivitiesController
                                                        .pickStampImage()
                                                    .then((value) {
                                                  // ActivitiesController
                                                  //     .uploadUrlImageUrlStamp('');
                                                  ActivitiesController
                                                      .uploadUrlImageStamp('');
                                                  isLoading(true);
                                                  ActivitiesController
                                                          .uploadStampImage()
                                                      .then((value) {
                                                    customPrint(
                                                        'imageUrl :: ${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlImageStamp}');
                                                    // ActivitiesController
                                                    //     .uploadUrlImageUrlStamp(
                                                    //         '${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlImageStamp}');
                                                    isLoading(false);
                                                  });
                                                });
                                              },
                                              child: Container(
                                                height: 170,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                  color: containerBack,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      'icons/add.svg',
                                                      color: indigo700,
                                                    ),
                                                    Text(
                                                      'Click to upload\nStamp image',
                                                      style: AppTextStyle
                                                          .normalRegular15
                                                          .copyWith(
                                                              color:
                                                                  labelColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        0.5.ph,
                                        Text(
                                          'Square Image\n(Recommended size 1080×608)',
                                          //textStyle.labelStyle,
                                          style: textStyle.labelStyle.copyWith(
                                              color: bordercolor, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Stamp Image",
                                          style: AppTextStyle.normalRegular16
                                              .copyWith(
                                                  color: ironColor,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        0.5.ph,
                                        Container(
                                          height: 170,
                                          width: 200,
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: containerBack,
                                            border: Border.all(
                                                color: containerBorder),
                                          ),
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.network(
                                                  '${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlImageStamp}',
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: CustomDelete(
                                                  onPressed: () {
                                                    ActivitiesController
                                                        .uploadUrlImageStamp(
                                                            '');
                                                  },
                                                ),
                                              ),
                                              // GestureDetector(
                                              //     onTap: () {
                                              //       ActivitiesController
                                              //           .uploadUrlImageUrlStamp('');
                                              //     },
                                              //     child: SvgPicture.asset(
                                              //         'icons/deleteNew.svg')),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            2.pw,
                            (ActivitiesController.uploadUrlAudioStamp.isEmpty ||
                                    ActivitiesController
                                            .uploadUrlAudioStamp.value ==
                                        'null' )
                                ? Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Audio",
                                          style: AppTextStyle.normalRegular16
                                              .copyWith(
                                                  color: ironColor,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        0.5.ph,
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () {
                                              ActivitiesController
                                                      .pickStampAudio()
                                                  .then((value) {
                                                // ActivitiesController
                                                //     .uploadUrlAudioUrlStamp('');
                                                ActivitiesController
                                                    .uploadUrlAudioStamp('');
                                                isLoading(true);
                                                ActivitiesController
                                                        .uploadStampAudio()
                                                    .then((value) {
                                                  customPrint(
                                                      'audio Url :: ${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlAudioStamp}');
                                                  // ActivitiesController
                                                  //     .uploadUrlAudioStamp(
                                                  //         '${ActivitiesController.getActivityById.value.data?.audio.toString() ?? ''}');
                                                  // ActivitiesController
                                                  //     .uploadUrlAudioUrlStamp(
                                                  //         '${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlAudioStamp}');
                                                  isLoading(false);
                                                });
                                              });
                                            },
                                            child: Container(
                                              height: 170,
                                              width: screenWidth / 3,
                                              decoration: BoxDecoration(
                                                color: containerBack,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    'icons/add.svg',
                                                    color: indigo700,
                                                  ),
                                                  Text(
                                                    'Click to upload\nStamp Audio',
                                                    style: AppTextStyle
                                                        .normalRegular15
                                                        .copyWith(
                                                            color: labelColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Audio",
                                          style: AppTextStyle.normalRegular16
                                              .copyWith(
                                                  color: ironColor,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        0.5.ph,
                                        Container(
                                          height: 170,
                                          width: screenWidth / 3,
                                          // margin:
                                          //     const EdgeInsets.symmetric(vertical: 28),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: containerBack,
                                            border: Border.all(
                                                color: containerBorder),
                                          ),
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: AudioPlayerWidget(
                                                  audioUrl:
                                                      "${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlAudioStamp.value}",
                                                  fileName: ((ActivitiesController
                                                              .selectFileNameAudioStamp
                                                              .value) ==
                                                          '')
                                                      ? (ActivitiesController
                                                                  .getActivityById
                                                                  .value
                                                                  .data
                                                                  ?.audio
                                                                  .toString() ??
                                                              '')
                                                          .split('/')
                                                          .last
                                                      : ActivitiesController
                                                          .selectFileNameAudioStamp
                                                          .value,
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: CustomDelete(
                                                  onPressed: () {
                                                    ActivitiesController
                                                        .uploadUrlAudioStamp(
                                                            '');
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            2.pw,
                            (ActivitiesController.uploadUrlImageEnd.isEmpty ||
                                    ActivitiesController
                                            .uploadUrlImageEnd.value ==
                                        'null' ||
                                    ActivitiesController
                                        .uploadUrlImageEnd.isEmpty)
                                ? Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "End Image",
                                          style: AppTextStyle.normalRegular16
                                              .copyWith(
                                                  color: ironColor,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        0.5.ph,
                                        Expanded(
                                          child: MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: GestureDetector(
                                              onTap: () {
                                                ActivitiesController
                                                        .pickEndImage()
                                                    .then((value) {
                                                  // ActivitiesController
                                                  //     .uploadUrlImageUrlStamp('');
                                                  ActivitiesController
                                                      .uploadUrlImageEnd('');
                                                  isLoading(true);
                                                  ActivitiesController
                                                          .uploadEndImage()
                                                      .then((value) {
                                                    customPrint(
                                                        'imageUrl :: ${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlImageEnd}');
                                                    // ActivitiesController
                                                    //     .uploadUrlImageUrlStamp(
                                                    //         '${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlImageEnd}');
                                                    isLoading(false);
                                                  });
                                                });
                                              },
                                              child: Container(
                                                height: 170,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                  color: containerBack,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      'icons/add.svg',
                                                      color: indigo700,
                                                    ),
                                                    Text(
                                                      'Click to upload\nStamp image',
                                                      style: AppTextStyle
                                                          .normalRegular15
                                                          .copyWith(
                                                              color:
                                                                  labelColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        0.5.ph,
                                        Text(
                                          'Square Image\n(Recommended size 1080×608)',
                                          //textStyle.labelStyle,
                                          style: textStyle.labelStyle.copyWith(
                                              color: bordercolor, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "End Image",
                                          style: AppTextStyle.normalRegular16
                                              .copyWith(
                                                  color: ironColor,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        0.5.ph,
                                        Container(
                                          height: 170,
                                          width: 200,
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: containerBack,
                                            border: Border.all(
                                                color: containerBorder),
                                          ),
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.network(
                                                  '${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlImageEnd}',
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: CustomDelete(
                                                  onPressed: () {
                                                    ActivitiesController
                                                        .uploadUrlImageEnd(
                                                            '');
                                                  },
                                                ),
                                              ),
                                              // GestureDetector(
                                              //     onTap: () {
                                              //       ActivitiesController
                                              //           .uploadUrlImageUrlStamp('');
                                              //     },
                                              //     child: SvgPicture.asset(
                                              //         'icons/deleteNew.svg')),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      2.ph,
                      SizedBox(
                        height: 200,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: CustomInfoField(
                                maxCharacters: 400,
                                maxLength: 400,
                                  counter: true,
                                  maxLines: 5,
                                  controller:
                                      ActivitiesController.descriptionController,
                                  hint: "",
                                  label: 'Short Description',
                                ),
                              ),
                          ],
                        ),
                      ),
                        2.ph,
                      (ActivitiesController.getActivityById.value.data != null)
                          ? Container(
                              // height: MediaQuery.of(context).size.height / 1.5,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: ActivitiesController.getActivityById
                                        .value.data?.details?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  final examDetail = ActivitiesController
                                      .getActivityById
                                      .value
                                      .data
                                      ?.details?[index];
                                  if (examDetail != null) {
                                    List<String> options =
                                        (examDetail.options ?? [])
                                            .where((option) =>
                                                option.trim().isNotEmpty)
                                            .toList();
                                    String question = examDetail.question ?? '';
                                    int examDetailId = examDetail.id ?? 0;
                                    String srNo = examDetail.srNo ?? '';
                                    String examId = examDetail.activityId ?? "";
                                    String explanation =
                                        examDetail.explation ?? "";
                                    String image =
                                        '${DatabaseApi.mainUrlForImage}${examDetail.image}';
                                    String correctAns =
                                        examDetail.correctAnswer ?? "";
                                    customPrint('question :: $question');
                                    return CustomQuestionCard(
                                      correctAnswer:
                                          ActivitiesController.decodeApiString(
                                              hexString: correctAns),
                                      imagePath: image,
                                      question:
                                          '${index + 1}) ${ActivitiesController.decodeApiString(hexString: question)}',
                                      explanation:
                                          ActivitiesController.decodeApiString(
                                              hexString: explanation),
                                      examDetailId: examDetailId.toString(),
                                      examId: examId,
                                      srNo: srNo.toString(),
                                      optionA:
                                          ActivitiesController.decodeApiString(
                                              hexString: options.length > 0
                                                  ? options[0]
                                                  : ''),
                                      optionB:
                                          ActivitiesController.decodeApiString(
                                              hexString: options.length > 1
                                                  ? options[1]
                                                  : ''),
                                      optionC:
                                          ActivitiesController.decodeApiString(
                                              hexString: options.length > 2
                                                  ? options[2]
                                                  : ''),
                                      optionD:
                                          ActivitiesController.decodeApiString(
                                              hexString: options.length > 3
                                                  ? options[3]
                                                  : ''),
                                      optionE:
                                          ActivitiesController.decodeApiString(
                                              hexString: options.length > 4
                                                  ? options[4]
                                                  : ''),
                                      options: [
                                        'a) ${ActivitiesController.decodeApiString(hexString: options.length > 0 ? options[0] : '')}',
                                        'b) ${ActivitiesController.decodeApiString(hexString: options.length > 1 ? options[1] : '')}',
                                        'c) ${ActivitiesController.decodeApiString(hexString: options.length > 2 ? options[2] : '')}',
                                        'd) ${ActivitiesController.decodeApiString(hexString: options.length > 3 ? options[3] : '')}',
                                        'e) ${ActivitiesController.decodeApiString(hexString: options.length > 4 ? options[4] : '')}',
                                      ],
                                      onPressedActions: [
                                        () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AddQuestionDialog(
                                                examDetailId:
                                                    examDetailId.toString(),
                                                examId: examId,
                                                question: ActivitiesController
                                                    .decodeApiString(
                                                        hexString: question),
                                                questionImg: image,
                                                correctAns: ActivitiesController
                                                    .decodeApiString(
                                                        hexString: examDetail
                                                                .correctAnswer ??
                                                            'NA')

                                                ///not receive from api
                                                ,
                                                explanation: ActivitiesController
                                                    .decodeApiString(
                                                        hexString: examDetail
                                                                .explation ??
                                                            ''),
                                                srNo: examDetail.srNo ?? '',
                                                optionA: ActivitiesController
                                                    .decodeApiString(
                                                        hexString:
                                                            options.length > 0
                                                                ? options[0]
                                                                : ''),
                                                optionB: ActivitiesController
                                                    .decodeApiString(
                                                        hexString:
                                                            options.length > 1
                                                                ? options[1]
                                                                : ''),
                                                optionC: ActivitiesController
                                                    .decodeApiString(
                                                        hexString:
                                                            options.length > 2
                                                                ? options[2]
                                                                : ''),
                                                optionD: ActivitiesController
                                                    .decodeApiString(
                                                        hexString:
                                                            options.length > 3
                                                                ? options[3]
                                                                : ''),
                                                optionE: ActivitiesController
                                                    .decodeApiString(
                                                        hexString:
                                                            options.length > 4
                                                                ? options[4]
                                                                : ''),
                                              );
                                            },
                                          );
                                        },
                                        // () {
                                        //   showDialog(
                                        //     context: context,
                                        //     builder: (BuildContext context) {
                                        //       return AlertDialog(
                                        //         content: Padding(
                                        //           padding:
                                        //               const EdgeInsets.only(
                                        //                   bottom: 20,
                                        //                   left: 20,
                                        //                   right: 20),
                                        //           child: Container(
                                        //             width:
                                        //                 MediaQuery.of(context)
                                        //                         .size
                                        //                         .width /
                                        //                     3.5,
                                        //             decoration: BoxDecoration(
                                        //                 borderRadius:
                                        //                     BorderRadius
                                        //                         .circular(12)),
                                        //             child: Column(
                                        //               mainAxisSize:
                                        //                   MainAxisSize.min,
                                        //               crossAxisAlignment:
                                        //                   CrossAxisAlignment
                                        //                       .start,
                                        //               children: <Widget>[
                                        //                 Row(
                                        //                   mainAxisAlignment:
                                        //                       MainAxisAlignment
                                        //                           .end,
                                        //                   children: [
                                        //                     InkWell(
                                        //                       onTap: () {
                                        //                         Navigator.pop(
                                        //                             context);
                                        //                       },
                                        //                       child: Icon(
                                        //                         Icons.close,
                                        //                         color:
                                        //                             Colors.red,
                                        //                       ),
                                        //                     )
                                        //                   ],
                                        //                 ),
                                        //                 Center(
                                        //                   child: Text(
                                        //                     'Add Image',
                                        //                     style: TextStyle(
                                        //                       fontFamily:
                                        //                           'Montserrat',
                                        //                       fontSize: 18,
                                        //                       fontWeight:
                                        //                           FontWeight
                                        //                               .w600,
                                        //                       color: textDark,
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //                 const SizedBox(
                                        //                     height: constants
                                        //                             .defaultPadding *
                                        //                         2),
                                        //                 ImagePickerWidget(
                                        //                   examDetailId:
                                        //                   examDetailId.toString(),
                                        //                   examId: examId,
                                        //                   question: question,
                                        //                   questionImg: image,
                                        //                   correctAns:
                                        //                   // examDetail
                                        //                   //     .correctAnswer ??
                                        //                       'NA',
                                        //                   srNo: examDetail.srNo ?? '',
                                        //                   optionA: options.length > 0
                                        //                       ? options[0]
                                        //                       : '',
                                        //                   optionB: options.length > 1
                                        //                       ? options[1]
                                        //                       : '',
                                        //                   optionC: options.length > 2
                                        //                       ? options[2]
                                        //                       : '',
                                        //                   optionD: options.length > 3
                                        //                       ? options[3]
                                        //                       : '',
                                        //                   optionE: options.length > 4
                                        //                       ? options[4]
                                        //                       : '',
                                        //                   text:
                                        //                   'Click to upload This will replace existing image',
                                        //                   title:
                                        //                   'Image for this question',
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       );
                                        //     },
                                        //   );
                                        // },
                                        () {
                                          deleteQuestion(context, examDetailId.toString());
                                        },
                                      ],
                                      icons: [
                                        'icons/mi_edit.png',
                                        // 'icons/micro_three.svg',
                                        'icons/mi_delete.png',
                                      ],
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                },
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Center(
                                  child: Text("No MCQs available",
                                      style: AppTextStyle.normalBold20
                                          .copyWith(color: Colors.grey[400]))),
                            ),
                    ],
                  ),
                ],
              ),
              ),
            ),
          ),
        );
      }
    );
  }

  void deleteQuestion(BuildContext context, String activityDetailId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: Container(
              width: MediaQuery.of(context).size.width / 4,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                  Text(
                    'Delete Question',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(
                    height: constants.defaultPadding * 2,
                  ),
                  Text(
                    'Are you sure you want to delete this question ? ',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: textDark,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'It will be deleted from the exam and it will not be recovered.',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(
                    height: constants.defaultPadding * 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomButton(
                        isPopup: true,
                        textSize: 14,
                        width: MediaQuery.of(context).size.width / 5,
                        text: 'Delete Question',
                        onPressed: () async {
                          setState(() {
                            // _isLoading = true;
                          });
                          bool success = await ActivitiesController
                              .deleteActivityDetailsByDetailId(
                                  context, activityDetailId);
                          if (success) {
                            fetchData();
                            setState(() {
                              // _isLoading = false;
                            });
                          }
                          Navigator.pop(context);
                        },
                      )),
                      const SizedBox(
                        width: constants.defaultPadding,
                      ),
                      Expanded(
                          child: OutlineButton(
                        textSize: 14,
                        text: 'Cancel',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        width: MediaQuery.of(context).size.width / 5,
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
