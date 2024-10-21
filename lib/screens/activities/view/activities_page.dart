import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yokai_admin/Widgets/progressHud.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/const.dart';

import '../../../Widgets/my_dropdown2.dart';
import '../../../Widgets/new_button.dart';
import '../../../Widgets/new_button2.dart';
import '../../../Widgets/searchbar.dart';
import '../../../utils/text_styles.dart';
import '../../stories/controller/stories_controller.dart';
import '../Controller/activities_Controller.dart';
import 'activities_details_page.dart';
import 'add_new_Activities_page.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key, required this.scaffold});

  final GlobalKey<ScaffoldState> scaffold;

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  RxBool isLoading = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    // print('token ::${prefs?.getString(LocalStorage.token)}');
    isLoading(true);
    await StoriesController.getAllStory('').then((value) async {
      if ((StoriesController.getAllStoriesBy.value.data?.length ?? 0) > 0) {
        for (int i = 0;
            i < (StoriesController.getAllStoriesBy.value.data?.length ?? 0);
            i++) {
          ActivitiesController.storyListChapter
              .add(StoriesController.getAllStoriesBy.value.data?[i].name ?? '');
          ActivitiesController.storyIdChapter.add(
              StoriesController.getAllStoriesBy.value.data?[i].id.toString() ??
                  '');
        }
      }
      await ActivitiesController.getAllActivity('', '').then((value) {
        if (value) {
          ActivitiesController.storyChapter = 'Select';
          ActivitiesController.activitiesPage(0);
          isLoading(false);
        }
      });
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (ActivitiesController.activitiesPage.value == 0)
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: Text(
                                'Activities',
                                style: AppTextStyle.normalBold28
                                    .copyWith(color: carlo500),
                              ),
                            ),
                            5.pw,
                            Expanded(
                              flex: 4,
                              child: CustomSearchBar(
                                hintText: 'Search Activities by Name',
                                controller: ActivitiesController
                                    .searchActivityController,
                                onTextChanged: (p0) async {
                                  print(
                                      "search :: ${(ActivitiesController.storyChapter != 'Select') ? ActivitiesController.storyIdStringChapter.value : ''}");
                                  await ActivitiesController.getAllActivity(
                                          ActivitiesController
                                              .searchActivityController.text,
                                          (ActivitiesController.storyChapter !=
                                                  'Select')
                                              ? ActivitiesController
                                                  .storyIdStringChapter.value
                                              : '')
                                      .then((value) {});
                                },
                              ),
                            ),
                            5.pw,
                            Expanded(
                              flex: 3,
                              child: CustomButton(
                                width: double.infinity,
                                onPressed: () {
                                  ActivitiesController.isEdit(false);
                                  ActivitiesController.activitiesPage(1);
                                },
                                text: 'Add Activity',
                                iconSvgPath: 'icons/add.svg',
                              ),
                            ),
                          ],
                        ),
                        3.ph,
                        SizedBox(
                          width: screenWidth / 3.5,
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
                                defaultValue: ActivitiesController.storyChapter,
                                onChange: (value) async {
                                  setState(() {
                                    ActivitiesController.storyChapter = value!;
                                    if (value == 'Select') {
                                      isLoading(true);
                                      ActivitiesController.getAllActivity(
                                              '', '')
                                          .then((value) {
                                        isLoading(false);
                                      });
                                    } else {
                                      int idIndex = ActivitiesController
                                          .storyListChapter
                                          .indexOf(value);
                                      ActivitiesController.storyIdStringChapter(
                                          ActivitiesController
                                              .storyIdChapter[idIndex - 1]);
                                      print(
                                          'idNumber :: ${ActivitiesController.storyIdStringChapter.value}');
                                      isLoading(true);
                                      ActivitiesController.getAllActivity(
                                              '',
                                              ActivitiesController
                                                  .storyIdStringChapter.value)
                                          .then((value) {
                                        isLoading(false);
                                      });
                                    }
                                  });
                                  // await SubjectApi.showAllSubjectsByStandard(
                                  //     context, selectedGrade);
                                },
                                array: ActivitiesController.storyListChapter,
                              ),
                            ],
                          ),
                        ),
                        5.ph,
                        Table(
                          children: [
                            TableRow(
                              decoration: const BoxDecoration(color: carlo50),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10, top: 15, bottom: 15),
                                  child: Row(
                                    children: [
                                      // Expanded(
                                      //   child: MyDropDown(
                                      //     // enable: editEnabled ? true : false,
                                      //     color: carlo50,
                                      //     borderWidth: 1,
                                      //     defaultValue: ActivitiesController.date,
                                      //     onChange: (value) async {
                                      //       setState(() {
                                      //         ActivitiesController.date = value!;
                                      //       });
                                      //       // await SubjectApi.showAllSubjectsByStandard(
                                      //       //     context, selectedGrade);
                                      //     },
                                      //     array: ActivitiesController.dateList,
                                      //   ),
                                      // ),
                                      Expanded(
                                        child: Text(
                                          'Date',
                                          style: AppTextStyle.normalRegular16
                                              .copyWith(color: hoverColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Activity Name',
                                          style: AppTextStyle.normalRegular16
                                              .copyWith(color: hoverColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      // Expanded(
                                      //   child: MyDropDown(
                                      //     // enable: editEnabled ? true : false,
                                      //     color: carlo50,
                                      //     borderWidth: 1,
                                      //     defaultValue:
                                      //         ActivitiesController.chapterNo,
                                      //     onChange: (value) async {
                                      //       setState(() {
                                      //         ActivitiesController.chapterNo =
                                      //             value!;
                                      //       });
                                      //       // await SubjectApi.showAllSubjectsByStandard(
                                      //       //     context, selectedGrade);
                                      //     },
                                      //     array: ActivitiesController.chapterNoList,
                                      //   ),
                                      // ),
                                      Expanded(
                                        child: Text(
                                          'Chapter No.',
                                          style: AppTextStyle.normalRegular16
                                              .copyWith(color: hoverColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Story',
                                          style: AppTextStyle.normalRegular16
                                              .copyWith(color: hoverColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Actions',
                                          style: AppTextStyle.normalRegular16
                                              .copyWith(color: hoverColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            ((ActivitiesController.getActivityAll.value.data
                                            ?.length ??
                                        0) >
                                    0)
                                ? TableRow(
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        // itemCount: 2,
                                        itemCount: ActivitiesController
                                            .getActivityAll.value.data?.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        DateFormat('dd-MM-yyyy').format(
                                                            DateTime.tryParse(ActivitiesController
                                                                        .getActivityAll
                                                                        .value
                                                                        .data?[
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
                                                    Expanded(
                                                      child: Text(
                                                        ActivitiesController
                                                                .getActivityAll
                                                                .value
                                                                .data?[index]
                                                                .title
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
                                                    Expanded(
                                                      child: Text(
                                                        // 'NA',
                                                        ActivitiesController
                                                                .getActivityAll
                                                                .value
                                                                .data?[index]
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
                                                    Expanded(
                                                      child: Text(
                                                        // 'NA',
                                                        ActivitiesController
                                                                .getActivityAll
                                                                .value
                                                                .data?[index]
                                                                .storyName
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
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                              onTap: () {
                                                                ActivitiesController.activityIdForEditActivity(ActivitiesController
                                                                        .getActivityAll
                                                                        .value
                                                                        .data?[
                                                                            index]
                                                                        .id
                                                                        .toString() ??
                                                                    '');
                                                                ActivitiesController
                                                                    .isEdit(
                                                                        true);
                                                                ActivitiesController
                                                                    .activitiesPage(
                                                                        2);
                                                              },
                                                              child: SvgPicture
                                                                  .asset(
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
                                                                        width: MediaQuery.of(context).size.width /
                                                                            2.7,
                                                                        // height: MediaQuery.of(context)
                                                                        //         .size
                                                                        //         .height /
                                                                        //     3,
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                15,
                                                                            vertical:
                                                                                40),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius: BorderRadius.circular(15.0),
                                                                            boxShadow: [
                                                                              BoxShadow(offset: const Offset(12, 26), blurRadius: 50, spreadRadius: 0, color: Colors.grey.withOpacity(.1)),
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
                                                                                  'Delete Activity',
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
                                                                                    "Are you sure you want to delete this Activity ?",
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
                                                                                          ActivitiesController.deleteActivity(context, ActivitiesController.getActivityAll.value.data?[index].id.toString() ?? '').then((value) {
                                                                                            Navigator.pop(context);
                                                                                            fetchData();
                                                                                          });
                                                                                        },
                                                                                        text: 'Delete Activity',
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
                      ],
                    ),
                  ),
                ),
              if (ActivitiesController.activitiesPage.value == 1)
                Expanded(child: AddNewActivitiesPage()),
              if (ActivitiesController.activitiesPage.value == 2)
                Expanded(child: ActivitiesDetailsPage()),
            ],
          ),
        ),
      );
    });
  }
}
