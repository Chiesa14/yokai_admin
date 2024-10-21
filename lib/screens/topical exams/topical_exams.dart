import 'dart:convert';
import 'dart:typed_data';

import 'package:yokai_admin/Widgets/customTable.dart';
import 'package:yokai_admin/Widgets/deleteDialog.dart';
import 'package:yokai_admin/Widgets/editDialog.dart';
import 'package:yokai_admin/Widgets/fetchData.dart';
import 'package:yokai_admin/Widgets/filePicker.dart';
import 'package:yokai_admin/Widgets/filepicker_with_anskey.dart';
import 'package:yokai_admin/Widgets/imageButton.dart';
import 'package:yokai_admin/Widgets/my_dropdown.dart';
import 'package:yokai_admin/Widgets/my_textfield.dart';
import 'package:yokai_admin/Widgets/new_button.dart';
import 'package:yokai_admin/Widgets/searchbar.dart';
import 'package:yokai_admin/api/global_api.dart';
import 'package:yokai_admin/api/local_storage.dart';
import 'package:yokai_admin/globalVariable.dart';
import 'package:yokai_admin/main.dart';
import 'package:yokai_admin/globalVariable.dart';
// import 'package:yokai_admin/screens/dashboard/subject/subject_api.dart';
import 'package:yokai_admin/screens/final%20exams/api/finalexam_api.dart';
import 'package:yokai_admin/screens/topical%20exams/api/topicalexam_api.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/const.dart';
import 'package:yokai_admin/utils/constants.dart';
import 'package:yokai_admin/utils/constants.dart';
import 'package:yokai_admin/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../Widgets/progressHud.dart';
import '../../api/database.dart';

class TopicalExamScreen extends StatefulWidget {
  const TopicalExamScreen({Key? key, required this.scaffold}) : super(key: key);

  @override
  _TopicalExamScreenState createState() => _TopicalExamScreenState();
  final GlobalKey<ScaffoldState> scaffold;
}

class _TopicalExamScreenState extends State<TopicalExamScreen> {
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController marksController = TextEditingController();
  int _characterCount = 0;
  final int maxCharacterCount = 50;
  bool _isLoading = false;
  String selectedCreatedby = "Select";
  String selectedSubject = "Select";
  String selectedGrade = "Select";
  String selectedFilterSubject = "Select";
  String selectedFilterGrade = "Select";
  RxBool questionPaper = true.obs;
  List<String> buttonTexts = ['Question Paper', 'Answer Key'];

  int examId = 0;
  TextEditingController searchController = TextEditingController();

  // String? _pdfPath;
  // String pdfUrl = "${DatabaseApi.mainUrlImage}/uploads/20240401110707_s1.pdf";
  @override
  void initState() {
    super.initState();
    // _refreshData();
    goToMainpage();
  }

  void goToMainpage() {
    setState(() {
      TopicalexamApi.topicalexamRoute('0');
    });
  }

  RxInt selected = 0.obs;

  void _onButtonTap(int index) {
    print('Button tapped with index: $index');
    setState(() {
      selectedButtonIndex = index;
      if (index == 0) {
        selected.value = 0;
        questionPaper.value = true;
      } else if (index == 1) {
        selected.value = 1;
        questionPaper.value = false;
      }
      print("questionPaper :: ${questionPaper.isTrue}");
    });
  }

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

