import 'package:yokai_admin/Widgets/customTable.dart';
import 'package:yokai_admin/Widgets/deleteDialog.dart';
import 'package:yokai_admin/Widgets/filePicker.dart';
import 'package:yokai_admin/Widgets/imageButton.dart';
import 'package:yokai_admin/Widgets/my_dropdown.dart';
import 'package:yokai_admin/Widgets/new_button.dart';
import 'package:yokai_admin/Widgets/progressHud.dart';
import 'package:yokai_admin/Widgets/searchbar.dart';
import 'package:yokai_admin/Widgets/videoplayer.dart';
import 'package:yokai_admin/api/database.dart';
import 'package:yokai_admin/api/global_api.dart';
import 'package:yokai_admin/api/local_storage.dart';
import 'package:yokai_admin/globalVariable.dart';
import 'package:yokai_admin/main.dart';
// import 'package:yokai_admin/screens/dashboard/subject/subject_api.dart';
import 'package:yokai_admin/screens/lesson%20videos/Api/lesson_api.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/const.dart';
import 'package:yokai_admin/utils/text_styles.dart';
import 'package:yokai_admin/Widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:yokai_admin/utils/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonVideosScreen extends StatefulWidget {
  const LessonVideosScreen({Key? key, required this.scaffold})
      : super(key: key);

  @override
  _LessonVideosScreenState createState() => _LessonVideosScreenState();
  final GlobalKey<ScaffoldState> scaffold;
}

class _LessonVideosScreenState extends State<LessonVideosScreen> {
  int _characterCount = 0;
  final int maxCharacterCount = 50;
  bool edit = false;

  String selectedCreatedby = "Select";
  String selectedSubject = "Select";
  String selectedFilterSubject = "Select";
  String selectedGrade = "Select";
  String selectedFilterGrade = "Select";
  @override
  void initState() {
    super.initState();
    // initialLoading();
    // _ytcontroller = YoutubePlayerController(
    //   initialVideoId: 'lUhJL7o6_cA',
    //   flags: const YoutubePlayerFlags(
    //     autoPlay: false,
    //     mute: false,
    //   ),
    // );
    // _ytcontroller.addListener(() {
    //   if (_ytcontroller.value.isFullScreen != _isFullScreen) {
    //     setState(() {
    //       _isFullScreen = _ytcontroller.value.isFullScreen;
    //     });
    //   }
    // });
  }

  bool _isLoading = false;
  bool _isAdding = false;
  Future<void> initialLoading() async {
    setState(() {
      _isLoading = true;
    });
    // await LessonApi.getalllessonvideos(context);
    setState(() {
      _isLoading = false;
    });
  }

  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredLesson = [];
  TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _descriptioncontroller = TextEditingController();

  // Future<void> editLesson() async {
  //   setState(() {
  //     edit = true;
  //     _isLoading = true;
  //   });
  //   // _initializeQuillController();
  //   _titlecontroller = TextEditingController(
  //       text:
  //           '${LessonApi.getAllVideoLessonsById.value.data?.isEmpty ?? true ? 'NA' : LessonApi.getAllVideoLessonsById.value.data?[0].title ?? 'NA'}');
  //   _descriptioncontroller = TextEditingController(
  //       text:
  //           '${LessonApi.getAllVideoLessonsById.value.data?.isEmpty ?? true ? 'NA' : LessonApi.getAllVideoLessonsById.value.data?[0].discription ?? 'NA'}');

  //   selectedGrade =
  //       '${LessonApi.getAllVideoLessonsById.value.data?.isEmpty ?? true ? 'NA' : LessonApi.getAllVideoLessonsById.value.data?[0].standard ?? 'NA'}';
  //   await SubjectApi.showAllSubjectsByStandard(context, selectedGrade);
  //   selectedSubject =
  //       "${GlobalApi.getSubjectNameById(LessonApi.getAllVideoLessonsById.value.data?.isEmpty ?? true ? '' : LessonApi.getAllVideoLessonsById.value.data?[0].subjectId ?? 'NA')}";

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  // void clearControllers() {
  //   setState(() {
  //     edit = false;
  //     selectedGrade = "Select";
  //     selectedSubject = "Select";
  //     _titlecontroller.clear();
  //     _descriptioncontroller.clear();
  //     LessonApi.filesUrls.clear();
  //   });
  // }

