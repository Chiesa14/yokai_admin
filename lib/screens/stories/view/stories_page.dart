import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yokai_admin/Widgets/progressHud.dart';
import 'package:yokai_admin/globalVariable.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/const.dart';

import '../../../Widgets/custom_delete_button.dart';
import '../../../Widgets/my_dropdown.dart';
import '../../../Widgets/my_dropdown2.dart';
import '../../../Widgets/my_textfield.dart';
import '../../../Widgets/new_button.dart';
import '../../../Widgets/new_button2.dart';
import '../../../Widgets/searchbar.dart';
import '../../../api/database.dart';
import '../../../utils/text_styles.dart';
import '../../chapters/controller/chapters_controller.dart';
import '../controller/stories_controller.dart';

class StoriesPage extends StatefulWidget {
  const StoriesPage({Key? key, required this.scaffold}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffold;

  @override
  State<StoriesPage> createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage> {
  static RxBool isLoading = true.obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // isLoading(true);

    StoriesController.getAllStory('').then((value) {
      if(value) {
        StoriesController.storiesPage(0);
        isLoading(false);
      }
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
            child: Column(
              children: [
                if (StoriesController.storiesPage.value == 0)
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Text(
                              'Stories',
                              style: AppTextStyle.normalBold28
                                  .copyWith(color: carlo500),
                            ),
                          ),
                          5.pw,
                           Expanded(
                            flex: 4,
                            child: CustomSearchBar(
                              hintText: 'Search Stories by Name',
                              controller: StoriesController.searchStoriesController,
                              onTextChanged: (p0) {
                                isLoading(true);
                                StoriesController.getAllStory(StoriesController.searchStoriesController.text).then((value) {
                                  isLoading(false);
                                });
                              },
                            ),
                          ),
                          5.pw,
                          Expanded(
                            flex: 3,
                            child: CustomButton(
                              width: double.infinity,
                              onPressed: () {
                                StoriesController.isEdit(false);
                                StoriesController.storiesPage(1);
                              },
                              text: 'Add Story',
                              iconSvgPath: 'icons/add.svg',
                            ),
                          ),
                        ],
                      ),
                      2.ph,
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
                                    Expanded(
                                      child: MyDropDown(
                                        // enable: editEnabled ? true : false,
                                        color: carlo50,
                                        borderWidth: 1,
                                        defaultValue: StoriesController.date,
                                        onChange: (value) async {
                                          setState(() {
                                            StoriesController.date = value!;
                                          });
                                          // await SubjectApi.showAllSubjectsByStandard(
                                          //     context, selectedGrade);
                                        },
                                        array: StoriesController.dateList,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Title',
                                        style: AppTextStyle.normalRegular16
                                            .copyWith(color: hoverColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Character',
                                        style: AppTextStyle.normalRegular16
                                            .copyWith(color: hoverColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: MyDropDown(
                                        // enable: editEnabled ? true : false,
                                        color: carlo50,
                                        borderWidth: 1,
                                        defaultValue: StoriesController.chapters,
                                        onChange: (value) async {
                                          setState(() {
                                            StoriesController.chapters = value!;
                                          });
                                          // await SubjectApi.showAllSubjectsByStandard(
                                          //     context, selectedGrade);
                                        },
                                        array: StoriesController.chaptersList,
                                      ),
                                    ),
                                    Expanded(
                                      child: MyDropDown(
                                        // enable: editEnabled ? true : false,
                                        color: carlo50,
                                        borderWidth: 1,
                                        defaultValue:
                                            StoriesController.activities,
                                        onChange: (value) async {
                                          setState(() {
                                            StoriesController.activities = value!;
                                          });
                                          // await SubjectApi.showAllSubjectsByStandard(
                                          //     context, selectedGrade);
                                        },
                                        array: StoriesController.activitiesList,
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
                          ((StoriesController
                                          .getAllStoriesBy.value.data?.length ??
                                      0) >
                                  0)
                              ? TableRow(
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: StoriesController
                                          .getAllStoriesBy.value.data?.length,
                                      itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  DateFormat('dd-MM-yyyy').format(
                                                      DateTime.tryParse(
                                                              StoriesController
                                                                      .getAllStoriesBy
                                                                      .value
                                                                      .data?[
                                                                          index]
                                                                      .createdAt
                                                                      .toString() ??
                                                                  '') ??
                                                          DateTime.now()),
                                                  textAlign: TextAlign.center,
                                                  style: AppTextStyle
                                                      .normalRegular14
                                                      .copyWith(color: grey2),
                                                ),
                                              ),
                                              Expanded(
                                              flex: 2,
            
                                              child: Text(
                                                  // 'A summer adventure',
                                                  StoriesController
                                                          .getAllStoriesBy
                                                          .value
                                                          .data?[index]
                                                          .name
                                                          .toString() ??
                                                      '',
                                                  textAlign: TextAlign.center,
                                                  style: AppTextStyle
                                                      .normalRegular14
                                                      .copyWith(color: grey2),
                                                ),
                                              ),
                                              Expanded(
                                              child: Text(
                                                  'NA',
                                                  // StoriesController
                                                  //     .getAllStoriesBy
                                                  //     .value
                                                  //     .data?[index]
                                                  //     .createdAt
                                                  //     .toString() ??
                                                  //     '',
                                                  textAlign: TextAlign.center,
                                                  style: AppTextStyle
                                                      .normalRegular14
                                                      .copyWith(color: grey2),
                                                ),
                                              ),
                                              Expanded(
                                              child: Text(
                                                  // 'NA',
                                                StoriesController
                                                    .getAllStoriesBy
                                                    .value
                                                    .data?[index]
                                                    .chapterCount
                                                    .toString() ??
                                                    '',
                                                  textAlign: TextAlign.center,
                                                  style: AppTextStyle
                                                      .normalRegular14
                                                      .copyWith(color: grey2),
                                                ),
                                              ),
                                              Expanded(
                                              child: Text(
                                                  // 'NA',
                                                StoriesController
                                                    .getAllStoriesBy
                                                    .value
                                                    .data?[index]
                                                    .activityCount
                                                    .toString() ??
                                                    '',
                                                  textAlign: TextAlign.center,
                                                  style: AppTextStyle
                                                      .normalRegular14
                                                      .copyWith(color: grey2),
                                                ),
                                              ),
                                              Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                          isLoading(true);
                                                          StoriesController
                                                              .storyId();
                                                          StoriesController
                                                              .isEdit(true);
                                                          StoriesController
                                                              .getStoriesDataById(
                                                            StoriesController
                                                                    .getAllStoriesBy
                                                                    .value
                                                                    .data?[index]
                                                                    .id
                                                                    .toString() ??
                                                                '',
                                                          ).then((value) {
                                                            StoriesController
                                                                .titleController
                                                                .text = StoriesController
                                                                    .getStoriesById
                                                                    .value
                                                                    .data
                                                                    ?.name
                                                                    .toString() ??
                                                                '';
                                                            StoriesController
                                                                .descriptionController
                                                                .text = StoriesController
                                                                    .getStoriesById
                                                                    .value
                                                                    .data
                                                                    ?.discription
                                                                    .toString() ??
                                                                '';
                                                                StoriesController
                                                                    .titleController
                                                                    .text = StoriesController
                                                                        .getStoriesById
                                                                        .value
                                                                        .data
                                                                        ?.name
                                                                        .toString() ??
                                                                    '';
                                                                StoriesController.storyIdForUpdateStory(
                                                                    StoriesController
                                                                            .getAllStoriesBy
                                                                            .value
                                                                            .data?[
                                                                                index]
                                                                            .id
                                                                            .toString() ??
                                                                        '');
                                                                StoriesController.uploadUrlImageUrl(
                                                                    StoriesController
                                                                            .getStoriesById
                                                                            .value
                                                                            .data
                                                                            ?.storiesImage
                                                                            .toString() ??
                                                                        '');
                                                                StoriesController.uploadUrlImage(
                                                                    StoriesController
                                                                            .getStoriesById
                                                                            .value
                                                                            .data
                                                                            ?.storiesImage
                                                                            .toString() ??
                                                                        '');
                                                                customPrint(
                                                                    'uploadUrlImage :: #${StoriesController.uploadUrlImageUrl.value}#');
                                                                customPrint(
                                                                    'uploadUrlImage :: #${DatabaseApi.mainUrlForImage}${StoriesController.uploadUrlImageUrl.value}#');
                                                                StoriesController
                                                                    .storiesPage(
                                                                        1);
                                                                isLoading(false);
                                                              });
                                                            },
                                                            child: SvgPicture.asset(
                                                            'icons/edit.svg')),
                                                    1.pw,
                                                    InkWell(
                                                    onTap: () {
                                                            showDialog(
                                                                context: context,
                                                                builder:
                                                                    (context) {
                                                                  return Dialog(
                                                                    elevation: 1,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                15)),
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          2.7,
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height /
                                                                          3,
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
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.end,
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
                                                                              child:
                                                                                  Text(
                                                                                'Delete Story',
                                                                                style: AppTextStyle.normalBold18.copyWith(color: textDark),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              height:
                                                                                  15,
                                                                            ),
                                                                            Column(
                                                                              crossAxisAlignment:
                                                                                  CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  "Are you sure you want to delete this Story ?",
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
                                                                              padding:
                                                                                  const EdgeInsets.symmetric(horizontal: 10),
                                                                              child:
                                                                                  Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: CustomButton(
                                                                                      width: screenWidth / 9,
                                                                                      textSize: 14,
                                                                                      onPressed: () {
                                                                                        StoriesController.deleteStories(context, StoriesController.getAllStoriesBy.value.data?[index].id.toString() ?? '').then((value) {
                                                                                          isLoading(true);
                                                                                          StoriesController.getAllStory('').then((value) {
                                                                                            Navigator.pop(context);
                                                                                            isLoading(false);
            
                                                                                          });
                                                                                        });
                                                                                      },
                                                                                      text: 'Delete Story',
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
                if (StoriesController.storiesPage.value == 1)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth / 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  StoriesController.titleController.clear();
                                  StoriesController.descriptionController.clear();
                                  StoriesController.uploadUrlImage('');
                                  StoriesController.uploadUrlImageUrl('');
                                  StoriesController.storiesPage(0);
                                },
                                child: SvgPicture.asset('icons/back.svg',height: 35,width: 35,),),1.pw,
                            Text(
                              (StoriesController.isEdit.isFalse)
                                  ? 'New Story'
                                  : 'Story Details',
                              style:
                                  AppTextStyle.normalBold28.copyWith(color: carlo500),
                            ),
                          ],
                        ),
                        2.ph,
                        // (StoriesController.isEdit.isFalse)
                        //     ?
                        CustomInfoField(
                                maxCharacters: 50,
                                maxLength: 50,
                                counter: false,
                                controller: StoriesController.titleController,
                                hint: "The mystery deepens in wonderland",
                                label: 'Title',
                                onChanged: (value) {
                                  StoriesController.characterCountTitle(
                                      value.length);
                                },
                              ),
                            // : Text(
                            //     'Title : ${StoriesController.getStoriesById.value.data?.name.toString() ?? ''}',
                            //     style: AppTextStyle.normalRegular20
                            //         .copyWith(color: ironColor),
                            //   ),
                        if (StoriesController.isEdit.isFalse)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${StoriesController.characterCountTitle.value} /50',
                                //textStyle.labelStyle,
                                style: textStyle.labelStyle.copyWith(
                                    color: StoriesController
                                                .characterCountTitle.value <=
                                            50
                                        ? textBlack
                                        : Colors.red,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        3.ph,
                        SizedBox(
                          height: 180,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Column(
                                  children: [
                                    CustomInfoField(
                                      // height: screenHeight * 0.2,
                                      maxCharacters: 400,
                                      maxLength: 400,
                                      maxLines: 5,
                                      counter: true,
                                      controller:
                                          StoriesController.descriptionController,
                                      hint: "Counting the stars until sunrise",
                                      label: 'Short Description',
                                      onChanged: (value) {
                                        StoriesController
                                            .characterCountDescription(
                                                value.length);
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${StoriesController.characterCountDescription.value} /400',
                                          //textStyle.labelStyle,
                                          style: textStyle.labelStyle.copyWith(
                                              color: StoriesController
                                                          .characterCountDescription
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
                              (StoriesController.uploadUrlImageUrl.isEmpty)
                                  ? Expanded(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              StoriesController.pickImage()
                                                  .then((value) {
                                                StoriesController.uploadUrlImageUrl(
                                                    '');
                                                StoriesController.uploadUrlImage('');
                                                isLoading(true);
                                                StoriesController.uploadImage()
                                                    .then((value) {
                                                  customPrint(
                                                      'imageUrl :: ${DatabaseApi.mainUrlForImage}${StoriesController.uploadUrlImage}');
                                                  StoriesController.uploadUrlImageUrl(
                                                      '${DatabaseApi.mainUrlForImage}${StoriesController.uploadUrlImage}');
                                                  isLoading(false);
                                                });
                                              });
                                            },
                                            child: Container(
                                              // height: screenHeight * 0.1,
                                              width: double.infinity,
                                              margin: const EdgeInsets.only(top: 28, ),
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
                                                        .copyWith(color: labelColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        0.5.ph,
                                        Text(
                                          'Square Image\n(Recommended size 720×1280)',
                                          //textStyle.labelStyle,
                                          style: textStyle.labelStyle.copyWith(
                                              color: bordercolor,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  )
                                  : Expanded(
                                      child: Container(
                                        height: 170,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 28),
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: containerBack,
                                          border:
                                              Border.all(color: containerBorder),
                                        ),
                                        child: Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.network(
                                                '${DatabaseApi.mainUrlForImage}${StoriesController.uploadUrlImage}',
                                                height: double.infinity,
                                                width: double.infinity,
                                              ),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  StoriesController
                                                      .uploadUrlImageUrl('');
                                                },
                                                child: SvgPicture.asset(
                                                    'icons/deleteNew.svg')),
                                          ],
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        3.ph,
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Character (will be unlocked on Ch. 5) ',
                                    style: AppTextStyle.normalRegular15
                                        .copyWith(color: labelColor),
                                  ),
                                  MyDropDownNew(
                                    // enable: editEnabled ? true : false,
                                    color: AppColors.white,
            
                                    borderWidth: 1,
                                    defaultValue: StoriesController.character,
                                    onChange: (value) async {
                                      setState(() {
                                        StoriesController.character = value!;
                                      });
                                      // await SubjectApi.showAllSubjectsByStandard(
                                      //     context, selectedGrade);
                                    },
                                    array: StoriesController.characterList,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    '',
                                    style: AppTextStyle.normalRegular15
                                        .copyWith(color: labelColor),
                                  ),
                                  (StoriesController.isEdit.isFalse)
                                      ? CustomButton(
                                          width: double.infinity,
                                          onPressed: () {
                                            isLoading(true);
                                            final List<TextEditingController>
                                                controllerList = [
                                              StoriesController.titleController,
                                              StoriesController
                                                  .descriptionController
                                            ];
                                            final List<String> fieldsName = [
                                              'Title',
                                              'Description',
                                            ];
                                            bool valid = validateMyFields(context,
                                                controllerList, fieldsName);
                                            if (!valid) {
                                              isLoading(false);
                                              return;
                                            }
                                            final body = {
                                              "name": StoriesController
                                                  .titleController.text,
                                              "discription": StoriesController
                                                  .descriptionController.text,
                                              "stories_image": StoriesController
                                                  .uploadUrlImage.value
                                            };
                                            StoriesController.createStories(
                                                    context, body)
                                                .then((value) {
                                              customPrint('story :: update');
            
                                              StoriesController.titleController
                                                  .clear();
                                              StoriesController
                                                  .descriptionController
                                                  .clear();
                                              StoriesController.uploadUrlImage(
                                                  '');
                                              StoriesController.uploadUrlImageUrl(
                                                  '');
                                              StoriesController.storiesPage(0);
                                              StoriesController.getAllStory('')
                                                  .then((value) {
                                                isLoading(false);
                                              });
                                            });
                                          },
                                          text: 'Save Changes',
                                        )
                                      : CustomButton(
                                          width: screenWidth / 8,
                                          color: AppColors.white,
                                          colorText: AppColors.white,
                                          onPressed: () {
                                            ChaptersController.chapterPage(1);
                                            routePage(context, adminRoute[3]);
                                            activityCount = 3;
                                          },
                                          text: 'Add Chapter',
                                          iconSvgPath: 'icons/add.svg',
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        3.ph,
                        if (StoriesController.isEdit.isFalse)
                          Center(
                            child: SvgPicture.asset('icons/note.svg'),
                          ),
                        if (StoriesController.isEdit.isFalse)
                          Center(
                            child: Text(
                              'No Chapters Added',
                              style: AppTextStyle.normalBold14
                                  .copyWith(color: carlo500),
                            ),
                          ),
                        // if (StoriesController.isEdit.isFalse) 2.ph,
                        // if (StoriesController.isEdit.isFalse)
                        //   CustomButton2(
                        //     width: screenWidth / 8,
                        //     color: indigo700,
                        //     colorText: indigo700,
                        //     onPressed: () {
                        //       ChaptersController.chapterPage(1);
                        //       routePage(context, adminRoute[3]);
                        //       activityCount = 3;
                        //     },
                        //     text: 'Add Chapter',
                        //     iconSvgPath: 'icons/add.svg',
                        //   ),
                        if (StoriesController.isEdit.isTrue) 2.ph,
                        if (StoriesController.isEdit.isTrue)
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
                                          defaultValue:
                                              StoriesController.dateEdit,
                                          onChange: (value) async {
                                            setState(() {
                                              StoriesController.dateEdit = value!;
                                            });
                                            // await SubjectApi.showAllSubjectsByStandard(
                                            //     context, selectedGrade);
                                          },
                                          array: StoriesController.dateEditList,
                                        ),
                                      ),
                                      Expanded(
                                        child: MyDropDown(
                                          // enable: editEnabled ? true : false,
                                          color: carlo50,
                                          borderWidth: 1,
                                          defaultValue: StoriesController.chapter,
                                          onChange: (value) async {
                                            setState(() {
                                              StoriesController.chapter = value!;
                                            });
                                            // await SubjectApi.showAllSubjectsByStandard(
                                            //     context, selectedGrade);
                                          },
                                          array: StoriesController.chapterList,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Title',
                                          style: AppTextStyle.normalRegular12
                                              .copyWith(color: hoverColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        child: MyDropDown(
                                          // enable: editEnabled ? true : false,
                                          color: carlo50,
                                          borderWidth: 1,
                                          defaultValue:
                                              StoriesController.activity,
                                          onChange: (value) async {
                                            setState(() {
                                              StoriesController.activity = value!;
                                            });
                                            // await SubjectApi.showAllSubjectsByStandard(
                                            //     context, selectedGrade);
                                          },
                                          array: StoriesController.activityList,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: 2,
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
                                                    '23-12-2024',
                                                    textAlign: TextAlign.center,
                                                    style: AppTextStyle
                                                        .normalRegular12
                                                        .copyWith(color: grey2),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${index + 1}',
                                                    textAlign: TextAlign.center,
                                                    style: AppTextStyle
                                                        .normalRegular12
                                                        .copyWith(color: grey2),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'I woke up ',
                                                    textAlign: TextAlign.center,
                                                    style: AppTextStyle
                                                        .normalRegular12
                                                        .copyWith(color: grey2),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'Yes',
                                                    textAlign: TextAlign.center,
                                                    style: AppTextStyle
                                                        .normalRegular12
                                                        .copyWith(
                                                            color: indigo800),
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
                              ),
                            ],
                          ),
                        if (StoriesController.isEdit.isTrue) 5.ph,
                        if (StoriesController.isEdit.isTrue)
                          Center(
                            child: CustomButton(
                              width: screenWidth / 6,
                              onPressed: () {
                                isLoading(true);
                                final List<TextEditingController> controllerList =
                                    [
                                  StoriesController.titleController,
                                  StoriesController.descriptionController
                                ];
                                final List<String> fieldsName = [
                                  'Title',
                                  'Description',
                                ];
                                bool valid = validateMyFields(
                                    context, controllerList, fieldsName);
                                if (!valid) {
                                  isLoading(false);
                                  return;
                                }
                                final body = {
                                  "name": StoriesController.titleController.text,
                                  "discription": StoriesController
                                      .descriptionController.text,
                                  "stories_image":
                                      StoriesController.uploadUrlImage.value
                                };
                                StoriesController.updateStories(
                                        context,
                                        StoriesController
                                            .storyIdForUpdateStory.value,
                                        body)
                                    .then((value) {
                                  customPrint('story :: update');
                                  StoriesController.titleController.clear();
                                  StoriesController.descriptionController.clear();
                                  StoriesController.uploadUrlImage('');
                                  StoriesController.uploadUrlImageUrl('');
                                  StoriesController.storiesPage(0);
                                  StoriesController.getAllStory('').then((value) {
                                    isLoading(false);
                                  });
                                });
                              },
                              text: 'Save Changes',
                            ),
                          )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