  //   await TopicalexamApi.getalltopicalexam(context);

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  Uint8List? _pdfBytes;
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      // body: ProgressHUD(
      //   isLoading: _isLoading,
      //   // opacity: 0.5,
      //   // color: Colors.black,
      //   child: Padding(
      //       padding: EdgeInsets.symmetric(
      //         horizontal: 20,
      //         // vertical: 15,
      //       ),
      //       child: Obx(() {
      //         return SingleChildScrollView(
      //           child: Container(
      //               color: Colors.white,
      //               child: TopicalexamApi.topicalexamRoute.value == '0'
      //                   ? topicalHome(context)
      //                   : TopicalexamApi.topicalexamRoute.value == '1'
      //                       ? topicalAddExam(context)
      //                       : examDetails(context)),
      //         );
      //       })),
      // ),
    
    );
  }

  List<Map<String, dynamic>> filteredExams = [];
  // Widget topicalHome(BuildContext context) {
  //   if (searchController.text.isNotEmpty) {
  //     // FinalexamApi.searchExams(searchController.text, "2").then((result) {
  //     //   setState(() {
  //     //     filteredExams = result;
  //     //     print("filteredExams searchbar :: $filteredExams");
  //     //   });
  //     // });
  //   } else if (selectedFilterGrade == "Select" &&
  //       selectedFilterSubject == "Select") {
  //     filteredExams = TopicalexamApi.examDetails;
  //     print('Filtered exams all: $filteredExams');
  //   } else {
  //     if (FinalexamApi.filteredDetails.isNotEmpty) {
  //       filteredExams = FinalexamApi.filteredDetails;
  //       print('Filtered exams after filter: $filteredExams');
  //     }
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
  //               'Topical Exams',
  //               style: AppTextStyle.normalBold28.copyWith(color: primaryColor),
  //             ),
  //           ),
  //           Expanded(
  //               flex: 2,
  //               child: CustomButton(
  //                   text: '  + Add Exam  ',
  //                   textSize: 14,
  //                   onPressed: () {
  //                     setState(() {
  //                       TopicalexamApi.topicalexamRoute('1');
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
  //                         });
  //                         _refreshData();
  //                         await FinalexamApi.getexambystandardandsubject(
  //                           context,
  //                           "2",
  //                           subjectWithId[selectedFilterSubject],
  //                           selectedFilterGrade,
  //                         );
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
  //                         });
  //                         _refreshData();
  //                         await SubjectApi.showAllSubjectsByStandard(
  //                             context, selectedFilterGrade);
  //                         await FinalexamApi.getexambystandardandsubject(
  //                           context,
  //                           "2",
  //                           subjectWithId[selectedFilterSubject],
  //                           selectedFilterGrade,
  //                         );
  //                       },
  //                       array: subjects), // CustomInfoField(
  //                 ],
  //               )),
  //           5.pw,
  //           5.pw,
  //           Expanded(
  //               flex: 2,
  //               child: CustomSearchBar(
  //                 controller: searchController,
  //                 hintText: 'Search exam by Name',
  //                 onTextChanged: (keyword) async {
  //                   FinalexamApi.searchExams(searchController.text, "2")
  //                       .then((result) {
  //                     setState(() {
  //                       filteredExams = result;
  //                       print("filteredExams searchbar :: $filteredExams");
  //                       print("result searchbar :: $result");
  //                     });
  //                   });
  //                 },
  //               ))
  //         ],
  //       ),
  //       const SizedBox(
  //         height: constants.defaultPadding * 3,
  //       ),
  //       topicalexamTitles.isEmpty
  //           ? Padding(
  //               padding: const EdgeInsets.all(30.0),
  //               child: Center(
  //                   child: Text(
  //                 "No exams available",
  //                 style: AppTextStyle.normalBold20
  //                     .copyWith(color: Colors.grey[400]),
  //               )),
  //             )
  //           : (filteredExams.isEmpty &&
  //                   (selectedFilterSubject != "Select" ||
  //                       selectedFilterGrade != "Select"))
  //               ? Center(
  //                   child: Text(
  //                   "No matches found",
  //                   style: AppTextStyle.normalBold20
  //                       .copyWith(color: Colors.grey[400]),
  //                 ))
  //               : Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: CustomTable(
  //                     rows: filteredExams.length,
  //                     columns: 3,
  //                     rowNames: List.generate(filteredExams.length,
  //                         (index) => filteredExams[index]['date'] ?? 'NA'),
  //                     columnNames: [
  //                       'Title',
  //                       'Marks',
  //                       // 'Downloads',
  //                       'Action',
  //                     ],
  //                     onTap: (int rowIndex) async {
  //                       setState(() {
  //                         // _refreshData();
  //                         examId =
  //                             TopicalexamApi.examDetails[rowIndex]['exam_id'];
  //                         prefs!.setInt(LocalStorage.examId, examId);

  //                         print("examId :: $examId");
  //                       });
  //                       await FinalexamApi.getexambyid(context, examId)
  //                           .then((value) {
  //                         TopicalexamApi.topicalexamRoute('2');
  //                       });
  //                       prefs!.setString(
  //                           LocalStorage.standard,
  //                           FinalexamApi.getExamById.value.data?[0].standard ??
  //                               "");
  //                       prefs!.setString(
  //                           LocalStorage.subjectId,
  //                           FinalexamApi.getExamById.value.data?[0].subjectId ??
  //                               "");
  //                       print(
  //                           "Standard :: ${prefs?.getString(LocalStorage.standard) ?? ''}");
  //                       print(
  //                           "subjectId :: ${prefs?.getString(LocalStorage.subjectId) ?? ''}");
  //                       print('Cell in row $rowIndex is tapped');

  //                       print('Cell in row $rowIndex is tapped');
  //                     },
  //                     firstColname: 'Date Created ',
  //                     initialValues: [
  //                       for (int i = 0; i < filteredExams.length; i++)
  //                         [
  //                           filteredExams[i]['title'] ?? "NA",
  //                           filteredExams[i]['marks'] ?? "NA",
  //                           // '10',
  //                           // '20',
  //                           ImageButton(
  //                             imagePath: 'icons/delete_icon.png',
  //                             onPressed: () {
  //                               deleteExamCard(
  //                                   context, filteredExams[i]['exam_id']);
  //                               print('button pressed');
  //                             },
  //                           )
  //                         ],
  //                       for (int i = filteredExams.length; i < 6; i++)
  //                         ['', '', '', '', '']
  //                     ],
  //                   ),
  //                 ),
  //     ],
  //   );
  // }