  // void _onAddVideoLesson(BuildContext context) async {
  //   String standard = selectedGrade;
  //   String subject = selectedSubject;
  //   String title = _titlecontroller.text.trim();
  //   String desciption = _descriptioncontroller.text.trim();
  //   int? subjectId = subjectWithId[selectedSubject];
  //   String errorMessage = '';

  //   if (standard == "Select") {
  //     errorMessage = "Please select a standard.";
  //   } else if (subject == "Select") {
  //     errorMessage = "Please select a subject.";
  //   } else if (_titlecontroller.text.isEmpty) {
  //     errorMessage = "Please enter a title.";
  //   } else if (_descriptioncontroller.text.isEmpty) {
  //     errorMessage = "Please some description.";
  //   } else if (LessonApi.filesUrls.length < 2) {
  //     errorMessage = "Please upload both video and the thumbnail.";
  //   }

  //   if (errorMessage.isNotEmpty) {
  //     showErrorSnackBar(errorMessage);
  //     return;
  //   }

  //   if (subjectId == null) {
  //     showErrorSnackBar("Subject ID not found!");
  //     return;
  //   }

  //   setState(() {
  //     _isAdding = true;
  //   });

  //   bool success = await LessonApi.createlessonvideo(context, {
  //     "admin": "1",
  //     "standard": standard,
  //     "duration": LessonApi.videoDuration ?? "", // Use the stored duration
  //     "subject_id": subjectId.toString(),
  //     "title": title,
  //     "discription": desciption,
  //     "video_url": LessonApi.filesUrls.isNotEmpty ? LessonApi.filesUrls[0] : "",
  //     "thumbnail": LessonApi.filesUrls.isNotEmpty ? LessonApi.filesUrls[1] : "",
  //   });

  //   if (success) {
  //     showSuccessSnackBar('', "Lesson Video added successfully!");
  //     setState(() {
  //       LessonApi.lessonRoute('0');
  //       selectedGrade = "Select";
  //       selectedSubject = "Select";
  //       _descriptioncontroller.clear();
  //       _titlecontroller.clear();
  //       _isAdding = false;
  //       selectedFilterSubject = "Select";
  //       selectedFilterGrade = "Select";
  //       LessonApi.filesUrls.clear();
  //     });
  //     clearControllers();
  //     // _refreshData();
  //   }
  // }

  // void _refreshData() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   if (selectedGrade != "Select") {
  //     await SubjectApi.showAllSubjectsByStandard(context, selectedGrade);
  //   }
  //   if (selectedFilterGrade != "Select") {
  //     await SubjectApi.showAllSubjectsByStandard(context, selectedFilterGrade);
  //   }
  //   await SubjectApi.showAllSubjects(context);

  //   await LessonApi.getalllessonvideos(context);

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  // Future<void> _editLesson(BuildContext context) async {
  //   print("_editLesson");
  //   String standard = selectedGrade;
  //   String subject = selectedSubject;
  //   int? subjectId = subjectWithId[selectedSubject];
  //   String errorMessage = '';

  //   if (standard == "Select") {
  //     errorMessage = "Please select a standard.";
  //   } else if (subject == "Select") {
  //     errorMessage = "Please select a subject.";
  //   } else if (_titlecontroller.text.isEmpty) {
  //     errorMessage = "Please enter a title.";
  //   } else if (_descriptioncontroller.text.isEmpty) {
  //     errorMessage = "Please provide some description.";
  //   }

  //   if (errorMessage.isNotEmpty) {
  //     showErrorSnackBar(errorMessage);
  //     return;
  //   }

  //   if (subjectId == null) {
  //     showErrorSnackBar("Subject ID not found!");
  //     return;
  //   }

