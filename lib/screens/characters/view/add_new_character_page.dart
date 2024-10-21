import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yokai_admin/Widgets/progressHud.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/const.dart';

import '../../../Widgets/my_dropdown2.dart';
import '../../../Widgets/my_textfield.dart';
import '../../../Widgets/new_button.dart';
import '../../../api/database.dart';
import '../../../globalVariable.dart';
import '../../../utils/text_styles.dart';
import '../../stories/controller/stories_controller.dart';
import '../controller/character_controller.dart';

class NewCharacter extends StatefulWidget {
  const NewCharacter({super.key});

  @override
  State<NewCharacter> createState() => _NewCharacterState();
}

class _NewCharacterState extends State<NewCharacter> {
  RxBool isLoading = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clearData().then(
      (value) {
        fetchData();
      },
    );
  }

  Future clearData() async {
    CharacterController.titleController.clear();
    CharacterController.promptsController.clear();
    // CharacterController.linkController.clear();
    CharacterController.introductionController.clear();
    CharacterController.requirementsController.clear();
    CharacterController.tagsController.clear();
    //
    CharacterController.uploadUrlImage('');
    //
    CharacterController.chDetailsString('');
    //
    CharacterController.tagsEmptyError('');
    //
    CharacterController.storyCharacters('Select');
    CharacterController.chDetails.clear();
    CharacterController.storyIdStringCharacters('');
  }

  Future fetchData() async {
    isLoading(true);
    await StoriesController.getAllStory('').then((value) async {
      if ((StoriesController.getAllStoriesBy.value.data?.length ?? 0) > 0) {
        for (int i = 0;
            i < (StoriesController.getAllStoriesBy.value.data?.length ?? 0);
            i++) {
          CharacterController.storyListCharacters
              .add(StoriesController.getAllStoriesBy.value.data?[i].name ?? '');
          CharacterController.storyIdCharacters.add(
              StoriesController.getAllStoriesBy.value.data?[i].id.toString() ??
                  '');
        }
      }
      if (CharacterController.isEditCharacter.isTrue) {
        if (CharacterController.characterId.isNotEmpty) {
          CharacterController.getCharactersById(
                  CharacterController.characterId.value)
              .then(
            (value) {
              CharacterController.titleController.text = CharacterController
                      .getAllCharactersById.value.data?.name
                      .toString() ??
                  '';
              CharacterController.promptsController.text = CharacterController
                      .getAllCharactersById.value.data?.prompt
                      .toString() ??
                  '';
              // CharacterController.linkController.text = CharacterController
              //         .getAllCharactersById.value.data?.link
              //         .toString() ??
              //     '';
              CharacterController.introductionController.text =
                  CharacterController
                          .getAllCharactersById.value.data?.introducation
                          .toString() ??
                      '';
              CharacterController.requirementsController.text =
                  CharacterController
                          .getAllCharactersById.value.data?.requirements
                          .toString() ??
                      '';
              CharacterController.chDetailsString(CharacterController
                      .getAllCharactersById.value.data?.tags
                      .toString() ??
                  '');
              CharacterController.storyIdStringCharacters(CharacterController
                      .getAllCharactersById.value.data?.storiesId
                      .toString() ??
                  '');
              CharacterController.storyCharacters(CharacterController
                      .getAllCharactersById.value.data?.storyName
                      .toString() ??
                  '');
              CharacterController.uploadUrlImage(CharacterController
                      .getAllCharactersById.value.data?.characterImage
                      .toString() ??
                  '');
              customPrint(
                  'imageUrl :: ${DatabaseApi.mainUrlForImage}${CharacterController.uploadUrlImage}');
              CharacterController.chDetails.addAll(CharacterController
                  .chDetailsString.value
                  .replaceAll("[", '')
                  .replaceAll(']', '')
                  .split(',')
                  .map((e) => e.trim()));
              isLoading(false);
            },
          );
        }
      } else {
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth / 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          clearData();
                          CharacterController.storiesPage(0);
                        },
                        child: SvgPicture.asset(
                          'icons/back.svg',
                          height: 35,
                          width: 35,
                        ),
                      ),
                      1.pw,
                      Text(
                        (CharacterController.isEditCharacter.isFalse)
                            ? 'New Character'
                            : 'Update Character',
                        style:
                            AppTextStyle.normalBold28.copyWith(color: carlo500),
                      ),
                    ],
                  ),
                  2.ph,
                  SizedBox(
                    width: screenWidth / 3,
                    child: Column(
                      children: [
                        CustomInfoField(
                          maxCharacters: 50,
                          maxLength: 50,
                          counter: true,
                          controller: CharacterController.titleController,
                          hint: "Jerome",
                          label: 'Name',
                          onChanged: (value) {
                            CharacterController.characterCountTitle(
                                value.length);
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${CharacterController.characterCountTitle.value} /50',
                              //textStyle.labelStyle,
                              style: textStyle.labelStyle.copyWith(
                                  color: CharacterController
                                              .characterCountTitle.value <=
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
                  3.ph,
                  Text(
                    'Story (will be unlocked on Ch. 5) ',
                    style: AppTextStyle.normalRegular15
                        .copyWith(color: labelColor),
                  ),
                  if (CharacterController.isEditCharacter.isTrue &&
                      CharacterController.storyCharacters.value != "Select")
                    const SizedBox(height: 4),
                  if (CharacterController.isEditCharacter.isTrue &&
                      CharacterController.storyCharacters.value != "Select")
                    MyDropDownNew(
                      // enable: editEnabled ? true : false,
                      color: AppColors.white,
                      borderWidth: 1,
                      defaultValue: CharacterController.storyCharacters.value,
                      onChange: (value) async {
                        // setState(() async {
                        CharacterController.storyCharacters(value);
                        int idIndex = CharacterController.storyListCharacters
                            .indexOf(value);
                        CharacterController.storyIdStringCharacters(
                            CharacterController.storyIdCharacters[idIndex - 1]);
                        print(
                            'Story Id Number :: ${CharacterController.storyIdStringCharacters.value}');
                        // });
                      },
                      array: CharacterController.storyListCharacters,
                    ),
                  if (CharacterController.isEditCharacter.isFalse)
                    const SizedBox(height: 4),
                  if (CharacterController.isEditCharacter.isFalse)
                    MyDropDownNew(
                      // enable: editEnabled ? true : false,
                      color: AppColors.white,
                      borderWidth: 1,
                      defaultValue: CharacterController.storyCharacters.value,
                      onChange: (value) async {
                        // setState(() async {
                        CharacterController.storyCharacters(value);
                        int idIndex = CharacterController.storyListCharacters
                            .indexOf(value);
                        CharacterController.storyIdStringCharacters(
                            CharacterController.storyIdCharacters[idIndex - 1]);
                        print(
                            'Story Id Number :: ${CharacterController.storyIdStringCharacters.value}');
                        // });
                      },
                      array: CharacterController.storyListCharacters,
                    ),
                  // 3.ph,
                  // CustomInfoField(
                  //   maxCharacters: 50,
                  //   maxLength: 50,
                  //   counter: true,
                  //   controller: CharacterController.linkController,
                  //   hint: "https’/fekjfnfndsnkjnfsdn/gsdfjkgnkjsdfgnsfdn",
                  //   label: 'Link',
                  //   onChanged: (value) {
                  //     CharacterController.characterCountLink(value.length);
                  //   },
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Text(
                  //       '${CharacterController.characterCountLink.value} /50',
                  //       //textStyle.labelStyle,
                  //       style: textStyle.labelStyle.copyWith(
                  //           color:
                  //               CharacterController.characterCountLink.value <=
                  //                       50
                  //                   ? textBlack
                  //                   : Colors.red,
                  //           fontSize: 12),
                  //     ),
                  //   ],
                  // ),
                  4.ph,
                  CustomInfoField(
                    // maxCharacters: 400,
                    // maxLength: 400,
                    counter: true,
                    maxLines: 5,
                    controller: CharacterController.promptsController,
                    hint: "",
                    label: 'Prompts',
                    onChanged: (value) {
                      CharacterController.promptsCountRequirement(value.length);
                    },
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Text(
                  //       '${CharacterController.promptsCountRequirement.value} /400',
                  //       //textStyle.labelStyle,
                  //       style: textStyle.labelStyle.copyWith(color: CharacterController.promptsCountRequirement.value <= 400 ? textBlack : Colors.red, fontSize: 12),
                  //     ),
                  //   ],
                  // ),
                  5.ph,
                  SizedBox(
                    height: 200,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              CustomInfoField(
                                // maxCharacters: 400,
                                // maxLength: 400,
                                counter: true,
                                maxLines: 5,
                                controller:
                                    CharacterController.introductionController,
                                hint: "",
                                label: 'Introduction',
                                onChanged: (value) {
                                  CharacterController
                                      .characterCountIntroduction(value.length);
                                },
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     Text(
                              //       '${CharacterController.characterCountIntroduction.value} /400',
                              //       //textStyle.labelStyle,
                              //       style: textStyle.labelStyle.copyWith(color: CharacterController.characterCountIntroduction.value <= 400 ? textBlack : Colors.red, fontSize: 12),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        3.pw,
                        (CharacterController.uploadUrlImage.isEmpty)
                            ? Expanded(
                                child: Column(
                                  children: [
                                    Expanded(
                                      // flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          CharacterController.pickImage()
                                              .then((value) {
                                            // CharacterController.uploadUrlImageUrl(
                                            //     '');
                                            CharacterController.uploadUrlImage(
                                                '');
                                            isLoading(true);
                                            CharacterController.uploadImage()
                                                .then((value) {
                                              customPrint(
                                                  'imageUrl :: ${DatabaseApi.mainUrlForImage}${CharacterController.uploadUrlImage}');
                                              // CharacterController.uploadUrlImageUrl(
                                              //     '${DatabaseApi.mainUrlForImage}${CharacterController.uploadUrlImage}');
                                              isLoading(false);
                                            });
                                          });
                                        },
                                        child: Container(
                                          // height: screenHeight * 0.1,
                                          width: double.infinity,
                                          margin: const EdgeInsets.only(
                                            top: 28,
                                          ),
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
                                      'Round Image\n(Recommended size 110×110)',
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
                                          '${DatabaseApi.mainUrlForImage}${CharacterController.uploadUrlImage}',
                                          height: double.infinity,
                                          width: double.infinity,
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            CharacterController
                                                .uploadUrlImageUrl('');
                                            CharacterController.uploadUrlImage(
                                                '');
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
                  4.ph,
                  CustomInfoField(
                    // maxCharacters: 400,
                    // maxLength: 400,
                    counter: true,
                    maxLines: 5,
                    controller: CharacterController.requirementsController,
                    hint: "",
                    label: 'Requirements',
                    onChanged: (value) {
                      CharacterController.characterCountRequirement(
                          value.length);
                    },
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Text(
                  //       '${CharacterController.characterCountRequirement.value} /400',
                  //       //textStyle.labelStyle,
                  //       style: textStyle.labelStyle.copyWith(color: CharacterController.characterCountRequirement.value <= 400 ? textBlack : Colors.red, fontSize: 12),
                  //     ),
                  //   ],
                  // ),
                  3.ph,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenWidth / 4,
                        child: Column(
                          children: [
                            CustomInfoField(
                              // maxCharacters: 20,
                              // maxLength: 20,
                              counter: true,
                              controller: CharacterController.tagsController,
                              hint: "Playful",
                              label: 'Tags',
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  CharacterController.tagsEmptyError('');
                                }
                                CharacterController.characterCountTags(
                                    value.length);
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${CharacterController.tagsEmptyError.value}',
                                  //textStyle.labelStyle,
                                  style: textStyle.labelStyle.copyWith(
                                      color: Colors.red, fontSize: 12),
                                ),
                                // Text(
                                //   '${CharacterController.characterCountTags.value} /20',
                                //   //textStyle.labelStyle,
                                //   style: textStyle.labelStyle.copyWith(color: CharacterController.characterCountTags.value <= 20 ? textBlack : Colors.red, fontSize: 12),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      2.pw,
                      SizedBox(
                        width: screenWidth / 10,
                        child: Column(
                          children: [
                            Text(
                              '',
                              style: textStyle.labelStyle,
                            ),
                            const SizedBox(height: 4),
                            CustomButton(
                              width: double.infinity,
                              onPressed: () {
                                String newTag =
                                    CharacterController.tagsController.text;
                                if (newTag.isNotEmpty) {
                                  if (!CharacterController.chDetails
                                      .contains(newTag)) {
                                    CharacterController.tagsEmptyError('');
                                    CharacterController.chDetails.add(newTag);
                                    CharacterController.tagsController.clear();
                                    CharacterController.characterCountTags(0);
                                    customPrint(
                                        'chDetails :: ${CharacterController.chDetails}');
                                  } else {
                                    CharacterController.tagsEmptyError(
                                        'Tag already exists!');
                                  }
                                } else {
                                  CharacterController.tagsEmptyError(
                                      'Please Add Tag!');
                                }
                              },
                              text: 'Add',
                              iconSvgPath: 'icons/add.svg',
                            ),
                            // const SizedBox(height: 4),
                            Text(
                              '',
                              style: textStyle.labelStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  3.ph,
                  if (CharacterController.chDetails.isNotEmpty)
                    Wrap(
                      spacing: 6, // Adjust as needed
                      runSpacing: 10, // Adjust as needed
                      children: List.generate(
                        CharacterController.chDetails.length,
                        (index) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: coral100,
                            border: Border.all(
                              color: coral500,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                CharacterController.chDetails[index],
                                style: AppTextStyle.normalSemiBold12
                                    .copyWith(color: coral500),
                              ),
                              1.pw,
                              InkWell(
                                onTap: () {
                                  CharacterController.chDetails.removeAt(index);
                                },
                                child: SvgPicture.asset(
                                  'icons/close.svg',
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  5.ph,
                  Center(
                    child: SizedBox(
                      width: screenWidth / 5,
                      child: CustomButton(
                        width: double.infinity,
                        onPressed: () {
                          CharacterController.chDetailsString('');
                          if (CharacterController.chDetails.isNotEmpty) {
                            CharacterController.chDetailsString.value =
                                CharacterController.chDetails.join(',');
                            customPrint(
                                "Tags :: ${CharacterController.chDetailsString.value}");
                          }
                          isLoading(true);
                          final List<TextEditingController> controllerList = [
                            CharacterController.titleController,
                            CharacterController.promptsController,
                            CharacterController.introductionController,
                            CharacterController.requirementsController,
                          ];
                          final List<String> fieldsName = [
                            'Title',
                            'Prompt',
                            'Introduction',
                            'Requirements',
                          ];
                          bool valid = validateMyFields(
                              context, controllerList, fieldsName);
                          if (!valid) {
                            isLoading(false);
                            return;
                          }
                          if (CharacterController.storyCharacters.value ==
                              "Select") {
                            showErrorSnackBar(
                                "Please Select Story", colorError);
                            isLoading(false);
                            return;
                          }

                          if (CharacterController.chDetails.isEmpty) {
                            showErrorSnackBar(
                                "Tags can't be empty", colorError);
                            isLoading(false);
                            return;
                          }
                          final body = {
                            "name": CharacterController.titleController.text,
                            "stories_id": CharacterController
                                .storyIdStringCharacters.value,
                            // "link": CharacterController.linkController.text,
                            "prompt":
                                CharacterController.promptsController.text,
                            "introduction":
                                CharacterController.introductionController.text,
                            "character_image":
                                CharacterController.uploadUrlImage.value,
                            "requirements":
                                CharacterController.requirementsController.text,
                            if (CharacterController.chDetailsString.isNotEmpty)
                              "tags": CharacterController.chDetailsString.value
                          };
                          if (CharacterController.isEditCharacter.isFalse) {
                            customPrint('Character :: Create');
                            CharacterController.createCharacters(context, body)
                                .then((value) {
                              CharacterController.getCharacters('')
                                  .then((value) {
                                CharacterController.storiesPage(0);
                                isLoading(false);
                              });
                            });
                          } else {
                            customPrint('Character :: Update');
                            CharacterController.updateCharacters(context,
                                    CharacterController.characterId.value, body)
                                .then((value) {
                              CharacterController.getCharacters('')
                                  .then((value) {
                                CharacterController.characterId('');
                                CharacterController.storiesPage(0);
                                isLoading(false);
                              });
                            });
                          }
                        },
                        text: 'Save Changes',
                      ),
                    ),
                  ),
                  5.ph,
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