//   String pdfUrlQue = "";
//   String pdfUrlAns = "";
//   Widget examDetails(BuildContext context) {
//     if (FinalexamApi.getExamById.value.data != null &&
//         FinalexamApi.getExamById.value.data!.isNotEmpty) {
//       var uniqueKey = UniqueKey();

//       pdfUrlQue =
//           '${DatabaseApi.mainUrlImage}${FinalexamApi.getExamById.value.data?[0].questionPaper}';
//       print("pdfUrlQue :: $pdfUrlQue");
//       pdfUrlAns =
//           '${DatabaseApi.mainUrlImage}${FinalexamApi.getExamById.value.data?[0].answerKey}';
//       print("pdfUrlAns :: $pdfUrlAns");
//       return SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   flex: 7,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       SizedBox(
//                         height: 30,
//                         child: ImageButton(
//                           imagePath: 'icons/backbutton.png',
//                           onPressed: () {
//                             setState(() {
//                               TopicalexamApi.topicalexamRoute('0');
//                             });
//                           },
//                         ),
//                       ),
//                       5.pw,
//                       Text(
//                         'Exam Details',
//                         style: AppTextStyle.normalBold28
//                             .copyWith(color: primaryColor),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   flex: 1,
//                   child: CustomButton(
//                     text: 'Edit Exam',
//                     textSize: 14,
//                     onPressed: () async {
//                       print("Edit Exam clicked");
//                       await SubjectApi.showAllSubjectsByStandard(context,
//                           prefs?.getString(LocalStorage.standard) ?? '');
//                       dialogOpen.value = true;