  //   print("_editLesson 2");

  //   final videoUrl =
  //       LessonApi.filesUrls.isNotEmpty && LessonApi.filesUrls[0].isNotEmpty
  //           ? LessonApi.filesUrls[0]
  //           : LessonApi.getAllVideoLessonsById.value.data?[0].videoUrl ?? '';

  //   final thumbnailUrl =
  //       LessonApi.filesUrls.length > 1 && LessonApi.filesUrls[1].isNotEmpty
  //           ? LessonApi.filesUrls[1]
  //           : LessonApi.getAllVideoLessonsById.value.data?[0].thumbnail ?? '';
  //   final duration =
  //       LessonApi.filesUrls.isNotEmpty && LessonApi.filesUrls[0].isNotEmpty
  //           ? LessonApi.videoDuration
  //           : LessonApi.getAllVideoLessonsById.value.data?[0].duration ?? '';
  //   final body = {
  //     "admin": "1",
  //     "standard": standard,
  //     "duration": duration,
  //     "subject_id": subjectId.toString(),
  //     "title": _titlecontroller.text,
  //     "discription": _descriptioncontroller.text,
  //     "video_url": videoUrl,
  //     "thumbnail": thumbnailUrl,
  //   };

  //   print("body :: $body");
  //   setState(() {
  //     _isAdding = true;
  //   });
  //   bool success = await LessonApi.updatelessonvideos(
  //       context, body, prefs!.getInt(LocalStorage.lessonId));

