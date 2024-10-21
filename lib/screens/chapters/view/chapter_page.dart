import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yokai_admin/Widgets/progressHud.dart';
import 'package:yokai_admin/globalVariable.dart';
import 'package:yokai_admin/screens/chapters/view/add_chapter_page.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/const.dart';

import '../../../Widgets/my_dropdown.dart';
import '../../../Widgets/my_dropdown2.dart';
import '../../../Widgets/new_button.dart';
import '../../../Widgets/new_button2.dart';
import '../../../Widgets/searchbar.dart';
import '../../../utils/text_styles.dart';
import '../../stories/controller/stories_controller.dart';
import '../controller/chapters_controller.dart';
import 'Edit_chapter_details_page.dart';

class ChaptersPage extends StatefulWidget {
  const ChaptersPage({Key? key, required this.scaffold}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffold;

  @override
  State<ChaptersPage> createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage> {
  RxBool isLoading = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ChaptersController.chapterId('');
    fetchData().then(
      (value) {
        ChaptersController.chapterPage(0);
      },
    );
    ChaptersController.chapterPage.listen((p0) {
      fetchData();
    });
  }

  Future fetchData() async {
    isLoading(true);
    await StoriesController.getAllStory('').then((value) async {
      if ((StoriesController.getAllStoriesBy.value.data?.length ?? 0) > 0) {
        for (int i = 0;
            i < (StoriesController.getAllStoriesBy.value.data?.length ?? 0);
            i++) {
        ChaptersController.storyListChapter
            .add(StoriesController.getAllStoriesBy.value.data?[i].name ?? '');
        ChaptersController.storyIdChapter.add(
            StoriesController.getAllStoriesBy.value.data?[i].id.toString() ??
                '');
      }
      }
      if (ChaptersController.storyNameSaveForDropDown.isNotEmpty &&
          ChaptersController.storyIdSaveForDropDown.isNotEmpty) {
        await ChaptersController.getAllChapterByStoryId('', '').then((value) {
          ChaptersController.storyChapter =
              ChaptersController.storyNameSaveForDropDown.value;
          customPrint('storyListChapter :: ${ChaptersController.storyChapter}');
          setState(() {});
          isLoading(false);
        });
      } else {
        if ((StoriesController.getAllStoriesBy.value.data?.length ?? 0) > 0) {
          await ChaptersController.getAllChapterByStoryId('', '').then((value) {
            // ChaptersController.storyChapter =
            //     ChaptersController.storyListChapter[1];
            // customPrint('storyListChapter :: ${ChaptersController.storyChapter}');
            setState(() {});
            isLoading(false);
        });
        } else {
          isLoading(false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Obx( () {
      return ProgressHUD(
        isLoading: isLoading.value,
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (ChaptersController.chapterPage.value == 0)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chapters',
                            style: AppTextStyle.normalBold28
                                .copyWith(color: carlo500),
                          ),
                          CustomButton(
                              text: 'Add Chapter',
                              iconSvgPath: 'icons/add.svg',
                              textSize: 16,
                              width: screenWidth / 8,
                              onPressed: () {
                                ChaptersController.isEdit(false);
                                ChaptersController.forStorySelect(false);
                                ChaptersController.isEditDetails(false);
                                ChaptersController.chapterPage(1);
                              }),
                        ],
                      ),
                      5.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: screenWidth / 4,
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
                                  defaultValue: ChaptersController.storyChapter,
                                  onChange: (value) async {
                                    setState(() async {
                                      if (value == 'Select') {
                                        isLoading(true);
                                        await ChaptersController.getAllChapterByStoryId('', '').then((value) {
                                          isLoading(false);
                                        });
                                      } else {
                                        ChaptersController.storyChapter =
                                            value!;
                                        int idIndex = ChaptersController
                                            .storyListChapter
                                            .indexOf(value);
                                        ChaptersController.storyIdStringChapter(
                                            ChaptersController
                                                .storyIdChapter[idIndex - 1]);
                                        print(
                                            'idNumber :: ${ChaptersController.storyIdStringChapter.value}');
                                        isLoading(true);
                                        await ChaptersController
                                                .getAllChapterByStoryId(
                                                    ChaptersController
                                                        .storyIdStringChapter
                                                        .value,
                                                    '')
                                            .then((value) {
                                          isLoading(false);
                                        });
                                      }
                                    });
                                    // await SubjectApi.showAllSubjectsByStandard(
                                    //     context, selectedGrade);
                                  },
                                  array: ChaptersController.storyListChapter,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenWidth / 5,
                            child: Column(
                              children: [
                                Text(
                                  '',
                                  style: AppTextStyle.normalRegular15
                                      .copyWith(color: labelColor),
                                ),
                                1.ph,
                                CustomSearchBar(
                                  hintText: 'Search Chapter by Name',
                                  controller: ChaptersController
                                      .searchChapterController,
                                  onTextChanged: (p0) async {
                                    if ((StoriesController.getAllStoriesBy.value
                                                .data?.length ??
                                            0) >
                                        0) {
                                      isLoading(true);
                                      await ChaptersController
                                              .getAllChapterByStoryId(
                                                  ChaptersController
                                                      .storyIdStringChapter
                                                      .value,
                                                  ChaptersController
                                                      .searchChapterController
                                                      .text)
                                          .then((value) {
                                        ChaptersController.storyChapter =
                                            ChaptersController
                                                .storyListChapter[1];
                                        customPrint(
                                            'storyListChapter :: ${ChaptersController.storyChapter}');
                                        isLoading(false);
                                      });
                                    } else {
                                      isLoading(false);
                                    }
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      5.ph,
                      Table(
                        children: [
                          TableRow(
                            decoration: const BoxDecoration(color: carlo50),
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: MyDropDown(
                                      // enable: editEnabled ? true : false,
                                      color: carlo50,
                                      borderWidth: 1,
                                      defaultValue: ChaptersController.dateEdit,
                                      onChange: (value) async {
                                        setState(() {
                                          ChaptersController.dateEdit = value!;
                                        });
                                        // await SubjectApi.showAllSubjectsByStandard(
                                        //     context, selectedGrade);
                                      },
                                      array: ChaptersController.dateEditList,
                                    ),
                                  ),
                                  2.pw,
                                  Expanded(
                                    child: MyDropDown(
                                      // enable: editEnabled ? true : false,
                                      color: carlo50,
                                      borderWidth: 1,
                                      defaultValue: ChaptersController.chapter,
                                      onChange: (value) async {
                                        setState(() {
                                          ChaptersController.chapter = value!;
                                        });
                                        // await SubjectApi.showAllSubjectsByStandard(
                                        //     context, selectedGrade);
                                      },
                                      array: ChaptersController.chapterList,
                                    ),
                                  ),
                                  2.pw,
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Title',
                                      style: AppTextStyle.normalRegular16
                                          .copyWith(color: hoverColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  2.pw,
                                  Expanded(
                                    child: MyDropDown(
                                      // enable: editEnabled ? true : false,
                                      color: carlo50,
                                      borderWidth: 1,
                                      defaultValue: ChaptersController.activity,
                                      onChange: (value) async {
                                        setState(() {
                                          ChaptersController.activity = value!;
                                        });
                                        // await SubjectApi.showAllSubjectsByStandard(
                                        //     context, selectedGrade);
                                      },
                                      array: ChaptersController.activityList,
                                    ),
                                  ),
                                  2.pw,
                                  Expanded(
                                    child: Text(
                                      'Action',
                                      style: AppTextStyle.normalRegular16
                                          .copyWith(color: hoverColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          ((ChaptersController.getChapterByStoryId.value.data
                                          ?.chapterData?.length ??
                                      0) >
                                  0)
                              ? TableRow(
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: ChaptersController
                                          .getChapterByStoryId
                                          .value
                                          .data
                                          ?.chapterData
                                          ?.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      DateFormat('dd-MM-yyyy').format(
                                                          DateTime.tryParse(ChaptersController
                                                                      .getChapterByStoryId
                                                                      .value
                                                                      .data
                                                                      ?.chapterData?[
                                                                          index]
                                                                      .createdAt
                                                                      .toString() ??
                                                                  '') ??
                                                              DateTime.now()),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: AppTextStyle
                                                          .normalRegular14
                                                          .copyWith(
                                                              color: grey2),
                                                    ),
                                                  ),
                                                  2.pw,
                                                  Expanded(
                                                    child: Text(
                                                      ChaptersController
                                                              .getChapterByStoryId
                                                              .value
                                                              .data
                                                              ?.chapterData?[
                                                                  index]
                                                              .chapterNo
                                                              .toString() ??
                                                          '',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: AppTextStyle
                                                          .normalRegular14
                                                          .copyWith(
                                                              color: grey2),
                                                    ),
                                                  ),
                                                  2.pw,
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      ChaptersController
                                                              .getChapterByStoryId
                                                              .value
                                                              .data
                                                              ?.chapterData?[
                                                                  index]
                                                              .name
                                                              .toString() ??
                                                          '',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: AppTextStyle
                                                          .normalRegular14
                                                          .copyWith(
                                                              color: grey2),
                                                    ),
                                                  ),
                                                  2.pw,
                                                  Expanded(
                                                    child: Text(
                                                      // 'No',
                                                      ChaptersController
                                                              .getChapterByStoryId
                                                              .value
                                                              .data
                                                              ?.chapterData?[
                                                                  index]
                                                              .activityStatus
                                                              .toString() ??
                                                          '',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: AppTextStyle.normalRegular14.copyWith(
                                                          fontWeight: (((ChaptersController
                                                                          .getChapterByStoryId
                                                                          .value
                                                                          .data
                                                                          ?.chapterData?[
                                                                              index]
                                                                          .activityStatus
                                                                          .toString() ??
                                                                      '') ==
                                                                  'yes'))
                                                              ? FontWeight.w700
                                                              : FontWeight.w500,
                                                          color: ((ChaptersController
                                                                          .getChapterByStoryId
                                                                          .value
                                                                          .data
                                                                          ?.chapterData?[
                                                                              index]
                                                                          .activityStatus
                                                                          .toString() ??
                                                                      '') ==
                                                                  'yes')
                                                              ? indigo800
                                                              : carlo600),
                                                    ),
                                                  ),
                                                  2.pw,
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        InkWell(
                                                            onTap: () {
                                                              ChaptersController
                                                                  .isEdit(true);

                                                              ChaptersController
                                                                  .chapterPage(
                                                                      2);
                                                              ChaptersController.chapterId(ChaptersController
                                                                      .getChapterByStoryId
                                                                      .value
                                                                      .data
                                                                      ?.chapterData?[
                                                                          index]
                                                                      .id
                                                                      .toString() ??
                                                                  '');
                                                            },
                                                            child: SvgPicture.asset(
                                                                'icons/edit.svg')),
                                                        1.pw,
                                                        InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Dialog(
                                                                    elevation:
                                                                        1,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15)),
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          2.7,
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height /
                                                                          3.5,
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              15),
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(15.0),
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                                offset: const Offset(12, 26),
                                                                                blurRadius: 50,
                                                                                spreadRadius: 0,
                                                                                color: Colors.grey.withOpacity(.1)),
                                                                          ]),
                                                                      child:
                                                                          SingleChildScrollView(
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    Get.back();
                                                                                  },
                                                                                  child: SvgPicture.asset('icons/cancel.svg'),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Center(
                                                                              child: Text(
                                                                                'Delete Chapter',
                                                                                style: AppTextStyle.normalBold18.copyWith(color: textDark),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  "Are you sure you want to delete this Chapter ?",
                                                                                  style: AppTextStyle.normalRegular14.copyWith(color: textDark),
                                                                                ),
                                                                                3.ph,
                                                                                Text(
                                                                                  "It will be deleted for all teachers users and\nany data related to it will not be recovered.",
                                                                                  style: AppTextStyle.normalRegular14.copyWith(color: textDark),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            3.ph,
                                                                            Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: CustomButton(
                                                                                      width: screenWidth / 9,
                                                                                      textSize: 14,
                                                                                      onPressed: () {
                                                                                        isLoading(true);
                                                                                        ChaptersController.deleteChapter(context, ChaptersController.getChapterByStoryId.value.data?.chapterData?[index].id.toString() ?? '').then((value) {
                                                                                          fetchData();
                                                                                          Navigator.pop(context);
                                                                                          isLoading(false);
                                                                                        });
                                                                                      },
                                                                                      text: 'Delete Chapter',
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: screenWidth / 20,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: CustomButton2(
                                                                                      width: screenWidth / 10,
                                                                                      textSize: 14,
                                                                                      color: indigo700,
                                                                                      colorText: indigo700,
                                                                                      onPressed: () {
                                                                                        Get.back();
                                                                                      },
                                                                                      text: 'Cancel',
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                          child: SvgPicture.asset(
                                                              'icons/delete.svg'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Divider(
                                              color: bottomBorder,
                                            )
                                          ],
                                        );
                                      },
                                    )
                                  ],
                                )
                              : TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Center(
                                        child: Text(
                                          'No Data Found',
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle.normalRegular14
                                              .copyWith(color: indigo800),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                      10.ph,
                    ],
                  ),
                if (ChaptersController.chapterPage.value == 1)
                  SizedBox(
                    height: screenHeight,
                    child: AddNewChapter(
                      storyName: ChaptersController.storyChapter,
                      storyId: ChaptersController.storyIdStringChapter.value,
                    ),
                  ),
                if (ChaptersController.chapterPage.value == 2)
                  SizedBox(
                      height: screenHeight,
                      child: EditChapterDetailsPAge()),
              ],
            ),
          ),
        ),
      );
    }
    );
  }
}
