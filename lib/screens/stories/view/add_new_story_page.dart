// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:yokai_admin/Widgets/progressHud.dart';
// import 'package:yokai_admin/utils/colors.dart';
// import 'package:yokai_admin/utils/const.dart';
//
// import '../../../Widgets/my_dropdown.dart';
// import '../../../Widgets/my_dropdown2.dart';
// import '../../../Widgets/my_textfield.dart';
// import '../../../Widgets/new_button.dart';
// import '../../../Widgets/new_button2.dart';
// import '../../../api/database.dart';
// import '../../../globalVariable.dart';
// import '../../../utils/text_styles.dart';
// import '../../chapters/controller/chapters_controller.dart';
// import '../controller/stories_controller.dart';
//
// class AddNewStoryPage extends StatefulWidget {
//   String storyId;
//
//   AddNewStoryPage({super.key, required this.storyId});
//
//   @override
//   State<AddNewStoryPage> createState() => _AddNewStoryPageState();
// }
//
// class _AddNewStoryPageState extends State<AddNewStoryPage> {
//  RxBool isLoadingAddNew = false.obs;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     if (widget.storyId.isNotEmpty) {
//      isLoadingAddNew(true);
//       StoriesController.getStoriesDataById(widget.storyId).then((value) {
//         StoriesController.descriptionController.text= StoriesController.getStoriesById.value.data?.discription.toString()??'';
//         StoriesController.uploadUrlImageUrl(StoriesController.getStoriesById.value.data?.storiesImage.toString()??'');
//       isLoadingAddNew(false);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     return Obx(() {
//       return ProgressHUD(
//         isLoading:isLoadingAddNew.value,
//         child: Scaffold(
//           backgroundColor: AppColors.white,
//           body: SingleChildScrollView(
//             child: Padding(
//               padding:  EdgeInsets.symmetric(horizontal: screenWidth/10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     (StoriesController.isEdit.isFalse)
//                         ? 'New Story'
//                         : 'Story Details',
//                     style: AppTextStyle.normalBold28.copyWith(color: carlo500),
//                   ),
//                   2.ph,
//                   (StoriesController.isEdit.isFalse)
//                       ? CustomInfoField(
//                           maxCharacters: 50,
//                           maxLength: 50,
//                           counter: false,
//                           controller: StoriesController.titleController,
//                           hint: "The mystery deepens in wonderland",
//                           label: 'Title',
//                           onChanged: (value) {
//                             StoriesController.characterCountTitle(value.length);
//                           },
//                         )
//                       : Text(
//                           'Title : ${StoriesController.getStoriesById.value.data?.name.toString()??''}',
//                           style: AppTextStyle.normalRegular20
//                               .copyWith(color: ironColor),
//                         ),
//                   if (StoriesController.isEdit.isFalse)
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text(
//                           '${StoriesController.characterCountTitle.value} /50',
//                           //textStyle.labelStyle,
//                           style: textStyle.labelStyle.copyWith(
//                               color: StoriesController.characterCountTitle.value <= 50
//                                   ? textBlack
//                                   : Colors.red,
//                               fontSize: 12),
//                         ),
//                       ],
//                     ),
//                   3.ph,
//                   SizedBox(
//                     height: 180,
//                     child: Row(
//                       children: [
//                         Expanded(
//                           flex: 4,
//                           child: Column(
//                             children: [
//                               CustomInfoField(
//                                 // height: screenHeight * 0.2,
//                                 maxCharacters: 400,
//                                 maxLength: 400,
//                                 maxLines: 5,
//                                 counter: true,
//                                 controller: StoriesController.descriptionController,
//                                 hint: "Counting the stars until sunrise",
//                                 label: 'Short Description',
//                                 onChanged: (value) {
//                                   StoriesController.characterCountDescription(value.length);
//                                 },
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(
//                                     '${StoriesController.characterCountDescription.value} /400',
//                                     //textStyle.labelStyle,
//                                     style: textStyle.labelStyle.copyWith(
//                                         color: StoriesController.characterCountDescription.value <= 400
//                                             ? textBlack
//                                             : Colors.red,
//                                         fontSize: 12),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         2.pw,
//                         (StoriesController.uploadUrlImageUrl.isEmpty &&
//                                 StoriesController.uploadUrlImageUrl.value != null)
//                             ? Expanded(
//                                 flex: 1,
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     StoriesController.pickImage().then((value) {
//                                       StoriesController.uploadUrlImageUrl('');
//                                       StoriesController.uploadImage()
//                                           .then((value) {
//                                         customPrint(
//                                             'imageUrl :: ${DatabaseApi.mainUrlForImage}${StoriesController.uploadUrlImage}');
//                                         StoriesController.uploadUrlImageUrl(
//                                             '${DatabaseApi.mainUrlForImage}${StoriesController.uploadUrlImage}');
//                                       });
//                                     });
//                                   },
//                                   child: Container(
//                                     // height: screenHeight * 0.1,
//                                     margin:
//                                         const EdgeInsets.symmetric(vertical: 28),
//                                     decoration: BoxDecoration(
//                                       color: containerBack,
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         SvgPicture.asset(
//                                           'icons/add.svg',
//                                           color: indigo700,
//                                         ),
//                                         Text(
//                                           'Click to upload\ncover image',
//                                           style: AppTextStyle.normalRegular15
//                                               .copyWith(color: labelColor),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             : Expanded(
//                                 child: Container(
//                                   height: 170,
//                                   margin:
//                                       const EdgeInsets.symmetric(vertical: 28),
//                                   padding: EdgeInsets.all(2),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(8),
//                                     color: containerBack,
//                                     border: Border.all(color: containerBorder),
//                                   ),
//                                   child: Stack(
//                                     alignment: Alignment.topRight,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Image.network(
//                                           '${DatabaseApi.mainUrlForImage}${StoriesController.uploadUrlImage}',
//                                           height: double.infinity,
//                                           width: double.infinity,
//                                         ),
//                                       ),
//                                       GestureDetector(
//                                           onTap: () {
//                                             StoriesController.uploadUrlImageUrl(
//                                                 '');
//                                           },
//                                           child: SvgPicture.asset(
//                                               'icons/deleteNew.svg')),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                       ],
//                     ),
//                   ),
//                   3.ph,
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Character (will be unlocked on Ch. 5) ',
//                               style: AppTextStyle.normalRegular15
//                                   .copyWith(color: labelColor),
//                             ),
//                             MyDropDownNew(
//                               // enable: editEnabled ? true : false,
//                               color: AppColors.white,
//
//                               borderWidth: 1,
//                               defaultValue: StoriesController.character,
//                               onChange: (value) async {
//                                 setState(() {
//                                   StoriesController.character = value!;
//                                 });
//                                 // await SubjectApi.showAllSubjectsByStandard(
//                                 //     context, selectedGrade);
//                               },
//                               array: StoriesController.characterList,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Expanded(child: SizedBox()),
//                       Expanded(
//                         child: Column(
//                           children: [
//                             Text(
//                               '',
//                               style: AppTextStyle.normalRegular15
//                                   .copyWith(color: labelColor),
//                             ),
//                             (StoriesController.isEdit.isFalse)
//                                 ? CustomButton(
//                                     width: double.infinity,
//                                     onPressed: () {
//                                       isLoadingAddNew(true);
//                                       final List<TextEditingController>
//                                           controllerList = [
//                                         StoriesController.titleController,
//                                         StoriesController.descriptionController
//                                       ];
//                                       final List<String> fieldsName = [
//                                         'Title',
//                                         'Description',
//                                       ];
//                                       bool valid = validateMyFields(
//                                           context, controllerList, fieldsName);
//                                       if (!valid) {
//                                         isLoadingAddNew(false);
//                                         return;
//                                       }
//                                       final body = {
//                                         "name":
//                                             StoriesController.titleController.text,
//                                         "discription": StoriesController
//                                             .descriptionController.text,
//                                         "stories_image":
//                                             StoriesController.uploadUrlImage.value
//                                       };
//                                       StoriesController.createStories(context, body)
//                                           .then((value) {
//                                         StoriesController.titleController.clear();
//                                         StoriesController.descriptionController
//                                             .clear();
//                                         StoriesController.uploadUrlImage('');
//                                         StoriesController.storiesPage(0);
//                                         isLoadingAddNew(false);
//                                       });
//                                     },
//                                     text: 'Save Changes',
//                                   )
//                                 : CustomButton(
//                                     width: screenWidth / 8,
//                                     color: AppColors.white,
//                                     colorText: AppColors.white,
//                                     onPressed: () {
//                                       ChaptersController.chapterPage(1);
//                                       routePage(
//                                           context, adminRoute[3]);
//                                       activityCount = 3;
//                                     },
//                                     text: 'Add Chapter',
//                                     iconSvgPath: 'icons/add.svg',
//                                   ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   3.ph,
//                   if (StoriesController.isEdit.isFalse)
//                     Center(
//                       child: SvgPicture.asset('icons/note.svg'),
//                     ),
//                   if (StoriesController.isEdit.isFalse)
//                     Center(
//                       child: Text(
//                         'No Chapters Added',
//                         style: AppTextStyle.normalBold14.copyWith(color: carlo500),
//                       ),
//                     ),
//                   if (StoriesController.isEdit.isFalse) 2.ph,
//                   if (StoriesController.isEdit.isFalse)
//                     CustomButton2(
//                       width: screenWidth / 8,
//                       color: indigo700,
//                       colorText: indigo700,
//                       onPressed: () {
//                         ChaptersController.chapterPage(1);
//                         routePage(
//                             context, adminRoute[3]);
//                         activityCount = 3;
//                       },
//                       text: 'Add Chapter',
//                       iconSvgPath: 'icons/add.svg',
//                     ),
//                   if (StoriesController.isEdit.isTrue) 2.ph,
//                   if (StoriesController.isEdit.isTrue)
//                     Table(
//                       children: [
//                         TableRow(
//                           decoration: const BoxDecoration(color: carlo50),
//                           children: [
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: MyDropDown(
//                                     // enable: editEnabled ? true : false,
//                                     color: carlo50,
//                                     borderWidth: 1,
//                                     defaultValue: StoriesController.dateEdit,
//                                     onChange: (value) async {
//                                       setState(() {
//                                         StoriesController.dateEdit = value!;
//                                       });
//                                       // await SubjectApi.showAllSubjectsByStandard(
//                                       //     context, selectedGrade);
//                                     },
//                                     array: StoriesController.dateEditList,
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: MyDropDown(
//                                     // enable: editEnabled ? true : false,
//                                     color: carlo50,
//                                     borderWidth: 1,
//                                     defaultValue: StoriesController.chapter,
//                                     onChange: (value) async {
//                                       setState(() {
//                                         StoriesController.chapter = value!;
//                                       });
//                                       // await SubjectApi.showAllSubjectsByStandard(
//                                       //     context, selectedGrade);
//                                     },
//                                     array: StoriesController.chapterList,
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Text(
//                                     'Title',
//                                     style: AppTextStyle.normalRegular12
//                                         .copyWith(color: hoverColor),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: MyDropDown(
//                                     // enable: editEnabled ? true : false,
//                                     color: carlo50,
//                                     borderWidth: 1,
//                                     defaultValue: StoriesController.activity,
//                                     onChange: (value) async {
//                                       setState(() {
//                                         StoriesController.activity = value!;
//                                       });
//                                       // await SubjectApi.showAllSubjectsByStandard(
//                                       //     context, selectedGrade);
//                                     },
//                                     array: StoriesController.activityList,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         TableRow(
//                           children: [
//                             ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: 2,
//                               itemBuilder: (context, index) {
//                                 return Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(10),
//                                       child: Row(
//                                         children: [
//                                           Expanded(
//                                             child: Text(
//                                               '23-12-2024',
//                                               textAlign: TextAlign.center,
//                                               style: AppTextStyle.normalRegular12
//                                                   .copyWith(color: grey2),
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: Text(
//                                               '${index + 1}',
//                                               textAlign: TextAlign.center,
//                                               style: AppTextStyle.normalRegular12
//                                                   .copyWith(color: grey2),
//                                             ),
//                                           ),
//                                           Expanded(
//                                             flex: 2,
//                                             child: Text(
//                                               'I woke up ',
//                                               textAlign: TextAlign.center,
//                                               style: AppTextStyle.normalRegular12
//                                                   .copyWith(color: grey2),
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: Text(
//                                               'Yes',
//                                               textAlign: TextAlign.center,
//                                               style: AppTextStyle.normalRegular12
//                                                   .copyWith(color: indigo800),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     const Divider(
//                                       color: bottomBorder,
//                                     )
//                                   ],
//                                 );
//                               },
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   if (StoriesController.isEdit.isTrue) 5.ph,
//                   if (StoriesController.isEdit.isTrue)
//                     Center(
//                       child: CustomButton(
//                         width: screenWidth / 6,
//                         onPressed: () {
//                           final List<TextEditingController> controllerList = [
//                             StoriesController.titleController,
//                             StoriesController.descriptionController
//                           ];
//                           final List<String> fieldsName = [
//                             'Title',
//                             'Description',
//                           ];
//                           bool valid =
//                               validateMyFields(context, controllerList, fieldsName);
//                           if (!valid) {
//                             return;
//                           }
//                           final body = {
//                             "name": StoriesController.titleController.text,
//                             "discription":
//                                 StoriesController.descriptionController.text,
//                             "stories_image":
//                                 StoriesController.uploadUrlImage.value
//                           };
//                           StoriesController.updateStories(context, '', body)
//                               .then((value) {
//                             StoriesController.storiesPage(0);
//                           });
//                         },
//                         text: 'Save Changes',
//                       ),
//                     )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