//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return EditDialog(
//                             examType: "2",
//                             examId: prefs?.getInt(LocalStorage.examId) ?? 0,
//                             isTopicalexam: false,
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: constants.defaultPadding * 2),
//             Text(
//               'Title : ${FinalexamApi.individualExamDetails[0]['title']}',
//               style: AppTextStyle.normalRegular20
//                   .copyWith(color: ironColor, fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(height: constants.defaultPadding),
//             Row(
//               children: [
//                 Text(
//                   'Subject : ${GlobalApi.getSubjectNameById(FinalexamApi.individualExamDetails[0]['subject'])}',
//                   style: AppTextStyle.normalRegular16
//                       .copyWith(color: ironColor, fontWeight: FontWeight.w500),
//                 ),
//                 20.pw,
//                 Text(
//                   'Standard : ${FinalexamApi.individualExamDetails[0]['standard']}',
//                   style: AppTextStyle.normalRegular16
//                       .copyWith(color: ironColor, fontWeight: FontWeight.w500),
//                 ),
//                 20.pw,
//                 Text(
//                   'Updated : ${FinalexamApi.individualExamDetails[0]['date']}',
//                   style: AppTextStyle.normalRegular16
//                       .copyWith(color: ironColor, fontWeight: FontWeight.w500),
//                 ),
//               ],
//             ),
//             const SizedBox(height: constants.defaultPadding * 4),
//             Text(
//               'Questions',
//               style: AppTextStyle.normalRegular20
//                   .copyWith(color: ironColor, fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(height: constants.defaultPadding),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: List.generate(
//                 2,
//                 (index) => GestureDetector(
//                   onTap: () => _onButtonTap(index),
//                   child: Container(
//                     height: 50,
//                     width: MediaQuery.of(context).size.width / 6,
//                     decoration: BoxDecoration(
//                       color: selectedButtonIndex == index
//                           ? primaryColorLite
//                           : Colors.white,
//                       borderRadius: const BorderRadius.only(
//                         topRight: Radius.circular(12),
//                         topLeft: Radius.circular(12),
//                       ),
//                       border: Border(
//                         // left: Radius.circular(12),
//                         bottom: BorderSide(
//                           color: primaryColorLite,
//                           width: 3,
//                         ),
//                       ),
//                     ),
//                     clipBehavior: Clip.none,
//                     child: Padding(
//                       padding: const EdgeInsets.all(5),
//                       child: Center(
//                         child: Text(
//                           buttonTexts[index],
//                           textAlign: TextAlign.center,
//                           style: AppTextStyle.mediamcheeta,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: constants.defaultPadding * 2),
//             dialogOpen.isFalse
//                 ? Obx(() {
//                     return questionPaper.isTrue
//                         ? Container(
//                             width: MediaQuery.of(context).size.width / 1.5,
//                             color: Colors.white,
//                             child: HtmlWidget(
//                               '<iframe src="$pdfUrlQue" width="100%" height="700"></iframe>',
//                               key: UniqueKey(),
//                             ),
//                           )
//                         : Container(
//                             width: MediaQuery.of(context).size.width / 1.5,
//                             color: Colors.white,
//                             child: HtmlWidget(
//                               '<iframe src="$pdfUrlAns" width="100%" height="700"></iframe>',
//                               key: UniqueKey(),
//                             ),
//                           );
//                   })
//                 : SizedBox()
// // '${FinalexamApi.individualExamDetails[0]['question']}'
//             //         .endsWith('pdf')
//             //     ? SfPdfViewer.network(
//             //         '${DatabaseApi.mainUrlImage}${FinalexamApi.individualExamDetails[0]['question']}',
//             //       )
//             //     : Center(
//             //         child: Text('Not a pdf',
//             //             style: AppTextStyle.normalblack
//             //                 .copyWith(color: headingOrange))),
//           ],
//         ),
//       );
//     } else {
//       return Center(
//           child: CircularProgressIndicator(
//         color: primaryColor,
//       ));
//     }
//   }

