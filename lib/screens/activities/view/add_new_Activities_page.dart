import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yokai_admin/Widgets/custom_delete_button.dart';
import 'package:yokai_admin/Widgets/progressHud.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/const.dart';

import '../../../Widgets/my_dropdown2.dart';
import '../../../Widgets/my_textfield.dart';
import '../../../Widgets/new_button.dart';
import '../../../api/database.dart';
import '../../../globalVariable.dart';
import '../../../utils/text_styles.dart';
import '../../chapters/controller/chapters_controller.dart';
import '../../stories/controller/stories_controller.dart';
import '../Controller/activities_Controller.dart';
import 'audio_ui.dart';

class AddNewActivitiesPage extends StatefulWidget {
  const AddNewActivitiesPage({super.key});

  @override
  State<AddNewActivitiesPage> createState() => _AddNewActivitiesPageState();
}

class _AddNewActivitiesPageState extends State<AddNewActivitiesPage> {
  RxBool isLoading = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading(true);
    ActivitiesController.uploadUrlImageCover('');
    ActivitiesController.uploadUrlImageUrlCover('');
    ActivitiesController.uploadUrlImageUrlStamp('');
    ActivitiesController.uploadUrlAudioUrlStamp('');
    ActivitiesController.uploadUrlImageUrlEnd('');
    StoriesController.getAllStory('').then((value) {
      for (int i = 0;
          i < (StoriesController.getAllStoriesBy.value.data?.length ?? 0);
          i++) {
        ActivitiesController.storyList
            .add(StoriesController.getAllStoriesBy.value.data?[i].name ?? '');
        ActivitiesController.storyId.add(
            StoriesController.getAllStoriesBy.value.data?[i].id.toString() ??
                '');
      }
      // if ((StoriesController.getAllStoriesBy.value.data?.length ?? 0) > 0) {
      //   ChaptersController.getAllChapterByStoryId(
      //           ChaptersController.storyIdChapter[1], '')
      //       .then((value) {
      //     ActivitiesController.story = ActivitiesController.storyList[1];
      //     customPrint('storyListChapter :: ${ActivitiesController.story}');
      //     isLoading(false);
      //   });
      // } else {
      // fetchData();
      ActivitiesController.titleController.clear();
      ActivitiesController.timeController.clear();
      ActivitiesController.descriptionController.clear();
      isLoading(false);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Obx(() {
      return ProgressHUD(
        isLoading: isLoading.value,
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth / 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await ActivitiesController.getAllActivity('', '')
                              .then((value) {
                            if (value) {
                              ActivitiesController.storyChapter = 'Select';
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
                        'New Activity',
                        style:
                            AppTextStyle.normalBold28.copyWith(color: carlo500),
                      ),
                    ],
                  ),
                  3.ph,
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Story',
                              style: AppTextStyle.normalRegular15
                                  .copyWith(color: labelColor),
                            ),
                            1.ph,
                            MyDropDownNew(
                              // enable: editEnabled ? true : false,
                              color: AppColors.white,

                              borderWidth: 1,
                              defaultValue: ActivitiesController.story,
                              onTap: () {
                                ActivitiesController.chaptersList.clear();
                                ActivitiesController.chaptersList.add('Select');
                                ActivitiesController.chapterId.clear();
                              },
                              onChange: (value) async {
                                setState(() {
                                  ActivitiesController.story = value!;
                                  int idIndex = ActivitiesController.storyList
                                      .indexOf(value);
                                  ActivitiesController.storyIdString(
                                      ActivitiesController
                                          .storyId[idIndex - 1]);
                                  print(
                                      'idNumber :: ${ActivitiesController.storyIdString.value}');

                                  isLoading(true);
                                  ChaptersController.getAllChapterByStoryId(
                                          ActivitiesController
                                              .storyIdString.value,
                                          '')
                                      .then((value) {
                                    for (int i = 0;
                                        i <
                                            (ChaptersController
                                                    .getChapterByStoryId
                                                    .value
                                                    .data
                                                    ?.chapterData
                                                    ?.length ??
                                                0);
                                        i++) {
                                      ActivitiesController.chaptersList.add(
                                          ChaptersController
                                                  .getChapterByStoryId
                                                  .value
                                                  .data
                                                  ?.chapterData?[i]
                                                  .name ??
                                              '');
                                      ActivitiesController.chapterId.add(
                                          ChaptersController
                                                  .getChapterByStoryId
                                                  .value
                                                  .data
                                                  ?.chapterData?[i]
                                                  .id
                                                  .toString() ??
                                              '');
                                    }
                                    isLoading(false);
                                  });
                                });
                                // await SubjectApi.showAllSubjectsByStandard(
                                //     context, selectedGrade);
                              },
                              array: ActivitiesController.storyList,
                            ),
                          ],
                        ),
                      ),
                      3.pw,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Chapter',
                              style: AppTextStyle.normalRegular15
                                  .copyWith(color: labelColor),
                            ),
                            1.ph,
                            MyDropDownNew(
                              color: AppColors.white,
                              borderWidth: 1,
                              defaultValue: ActivitiesController.chapter,
                              onChange: (value) async {
                                setState(() {
                                  ActivitiesController.chapter = value!;
                                  int idIndex = ActivitiesController
                                      .chaptersList
                                      .indexOf(value);
                                  ActivitiesController.chapterIdString(
                                      ActivitiesController
                                          .chapterId[idIndex - 1]);
                                });
                              },
                              array: ActivitiesController.chaptersList,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  3.ph,
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            CustomInfoField(
                              maxCharacters: 50,
                              maxLength: 50,
                              length: ActivitiesController
                                  .titleController.text.length,
                              counter: true,
                              controller: ActivitiesController.titleController,
                              hint: "Healthy Coping Mechanisms",
                              label: 'Activity Title',
                              onChanged: (value) {
                                ActivitiesController.activityCountTitle(
                                    value.length);
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${ActivitiesController.activityCountTitle.value} /50',
                                  //textStyle.labelStyle,
                                  style: textStyle.labelStyle.copyWith(
                                      color: ActivitiesController
                                                  .activityCountTitle.value <=
                                              50
                                          ? textBlack
                                          : Colors.red,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      3.pw,
                      Expanded(
                        child: CustomInfoField(
                          controller: ActivitiesController.timeController,
                          hint: "30",
                          inputType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[0-9.,]+')),
                          ],
                          sufixIcon: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                  child: Text(
                                'Minutes',
                                style: AppTextStyle.normalRegular14
                                    .copyWith(color: ironColor),
                                textAlign: TextAlign.center,
                              )),
                              0.5.pw,
                            ],
                          ),
                          label: 'Time',
                        ),
                      ),
                    ],
                  ),
                  5.ph,
                  SizedBox(
                    height: 180,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              CustomInfoField(
                                maxCharacters: 400,
                                maxLength: 400,
                                counter: true,
                                maxLines: 5,
                                controller:
                                    ActivitiesController.descriptionController,
                                hint: "",
                                label: 'Short Description',
                                onChanged: (value) {
                                  ActivitiesController.activityCountDescription(
                                      value.length);
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${ActivitiesController.activityCountDescription.value} /400',
                                    //textStyle.labelStyle,
                                    style: textStyle.labelStyle.copyWith(
                                        color: ActivitiesController
                                                    .activityCountDescription
                                                    .value <=
                                                400
                                            ? textBlack
                                            : Colors.red,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        2.pw,
                        (ActivitiesController.uploadUrlImageUrlCover.isEmpty ||
                                ActivitiesController
                                        .uploadUrlImageUrlCover.value ==
                                    'null' ||
                                ActivitiesController
                                    .uploadUrlImageCover.isEmpty)
                            ? Expanded(
                                child: Column(
                                  children: [
                                    Expanded(
                                      // flex: 1,
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {
                                            ActivitiesController.pickImage()
                                                .then((value) {
                                              ActivitiesController
                                                  .uploadUrlImageUrlCover('');
                                              ActivitiesController
                                                  .uploadUrlImageCover('');
                                              isLoading(true);
                                              ActivitiesController.uploadImage()
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
                                            // height: screenHeight * 0.1,
                                            margin: const EdgeInsets.only(
                                              top: 28,
                                            ),
                                            width: double.infinity,
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
                                child: Container(
                                  height: 170,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 28),
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: containerBack,
                                    border: Border.all(color: containerBorder),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.network(
                                          '${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlImageCover}',
                                          height: double.infinity,
                                          width: double.infinity,
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: CustomDelete(
                                          onPressed: () {
                                            ActivitiesController
                                                .uploadUrlImageUrlCover('');
                                          },
                                        ),
                                      ),
                                      // GestureDetector(
                                      //     onTap: () {
                                      //       ActivitiesController
                                      //           .uploadUrlImageUrlCover('');
                                      //     },
                                      //     child: SvgPicture.asset(
                                      //         'icons/deleteNew.svg')),
                                    ],
                                  ),
                                ),
                              ),
                        // 3.pw,
                        // ImagePickerWidget(
                        //   svgAsset: 'icons/add.svg',
                        //   text: 'Click to upload\ncover image',
                        //   backgroundColor: containerBack,
                        //   borderColor: arrow,
                        //   svgColor: indigo700,
                        //   textStyle: AppTextStyle.normalRegular15
                        //       .copyWith(color: labelColor),
                        // ),
                      ],
                    ),
                  ),
                  4.ph,
                  SizedBox(
                    height: 200,
                    child: Row(
                      children: [
                        (ActivitiesController.uploadUrlImageUrlStamp.isEmpty ||
                                ActivitiesController
                                        .uploadUrlImageUrlStamp.value ==
                                    'null' ||
                                ActivitiesController
                                    .uploadUrlImageStamp.isEmpty)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        ActivitiesController.pickStampImage()
                                            .then((value) {
                                          ActivitiesController
                                              .uploadUrlImageUrlStamp('');
                                          ActivitiesController
                                              .uploadUrlImageStamp('');
                                          isLoading(true);
                                          ActivitiesController
                                                  .uploadStampImage()
                                              .then((value) {
                                            customPrint(
                                                'imageUrl :: ${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlImageStamp}');
                                            ActivitiesController
                                                .uploadUrlImageUrlStamp(
                                                    '${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlImageStamp}');
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
                                                  .copyWith(color: labelColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Square Image\n(Recommended size 1080×608)',
                                    //textStyle.labelStyle,
                                    style: textStyle.labelStyle.copyWith(
                                        color: bordercolor, fontSize: 12),
                                  ),
                                ],
                              )
                            : Container(
                                height: 170,
                                width: 200,
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: containerBack,
                                  border: Border.all(color: containerBorder),
                                ),
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
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
                                              .uploadUrlImageUrlStamp('');
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
                        2.pw,
                        (ActivitiesController.uploadUrlAudioUrlStamp.isEmpty ||
                                ActivitiesController
                                        .uploadUrlAudioUrlStamp.value ==
                                    'null' ||
                                ActivitiesController
                                    .uploadUrlAudioStamp.isEmpty)
                            ? Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          ActivitiesController.pickStampAudio()
                                              .then((value) {
                                            ActivitiesController
                                                .uploadUrlAudioUrlStamp('');
                                            ActivitiesController
                                                .uploadUrlAudioStamp('');
                                            isLoading(true);
                                            ActivitiesController
                                                    .uploadStampAudio()
                                                .then((value) {
                                              customPrint(
                                                  'audio Url :: ${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlAudioStamp}');
                                              ActivitiesController
                                                  .uploadUrlAudioUrlStamp(
                                                      '${ActivitiesController.uploadUrlAudioStamp}');
                                              isLoading(false);
                                            });
                                          });
                                        },
                                        child: Container(
                                          height: 170,
                                          // width: screenWidth / 3.5,
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
                                    Text(
                                      'MP3 Audio\n',
                                      //textStyle.labelStyle,
                                      style: textStyle.labelStyle.copyWith(
                                          color: bordercolor, fontSize: 12),
                                    ),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: Container(
                                  height: 170,
                                  // width: screenWidth / 3.5,
                                  // margin:
                                  //     const EdgeInsets.symmetric(vertical: 28),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: containerBack,
                                    border: Border.all(color: containerBorder),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AudioPlayerWidget(
                                          audioUrl:
                                              "${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlAudioUrlStamp.value}",
                                          fileName: ActivitiesController
                                              .selectFileNameAudioStamp.value,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: CustomDelete(
                                          onPressed: () {
                                            ActivitiesController
                                                .uploadUrlAudioUrlStamp('');
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        2.pw,
                        (ActivitiesController.uploadUrlImageUrlEnd.isEmpty ||
                                ActivitiesController
                                        .uploadUrlImageUrlEnd.value ==
                                    'null' ||
                                ActivitiesController.uploadUrlImageEnd.isEmpty)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        ActivitiesController.pickEndImage()
                                            .then((value) {
                                          ActivitiesController
                                              .uploadUrlImageUrlEnd('');
                                          ActivitiesController
                                              .uploadUrlImageEnd('');
                                          isLoading(true);
                                          ActivitiesController.uploadEndImage()
                                              .then((value) {
                                            customPrint(
                                                'imageUrl :: ${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlImageEnd}');
                                            ActivitiesController
                                                .uploadUrlImageUrlEnd(
                                                    '${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlImageEnd}');
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
                                              'Click to upload\nEnd image',
                                              style: AppTextStyle
                                                  .normalRegular15
                                                  .copyWith(color: labelColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Round Image\n(Recommended size 320×320)',
                                    //textStyle.labelStyle,
                                    style: textStyle.labelStyle.copyWith(
                                        color: bordercolor, fontSize: 12),
                                  ),
                                ],
                              )
                            : Container(
                                height: 170,
                                width: 200,
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: containerBack,
                                  border: Border.all(color: containerBorder),
                                ),
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
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
                                              .uploadUrlImageUrlEnd('');
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
                  4.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Quiz English*',
                              style: AppTextStyle.normalRegular15
                                  .copyWith(color: labelColor),
                            ),
                            1.ph,
                            // FilePickerWidget(
                            //
                            //   svgAsset: 'icons/add.svg',
                            //   uploadText: 'Click to upload ',
                            //   fileTypeText: 'PDF FILE',
                            //   backgroundColor: containerBack,
                            //   borderColor: arrow,
                            //   svgColor: arrow,
                            //   uploadTextStyle: AppTextStyle.normalRegular15
                            //       .copyWith(color: labelColor),
                            //   fileTypeTextStyle: AppTextStyle.normalBold16
                            //       .copyWith(color: labelColor),
                            // ),
                            (ActivitiesController
                                    .selectFileNameImageEng.isEmpty)
                                ? MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        ActivitiesController.pickFileEngCsv()
                                            .then((value) {
                                          ActivitiesController
                                              .uploadUrlImageUrlEng('');
                                          ActivitiesController
                                              .uploadUrlImageEng('');
                                          isLoading(true);
                                          ActivitiesController.uploadEngCsv()
                                              .then((value) {
                                            customPrint(
                                                'imageUrl :: ${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlImageEng}');
                                            ActivitiesController
                                                .uploadUrlImageUrlEng(
                                                    '${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlImageEng}');
                                            isLoading(false);
                                          });
                                        });
                                      },
                                      child: Container(
                                        height: screenHeight * 0.1,
                                        width: screenWidth / 5,
                                        decoration: BoxDecoration(
                                          color: containerBack,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(color: arrow),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'icons/add.svg',
                                              color: arrow,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Click to upload ',
                                                  style: AppTextStyle
                                                      .normalRegular15
                                                      .copyWith(
                                                          color: labelColor),
                                                ),
                                                Text(
                                                  'CSV FILE',
                                                  style: AppTextStyle
                                                      .normalBold16
                                                      .copyWith(
                                                          color: labelColor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    // height: screenHeight * 0.2,
                                    width: screenWidth / 5,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: containerBack,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: arrow),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Uploaded',
                                          style: AppTextStyle.normalRegular14
                                              .copyWith(color: labelColor),
                                        ),
                                        1.ph,
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                width: 1, color: bordercolor),
                                            color: Color(0xffF5F6F6),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  ActivitiesController
                                                              .selectFileNameImageEng
                                                              .value
                                                              .length >
                                                          20
                                                      ? '${ActivitiesController.selectFileNameImageEng.value.substring(0, 15)}...'
                                                      : ActivitiesController
                                                          .selectFileNameImageEng
                                                          .value,
                                                  style: AppTextStyle
                                                      .normalRegular14
                                                      .copyWith(
                                                          color: labelColor),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                3.pw,
                                                InkWell(
                                                  onTap: () {
                                                    print("Delete file");
                                                    setState(() {
                                                      ActivitiesController
                                                          .selectFileNameImageEng(
                                                              '');
                                                    });
                                                    ActivitiesController
                                                        .selectFileNameImageEng(
                                                            '');
                                                  },
                                                  child: Image.asset(
                                                    'icons/mi_delete.png',
                                                    height: 20,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            Text(
                              'Required',
                              style: AppTextStyle.normalRegular15
                                  .copyWith(color: carlo500),
                            ),
                          ],
                        ),
                      ),
                      2.pw,
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Quiz in Japanese*   (DISABLED)',
                              style: AppTextStyle.normalRegular15
                                  .copyWith(color: labelColor),
                            ),
                            1.ph,
                            // FilePickerWidget(
                            //   svgAsset: 'icons/add.svg',
                            //   uploadText: 'Click to upload ',
                            //   fileTypeText: 'PDF FILE',
                            //   backgroundColor: containerBack,
                            //   borderColor: arrow,
                            //   svgColor: arrow,
                            //   uploadTextStyle: AppTextStyle.normalRegular15
                            //       .copyWith(color: labelColor),
                            //   fileTypeTextStyle: AppTextStyle.normalBold16
                            //       .copyWith(color: labelColor),
                            // ),
                            (ActivitiesController
                                    .selectFileNameImageJap.isEmpty)
                                ? MouseRegion(
                                    // cursor: SystemMouseCursors.click, ///courses hower
                                    child: GestureDetector(
                                      // onTap: () {
                                      //   ActivitiesController.pickFileJapCsv()
                                      //       .then((value) {
                                      //     ActivitiesController
                                      //         .uploadUrlImageUrlJap('');
                                      //     ActivitiesController
                                      //         .uploadUrlImageJap('');
                                      //     isLoading(true);
                                      //     ActivitiesController.uploadJapCsv()
                                      //         .then((value) {
                                      //       customPrint(
                                      //           'imageUrl :: ${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlImageJap}');
                                      //       ActivitiesController
                                      //           .uploadUrlImageUrlJap(
                                      //               '${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlImageJap}');
                                      //       isLoading(false);
                                      //     });
                                      //   });
                                      // },
                                      child: Container(
                                        height: screenHeight * 0.1,
                                        width: screenWidth / 5,
                                        decoration: BoxDecoration(
                                          color: containerBack,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(color: arrow),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'icons/add.svg',
                                              color: arrow,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Click to upload ',
                                                  style: AppTextStyle
                                                      .normalRegular15
                                                      .copyWith(
                                                          color: labelColor),
                                                ),
                                                Text(
                                                  'CSV FILE',
                                                  style: AppTextStyle
                                                      .normalBold16
                                                      .copyWith(
                                                          color: labelColor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    // height: screenHeight * 0.2,
                                    width: screenWidth / 5,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: containerBack,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: arrow),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Uploaded',
                                          style: AppTextStyle.normalRegular14
                                              .copyWith(color: labelColor),
                                        ),
                                        1.ph,
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                width: 1, color: bordercolor),
                                            color: Color(0xffF5F6F6),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  ActivitiesController
                                                              .selectFileNameImageJap
                                                              .value
                                                              .length >
                                                          20
                                                      ? '${ActivitiesController.selectFileNameImageJap.value.substring(0, 15)}...'
                                                      : ActivitiesController
                                                          .selectFileNameImageJap
                                                          .value,
                                                  style: AppTextStyle
                                                      .normalRegular14
                                                      .copyWith(
                                                          color: labelColor),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                3.pw,
                                                InkWell(
                                                  onTap: () {
                                                    print("Delete file");
                                                    setState(() {
                                                      ActivitiesController
                                                          .selectFileNameImageJap(
                                                              '');
                                                    });
                                                    ActivitiesController
                                                        .selectFileNameImageJap(
                                                            '');
                                                  },
                                                  child: Image.asset(
                                                    'icons/mi_delete.png',
                                                    height: 20,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            Text(
                              '',
                              style: AppTextStyle.normalRegular15
                                  .copyWith(color: carlo500),
                            ),
                          ],
                        ),
                      ),
                      2.pw,
                      Expanded(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () async {
                              String url = '';
                              if (debugMode) {
                                if (kDebugMode) {
                                  url = 'images/CSV_Template.csv';
                                }
                              } else {
                                url = 'assets/images/CSV_Template.csv';
                              }
                              print('csv url :: $url');
                              // Load the CSV file from the assets folder
                              final response = await http.get(Uri.parse(url));

                              // Create a Blob from the response bytes
                              final blob = html.Blob([response.bodyBytes]);

                              // Create an object URL from the Blob
                              final uri =
                                  html.Url.createObjectUrlFromBlob(blob);

                              // Create an anchor element for the download
                              final anchor = html.AnchorElement(href: uri)
                                ..setAttribute("download", "CSV_Template.csv")
                                ..click();

                              // Revoke the object URL to free up resources
                              html.Url.revokeObjectUrl(uri);

                              print('CSV file downloaded');
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Download\nTemplate :',
                                  style: AppTextStyle.normalRegular15
                                      .copyWith(color: labelColor),
                                ),
                                1.ph,
                                SvgPicture.asset('icons/svg.svg'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  4.ph,
                  Center(
                    child: SizedBox(
                      width: screenWidth / 4,
                      child: CustomButton(
                        width: double.infinity,
                        onPressed: () async {
                          isLoading(true);
                          if (ActivitiesController.timeController.text == '') {
                            ActivitiesController.timeController.text = '15';
                          }
                          if (ActivitiesController.storyIdString.isEmpty) {
                            showErrorSnackBar(
                                "Please Select Story", colorError);
                            isLoading(false);
                            return;
                          }
                          if (ActivitiesController.chapterIdString.isEmpty) {
                            showErrorSnackBar(
                                "Please Select Chapter", colorError);
                            isLoading(false);
                            return;
                          }

                          final List<TextEditingController> controllerList = [
                            ActivitiesController.titleController,
                            ActivitiesController.timeController,
                            ActivitiesController.descriptionController
                          ];
                          final List<String> fieldsName = [
                            'Activity Title',
                            'Time',
                            'Short Description'
                          ];
                          bool valid = validateMyFields(
                              context, controllerList, fieldsName);
                          if (!valid) {
                            isLoading(false);
                            return;
                          }
                          if (ActivitiesController.uploadUrlImageEng.isEmpty) {
                            showErrorSnackBar("Please Upload CSV", colorError);
                            isLoading(false);
                            return;
                          }
                          final body = {
                            "story_id":
                                ActivitiesController.storyIdString.value,
                            "chapter_id":
                                ActivitiesController.chapterIdString.value,
                            "title": ActivitiesController.titleController.text,
                            "time": ActivitiesController.timeController.text,
                            "short_description ":
                                ActivitiesController.descriptionController.text,
                            if (ActivitiesController
                                    .uploadUrlImageCover.value !=
                                '')
                              "activity_image": ActivitiesController
                                  .uploadUrlImageCover.value,
                            if (ActivitiesController.uploadUrlImageEng.value !=
                                '')
                              "document_english":
                                  ActivitiesController.uploadUrlImageEng.value,
                            if (ActivitiesController.uploadUrlImageJap.value !=
                                '')
                              "document_japanese":
                                  ActivitiesController.uploadUrlImageJap.value,
                            if (ActivitiesController
                                    .uploadUrlImageStamp.value !=
                                '')
                              "image": ActivitiesController
                                  .uploadUrlImageStamp.value,
                            if (ActivitiesController
                                    .uploadUrlAudioUrlStamp.value !=
                                '')
                              "audio": ActivitiesController
                                  .uploadUrlAudioUrlStamp.value,
                            if (ActivitiesController.uploadUrlImageEnd.value !=
                                '')
                              "end_image":
                                  ActivitiesController.uploadUrlImageEnd.value
                          };
                          await ActivitiesController.createActivity(
                                  context, body)
                              .then(
                            (value) async {
                              // List<Map<String, dynamic>> jsonDataFetched =
                              await ActivitiesController.convertFileToJson(
                                  filePath!,
                                  '${DatabaseApi.mainUrlForImage}${ActivitiesController.uploadUrlImageEng.value}');
                              // setState(() {
                              //   jsonData = jsonDataFetched;
                              // });
                              await ActivitiesController.getAllActivity('', '')
                                  .then((value) {
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
                                ActivitiesController.uploadUrlImageUrlCover('');
                                ActivitiesController.selectFileNameImageEng('');
                                ActivitiesController.selectFileNameImageJap('');
                                ActivitiesController.uploadUrlImageStamp('');
                                ActivitiesController.uploadUrlAudioUrlStamp('');
                                ActivitiesController.uploadUrlImageUrlEnd('');
                                isLoading(false);
                              });
                            },
                          );
                        },
                        text: 'Save Activity',
                      ),
                    ),
                  ),
                  1.ph,
                  Center(
                    child: Text(
                      'You can always edit the Activity in the future',
                      style: AppTextStyle.normalRegular14
                          .copyWith(color: labelColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
