import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yokai_admin/Widgets/progressHud.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/const.dart';

import '../../../Widgets/new_button.dart';
import '../../../Widgets/new_button2.dart';
import '../../../Widgets/searchbar.dart';
import '../../../utils/text_styles.dart';
import '../controller/character_controller.dart';
import 'add_new_character_page.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key, required this.scaffold}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffold;

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading(true);
    fetchCharacters();
  }

  fetchCharacters() {
    CharacterController.getCharacters('').then((value) {
      CharacterController.storiesPage(0);
      isLoading(false);
    });
  }

  RxBool isLoading = false.obs;

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
              if (CharacterController.storiesPage.value == 0)
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
                                'Characters',
                                style: AppTextStyle.normalBold28.copyWith(color: carlo500),
                              ),
                            ),
                            5.pw,
                            Expanded(
                              flex: 4,
                              child: CustomSearchBar(
                                hintText: 'Search Characters by Name',
                                controller: CharacterController.searchCharactersController,
                                onTextChanged: (p0) {
                                  CharacterController.getCharacters(p0).then((value) {});
                                },
                              ),
                            ),
                            5.pw,
                            Expanded(
                              flex: 3,
                              child: CustomButton(
                                width: double.infinity,
                                onPressed: () {
                                  CharacterController.isEditCharacter(false);
                                  CharacterController.characterId('');
                                  CharacterController.storiesPage(1);
                                },
                                text: 'Add Character',
                                iconSvgPath: 'icons/add.svg',
                              ),
                            ),
                          ],
                        ),
                        4.ph,
                        Table(
                          children: [
                            TableRow(
                              decoration: const BoxDecoration(color: carlo50),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10, left: 10, top: 15, bottom: 15),
                                  child: Row(
                                    children: [
                                      // Expanded(
                                      //   child: MyDropDown(
                                      //     // enable: editEnabled ? true : false,
                                      //     color: carlo50,
                                      //     borderWidth: 1,
                                      //     defaultValue: StoriesController.date,
                                      //     onChange: (value) async {
                                      //       setState(() {
                                      //         StoriesController.date = value!;
                                      //       });
                                      //       // await SubjectApi.showAllSubjectsByStandard(
                                      //       //     context, selectedGrade);
                                      //     },
                                      //     array: StoriesController.dateList,
                                      //   ),
                                      // ),
                                      Expanded(
                                        child: Text(
                                          'Date',
                                          style: AppTextStyle.normalRegular16.copyWith(color: hoverColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Character Name',
                                          style: AppTextStyle.normalRegular16.copyWith(color: hoverColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        // flex: 2,
                                        child: Text(
                                          'Story',
                                          style: AppTextStyle.normalRegular16.copyWith(color: hoverColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Actions',
                                          style: AppTextStyle.normalRegular16.copyWith(color: hoverColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            ((CharacterController.getAllCharacters.value.data?.length ?? 0) > 0)
                                ? TableRow(
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: CharacterController.getAllCharacters.value.data?.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        // "NA",
                                                        DateFormat('dd-MM-yyyy').format(DateTime.tryParse(CharacterController.getAllCharacters.value.data?[index].createdAt.toString() ?? '') ?? DateTime.now()),
                                                        textAlign: TextAlign.center,
                                                        style: AppTextStyle.normalRegular14.copyWith(color: grey2),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        CharacterController.getAllCharacters.value.data?[index].name.toString() ?? '',
                                                        textAlign: TextAlign.center,
                                                        style: AppTextStyle.normalRegular14.copyWith(color: grey2),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      // flex: 2,
                                                      child: Text(
                                                        CharacterController.getAllCharacters.value.data?[index].storyName.toString() ?? '',
                                                        textAlign: TextAlign.center,
                                                        style: AppTextStyle.normalRegular14.copyWith(color: grey2),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              CharacterController.isEditCharacter(true);
                                                              CharacterController.storiesPage(1);
                                                              CharacterController.characterId(CharacterController.getAllCharacters.value.data?[index].id.toString() ?? '');
                                                              print('edit');
                                                            },
                                                            child: SvgPicture.asset(
                                                              'icons/edit.svg',
                                                              height: 33,
                                                              width: 33,
                                                            ),
                                                          ),
                                                          1.pw,
                                                          InkWell(
                                                            onTap: () {
                                                              showDialog(
                                                                  context: context,
                                                                  builder: (context) {
                                                                    return Dialog(
                                                                      elevation: 1,
                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                      child: Container(
                                                                        width: MediaQuery.of(context).size.width / 2.7,
                                                                        height: MediaQuery.of(context).size.height / 3,
                                                                        padding: const EdgeInsets.all(15),
                                                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15.0), boxShadow: [
                                                                          BoxShadow(offset: const Offset(12, 26), blurRadius: 50, spreadRadius: 0, color: Colors.grey.withOpacity(.1)),
                                                                        ]),
                                                                        child: SingleChildScrollView(
                                                                          child: Column(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                                                                  'Delete Character',
                                                                                  style: AppTextStyle.normalBold18.copyWith(color: textDark),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 15,
                                                                              ),
                                                                              Text(
                                                                                "Are you sure you want to delete this Character ?",
                                                                                style: AppTextStyle.normalRegular14.copyWith(color: textDark),
                                                                              ),
                                                                              3.ph,
                                                                              Text(
                                                                                "It will be deleted for all teachers users andany data related to it will not be recovered.",
                                                                                style: AppTextStyle.normalRegular14.copyWith(color: textDark),
                                                                              ),
                                                                              3.ph,
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    // Expanded(
                                                                                    //   child: CustomButton2(
                                                                                    //     width: screenWidth / 10,
                                                                                    //     textSize: 14,
                                                                                    //     color: indigo700,
                                                                                    //     colorText: indigo700,
                                                                                    //     onPressed: () {},
                                                                                    //     text: 'Delete & Block',
                                                                                    //   ),
                                                                                    // ),
                                                                                    // 2.pw,
                                                                                    Expanded(
                                                                                      child: CustomButton(
                                                                                        width: screenWidth / 10,
                                                                                        textSize: 14,
                                                                                        onPressed: () {
                                                                                          isLoading(true);
                                                                                          CharacterController.deleteCharacters(context, CharacterController.getAllCharacters.value.data?[index].id.toString() ?? '').then(
                                                                                            (value) {
                                                                                              CharacterController.getCharacters('').then((value) {
                                                                                                Navigator.pop(context);
                                                                                                isLoading(false);
                                                                                              });
                                                                                            },
                                                                                          );
                                                                                        },
                                                                                        text: 'Delete Character',
                                                                                      ),
                                                                                    ),
                                                                                    2.pw,
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
                                                              'icons/delete.svg',
                                                              height: 33,
                                                              width: 33,
                                                            ),
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
                                            style: AppTextStyle.normalRegular14.copyWith(color: indigo800),
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
              if (CharacterController.storiesPage.value == 1) const Expanded(child: NewCharacter()),
            ],
          ),
        ),
      );
    });
  }
}