//   Widget topicalAddExam(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//           right: MediaQuery.of(context).size.width / 15,
//           bottom: MediaQuery.of(context).size.height / 15),
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
//                         TopicalexamApi.topicalexamRoute('0');
//                       });
//                     },
//                   ),
//                 ),
//                 5.pw,
//                 Text(
//                   'Add Topical Exam',
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
//                           onChange: (value) async {
//                             setState(() {
//                               selectedGrade = value!;
//                             });
//                             _refreshData();
//                           },
//                           array: grade), // CustomInfoField(
//                       //
//                     ],
//                   )),
//               10.pw,
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
//                           onChange: (value) async {
//                             setState(() {
//                               selectedSubject = value!;
//                             });
//                             await SubjectApi.showAllSubjectsByStandard(
//                                 context, selectedGrade);
//                           },
//                           array: subjects), // CustomInfoField(
//                       //
//                     ],
//                   )),
//               10.pw,
//               Expanded(
//                   flex: 1,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CustomInfoField(
//                           label: "Marks",
//                           controller: marksController), // CustomInfoField(
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
//             height: constants.defaultPadding,
//           ),
//           FileUploadWithAns(
//             title: 'Questions with correct answers for Test',
//             text: 'Click to browse',
//             type: "2",
//           ),
//           const SizedBox(
//             height: constants.defaultPadding * 3,
//           ),
//           Center(
//               child: CustomButton(
//             text: 'Add Topical Exam',
//             onPressed: () {
//               _onAddTopicalExamPressed(context);
//             },
//             width: MediaQuery.of(context).size.width / 3.5,
//           )),
//           const SizedBox(
//             height: constants.defaultPadding / 2,
//           ),
//           Center(
//             child: Text(
//               'You can always edit your questions in the future',
//               style: AppTextStyle.normalRegular14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void deleteExamCard(BuildContext context, int examId) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return CustomDeleteWidget(
//           title: 'Delete Exam ?',
//           message:
//               'All its’ details will be lost and students will not be able to see the exam on the app. ',
//           onCancelPressed: () {
//             Navigator.pop(context);
//           },
//           onConfirmPressed: () async {
//             bool success = await FinalexamApi.deleteExam(context, examId);
//             if (success) {
//               _refreshData();
//             }
//             Navigator.pop(context);
//           },
//         );
//       },
//     );
//   }

//   void _onAddTopicalExamPressed(BuildContext context) async {
//     String standard = selectedGrade;
//     String subject = selectedSubject;
//     String title = _titlecontroller.text.trim();
//     String errorMessage = '';

//     if (standard == "Select") {
//       errorMessage = "Please select a standard.";
//     } else if (subject == "Select") {
//       errorMessage = "Please select a subject.";
//     } else if (_titlecontroller.text.isEmpty) {
//       errorMessage = "Please enter a title.";
//     } else if (marksController.text.isEmpty) {
//       errorMessage = "Please enter a marks.";
//     } else if (TopicalexamApi.questionsUrls.length < 2) {
//       errorMessage = "Please upload both question and answer files.";
//     }

//     if (errorMessage.isNotEmpty) {
//       showErrorSnackBar(
//         errorMessage,
//       );
//       return;
//     }

//     int? subjectId = subjectWithId[selectedSubject];

//     if (subjectId == null) {
//       showErrorSnackBar("Subject ID not found!");
//       return;
//     }

//     bool success = await TopicalexamApi.createexam(context, {
//       "exam_title": title,
//       "exam_type_id": "2",
//       "subject_id": subjectId.toString(),
//       "standard": standard,
//       "marks": marksController.text.trim(),
//       "passing_marks": "NA",
//       "question_paper": TopicalexamApi.questionsUrls.isNotEmpty
//           ? TopicalexamApi.questionsUrls[0]
//           : "",
//       "answer_key": TopicalexamApi.questionsUrls.isNotEmpty
//           ? TopicalexamApi.questionsUrls[1]
//           : ""
//     });

//     if (success) {
//       showSuccessSnackBar(
//         '',
//         "Topical exam added successfully!",
//       );
//       FinalexamApi.questionsUrls.clear();
//       selectedGrade = "Select";
//       selectedSubject = "Select";
//       marksController.clear();
//       _titlecontroller.clear();
//       setState(() {
//         TopicalexamApi.topicalexamRoute('0');
//       });
//       _refreshData();
//     }
//   }

}