  //   if (success) {
  //     showSuccessSnackBar('', "Lesson video edited successfully!");
  //     initialLoading();
  //     setState(() {
  //       edit = false;
  //       LessonApi.lessonRoute('0');
  //       selectedGrade = "Select";
  //       selectedSubject = "Select";
  //       _descriptioncontroller.clear();
  //       _titlecontroller.clear();
  //       _isAdding = false;
  //       selectedFilterSubject = "Select";
  //       selectedFilterGrade = "Select";
  //     });
  //     clearControllers();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      // body: Padding(
      //   padding: const EdgeInsets.symmetric(
      //     horizontal: 20,
      //     // vertical: 15,
      //   ),
      //   child: Obx(() {
      //     return ProgressHUD(
      //       isLoading: _isLoading,
      //       child: SingleChildScrollView(
      //         child: Container(
      //             child: LessonApi.lessonRoute.value == '0'
      //                 ? lessonVideosHome(context)
      //                 : LessonApi.lessonRoute.value == '1'
      //                     ? addVideo(context)
      //                     : description(context)),
      //       ),
      //     );
      //   }),
      // ),
    );
  }

  int lessonId = 0;

  // Widget lessonVideosHome(BuildContext context) {
  //   if (searchController.text.isNotEmpty) {
  //   } else if (selectedFilterGrade == "Select" &&
  //       selectedFilterSubject == "Select") {
  //     filteredLesson = LessonApi.lessonVideoList;
  //     print('filteredLesson all: $filteredLesson');
  //   } else {
  //     filteredLesson = LessonApi.filteredDetails;
  //     print('filteredLesson : $filteredLesson');
  //   }
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         children: [
  //           Expanded(
  //             flex: 7,
  //             child: Text(
  //               'Lesson Videos',
  //               style: AppTextStyle.normalBold28.copyWith(color: primaryColor),
  //             ),
  //           ),
  //           Expanded(
  //               flex: 2,
  //               child: CustomButton(
  //                   text: '  + Add Video  ',
  //                   textSize: 14,
  //                   onPressed: () {
  //                     setState(() {
  //                       LessonApi.lessonRoute('1');
  //                       // FinalexamApi.finalexamRoute('1');
  //                       selectedFilterSubject = "Select";
  //                       selectedFilterGrade = "Select";
  //                     });
  //                     // createCollection(context);
  //                   })),
  //         ],
  //       ),
  //       const SizedBox(
  //         height: constants.defaultPadding * 2,
  //       ),
  //       Row(
  //         children: [
  //           Expanded(
  //               flex: 1,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     'Standard',
  //                     style: AppTextStyle.normalRegular14
  //                         .copyWith(color: labelColor),
  //                   ),
  //                   0.5.ph,
  //                   MyDropDown(
  //                       borderWidth: 1,
  //                       defaultValue: selectedFilterGrade,
  //                       onChange: (value) async {
  //                         setState(() {
  //                           selectedFilterGrade = value!;
  //                           _isLoading = true;
  //                         });
  //                         _refreshData();
  //                         await LessonApi.getlessonbystandardsubject(
  //                             context,
  //                             subjectWithId[selectedFilterSubject],
  //                             selectedFilterGrade);
  //                         setState(() {
  //                           _isLoading = false;
  //                         });
  //                       },
  //                       array: grade), // CustomInfoField(
  //                   //
  //                 ],
  //               )),
  //           5.pw,
  //           Expanded(
  //               flex: 2,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     'Subject',
  //                     style: AppTextStyle.normalRegular14
  //                         .copyWith(color: labelColor),
  //                   ),
  //                   0.5.ph,
  //                   MyDropDown(
  //                       borderWidth: 1,
  //                       defaultValue: selectedFilterSubject,
  //                       onChange: (value) async {
  //                         setState(() {
  //                           selectedFilterSubject = value!;
  //                           _isLoading = true;
  //                         });
  //                         await SubjectApi.showAllSubjectsByStandard(
  //                             context, selectedFilterGrade);

  //                         await LessonApi.getlessonbystandardsubject(
  //                             context,
  //                             subjectWithId[selectedFilterSubject],
  //                             selectedFilterGrade);
  //                         setState(() {
  //                           _isLoading = false;
  //                         });
  //                       },
  //                       array: subjects), // CustomInfoField(
  //                   //
  //                 ],
  //               )),
  //           5.pw,
  //           5.pw,
  //           Expanded(
  //             flex: 2,
  //             child: CustomSearchBar(
  //               hintText: 'Search Video by Name',
  //               controller: searchController,
  //               onTextChanged: (keyword) async {
  //                 setState(() {
  //                   _isLoading = true;
  //                 });
  //                 await LessonApi.searchLesson(searchController.text)
  //                     .then((result) {
  //                   setState(() {
  //                     filteredLesson = result;
  //                     print("filteredLesson searchbar :: $filteredLesson");
  //                     _isLoading = false;
  //                   });
  //                 });
  //               },
  //             ),
  //           )
  //         ],
  //       ),
  //       const SizedBox(
  //         height: constants.defaultPadding * 3,
  //       ),
  //       filteredLesson.isNotEmpty
  //           ? Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: CustomTable(
  //                 rows: filteredLesson.length,
  //                 columns: 4,
  //                 rowNames: List.generate(filteredLesson.length,
  //                     (index) => filteredLesson[index]['date'] ?? 'NA'),
  //                 columnNames: [
  //                   'Thumbnail',
  //                   'Title',
  //                   'Duration\nH:M:S',
  //                   // 'Downloads',
  //                   'Action',
  //                 ],
  //                 onTap: (int rowIndex) async {
  //                   setState(() {
  //                     selectedFilterSubject = "Select";
  //                     selectedFilterGrade = "Select";
  //                     lessonId = filteredLesson[rowIndex]['videos_id'];
  //                     prefs!.setInt(LocalStorage.lessonId, lessonId);
  //                     print("lessonId :: $lessonId");
  //                   });
  //                   await LessonApi.getvideobyid(context, lessonId)
  //                       .then((value) => _isLoading = true);
  //                   setState(() {
  //                     LessonApi.lessonRoute('2');
  //                     _isLoading = false;
  //                   });
  //                   prefs!.setString(
  //                       LocalStorage.standard,
  //                       LessonApi.getAllVideoLessonsById.value.data?[0]
  //                               .standard ??
  //                           "");
  //                   prefs!.setString(
  //                       LocalStorage.subjectId,
  //                       LessonApi.getAllVideoLessonsById.value.data?[0]
  //                               .subjectId ??
  //                           "");
  //                   print(
  //                       "Standard :: ${prefs?.getString(LocalStorage.standard) ?? ''}");
  //                   print(
  //                       "subjectId :: ${prefs?.getString(LocalStorage.subjectId) ?? ''}");
  //                   print('Cell in row $rowIndex is tapped');
  //                 },
  //                 firstColname: 'Last Updated ',
  //                 initialValues: [
  //                   for (int i = 0; i < filteredLesson.length; i++)
  //                     [
  //                       // if ()
  //                       filteredLesson[i]['thumbnail'] != null
  //                           ? Image.network(
  //                               '${DatabaseApi.mainUrlImage}${filteredLesson[i]['thumbnail']}',
  //                               height: 50,
  //                               width: 80,
  //                               fit: BoxFit.cover,
  //                               errorBuilder: (context, error, stackTrace) {
  //                                 return Container(
  //                                   height: 50,
  //                                   width: 100,
  //                                   color: Colors.grey,
  //                                   child: Icon(Icons.image_not_supported),
  //                                 );
  //                               },
  //                             )
  //                           : '---',
  //                       // LessonApi.lessonVideoList[i]['thumbnail'],
  //                       filteredLesson[i]['title'],
  //                       filteredLesson[i]['duration'],
  //                       Row(
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: [
  //                           ImageButton(
  //                             imagePath: 'icons/delete_icon.png',
  //                             onPressed: () {
  //                               deleteCard(
  //                                   context, filteredLesson[i]['videos_id']);
  //                               print('button pressed');
  //                             },
  //                           ),
  //                         ],
  //                       )
  //                     ],
  //                 ],
  //               ),
  //             )
  //           : Padding(
  //               padding: const EdgeInsets.all(30.0),
  //               child: Center(
  //                 child: Text(
  //                   "No result found",
  //                   style: AppTextStyle.normalBold20
  //                       .copyWith(color: Colors.grey[400]),
  //                 ),
  //               ),
  //             ),
  //     ],
  //   );
  // }

  // Widget addVideo(BuildContext context) {
  //   return SingleChildScrollView(
  //     child: Padding(
  //       padding: const EdgeInsets.only(right: 60),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.only(bottom: 20),
  //             child: Row(
  //               children: [
  //                 SizedBox(
  //                   height: 30,
  //                   child: ImageButton(
  //                     imagePath: 'icons/backbutton.png',
  //                     onPressed: () {
  //                       setState(() {
  //                         clearControllers();
  //                         LessonApi.lessonRoute('0');
  //                         // FinalexamApi.finalexamRoute('0');
  //                         // Top.notesRoute('0');
  //                       });
  //                     },
  //                   ),
  //                 ),
  //                 5.pw,
  //                 Text(
  //                   edit ? 'Edit Lesson Video' : 'Add Lesson Video',
  //                   style:
  //                       AppTextStyle.normalBold28.copyWith(color: primaryColor),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           const SizedBox(
  //             height: constants.defaultPadding * 2,
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Expanded(
  //                   flex: 1,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         'Standard',
  //                         style: AppTextStyle.normalRegular14
  //                             .copyWith(color: labelColor),
  //                       ),
  //                       0.5.ph,
  //                       MyDropDown(
  //                           borderWidth: 1,
  //                           defaultValue: selectedGrade,
  //                           onChange: (value) {
  //                             setState(() {
  //                               selectedGrade = value!;
  //                             });
  //                             _refreshData();
  //                           },
  //                           array: grade), // CustomInfoField(
  //                       //
  //                     ],
  //                   )),
  //               50.pw,
  //               Expanded(
  //                   flex: 1,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         'Subject',
  //                         style: AppTextStyle.normalRegular14
  //                             .copyWith(color: labelColor),
  //                       ),
  //                       0.5.ph,
  //                       MyDropDown(
  //                           borderWidth: 1,
  //                           defaultValue: selectedSubject,
  //                           onChange: (value) {
  //                             setState(() {
  //                               selectedSubject = value!;
  //                             });
  //                           },
  //                           array: subjects), // CustomInfoField(
  //                       //
  //                     ],
  //                   )),
  //             ],
  //           ),
  //           const SizedBox(
  //             height: constants.defaultPadding,
  //           ),
  //           CustomInfoField(
  //             label: 'Title*',
  //             controller: _titlecontroller,
  //             onChanged: (value) {
  //               setState(() {
  //                 _characterCount = value.length;
  //               });
  //             },
  //             maxCharacters: 50,
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: [
  //               Text(
  //                 '$_characterCount / $maxCharacterCount', //textStyle.labelStyle,
  //                 style: textStyle.labelStyle.copyWith(
  //                     color: _characterCount <= maxCharacterCount
  //                         ? textBlack
  //                         : Colors.red,
  //                     fontSize: 12),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(
  //             height: constants.defaultPadding / 2,
  //           ),
  //           CustomInfoField(
  //             maxLines: 5,
  //             hint: '',
  //             label: 'Description',
  //             controller: _descriptioncontroller,
  //             onChanged: (value) {},
  //           ),
  //           const SizedBox(
  //             height: constants.defaultPadding,
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               FileUploadWidget(
  //                 type: "video",
  //                 showFileTypes: false,
  //                 title: 'Video:',
  //                 text: 'Click to upload here. ',
  //                 ques: true,
  //                 snackbar: 'Lesson video uploaded sucessfully!',
  //               ),
  //               10.pw,
  //               FileUploadWidget(
  //                 type: "img",
  //                 showFileTypes: false,
  //                 title: 'Thumbnail:',
  //                 text: 'Landscape with 16:9 Ratio',
  //                 ques: false,
  //                 snackbar: 'Thumbnail image uploaded sucessfully!',
  //               ),
  //             ],
  //           ),
  //           const SizedBox(
  //             height: constants.defaultPadding * 3,
  //           ),
  //           Center(
  //               child: _isAdding
  //                   ? const CircularProgressIndicator(
  //                       color: primaryColor,
  //                     )
  //                   : CustomButton(
  //                       text: edit ? 'Edit Lesson Video' : 'Add Lesson Video',
  //                       onPressed: () {
  //                         isLoading.isTrue
  //                             ? () {}
  //                             : edit
  //                                 ? _editLesson(context)
  //                                 : _onAddVideoLesson(context);
  //                       },
  //                       width: MediaQuery.of(context).size.width / 5,
  //                     )),
  //           const SizedBox(
  //             height: constants.defaultPadding / 2,
  //           ),
  //           Center(
  //             child: Text(
  //               'All parts of the upload are editable',
  //               style: AppTextStyle.normalRegular14,
  //             ),
  //           ),
  //           10.ph
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget description(BuildContext context) {
  //   return SingleChildScrollView(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Expanded(
  //               flex: 7,
  //               child: Row(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   SizedBox(
  //                     height: 30,
  //                     child: ImageButton(
  //                       imagePath: 'icons/backbutton.png',
  //                       onPressed: () {
  //                         clearControllers();
  //                         setState(() {
  //                           LessonApi.lessonRoute('0');
  //                         });
  //                       },
  //                     ),
  //                   ),
  //                   5.pw,
  //                   Text(
  //                     'Video Details',
  //                     style: AppTextStyle.normalBold28
  //                         .copyWith(color: primaryColor),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Expanded(
  //               flex: 2,
  //               child: CustomButton(
  //                 text: '   Edit Video Details  ',
  //                 textSize: 14,
  //                 onPressed: () {
  //                   setState(() {
  //                     editLesson().then((value) => {
  //                           setState(() {
  //                             edit = true;
  //                             LessonApi.lessonRoute('1');
  //                           })
  //                         });
  //                   });

  //                   // editFlashcard(context);
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: constants.defaultPadding * 2),
  //         Text(
  //           'Title : ${LessonApi.getAllVideoLessonsById.value.data?[0].title}',
  //           style: AppTextStyle.normalRegular20
  //               .copyWith(color: ironColor, fontWeight: FontWeight.w500),
  //         ),
  //         const SizedBox(height: constants.defaultPadding),
  //         Row(
  //           children: [
  //             Text(
  //               'Subject : ${GlobalApi.getSubjectNameById(LessonApi.getAllVideoLessonsById.value.data?[0].subjectId ?? '')}',
  //               style: AppTextStyle.normalRegular16
  //                   .copyWith(color: ironColor, fontWeight: FontWeight.w500),
  //             ),
  //             20.pw,
  //             Text(
  //               'Standard :${LessonApi.getAllVideoLessonsById.value.data?[0].standard}',
  //               style: AppTextStyle.normalRegular16
  //                   .copyWith(color: ironColor, fontWeight: FontWeight.w500),
  //             ),
  //             20.pw,
  //             Text(
  //               'Updated : ${DateFormat('dd-MM-yy').format(DateTime.parse(LessonApi.getAllVideoLessonsById.value.data![0].createdAt.toString()))}',
  //               style: AppTextStyle.normalRegular16
  //                   .copyWith(color: ironColor, fontWeight: FontWeight.w500),
  //             ),
  //           ],
  //         ),
  //         // const SizedBox(height: constants.defaultPadding * 5),
  //         const SizedBox(height: constants.defaultPadding * 4),
  //         Text(
  //           'Description',
  //           style: AppTextStyle.normalRegular20
  //               .copyWith(color: ironColor, fontWeight: FontWeight.w500),
  //         ),
  //         const SizedBox(height: constants.defaultPadding),
  //         Text(
  //           ''' ${LessonApi.getAllVideoLessonsById.value.data?[0].discription}''',
  //           style: AppTextStyle.normalRegular14
  //               .copyWith(color: ironColor, fontWeight: FontWeight.w500),
  //         ),
  //         const SizedBox(height: constants.defaultPadding),
  //         Center(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text('Thumbnail',
  //                   style: AppTextStyle.normalRegular20.copyWith(
  //                       color: ironColor, fontWeight: FontWeight.w500)),
  //               LessonApi.getAllVideoLessonsById.value.data?[0].thumbnail !=
  //                       null
  //                   ? Center(
  //                       child: Image.network(
  //                           height: 200,
  //                           '${DatabaseApi.mainUrlImage}/${LessonApi.getAllVideoLessonsById.value.data?[0].thumbnail}'),
  //                     )
  //                   : Padding(
  //                       padding: const EdgeInsets.all(30.0),
  //                       child: Center(
  //                           child: Text(
  //                         "No thumbnail available",
  //                         style: AppTextStyle.normalBold20
  //                             .copyWith(color: Colors.grey[400]),
  //                       )),
  //                     ),
  //               const SizedBox(height: constants.defaultPadding * 2),
  //               Text('Watch Video',
  //                   style: AppTextStyle.normalRegular20.copyWith(
  //                       color: ironColor, fontWeight: FontWeight.w500)),
  //               Center(
  //                 child: VideoPlayerWidget(
  //                   url:
  //                       '${DatabaseApi.mainUrlImage}/${LessonApi.getAllVideoLessonsById.value.data?[0].videoUrl}',
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //         const SizedBox(height: constants.defaultPadding * 4),
  //       ],
  //     ),
  //   );
  // }

  // void deleteCard(BuildContext context, int flashId) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return CustomDeleteWidget(
  //         title: 'Delete Lesson Video ?',
  //         message:
  //             'Once Deleted, all records of this video will be lost and cannot be recovered',
  //         onCancelPressed: () {
  //           Navigator.pop(context);
  //         },
  //         onConfirmPressed: () async {
  //           bool success = await LessonApi.deletelessonvideo(context, flashId);
  //           if (success) {
  //             initialLoading();
  //             Navigator.pop(context);
  //           }
  //         },
  //       );
  //     },
  //   );
  // }

}
