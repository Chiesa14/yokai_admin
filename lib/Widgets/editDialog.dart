// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:excel/excel.dart' as exc;

// import 'package:yokai_admin/Widgets/filePicker.dart';
// import 'package:yokai_admin/Widgets/my_dropdown.dart';
// import 'package:yokai_admin/Widgets/new_button.dart';
// import 'package:yokai_admin/Widgets/outline_button.dart';
// import 'package:yokai_admin/Widgets/textfield.dart';
// import 'package:yokai_admin/api/global_api.dart';
// import 'package:yokai_admin/api/local_storage.dart';
// import 'package:yokai_admin/main.dart';
// import 'package:yokai_admin/globalVariable.dart';

// import 'package:yokai_admin/utils/colors.dart';
// import 'package:yokai_admin/utils/const.dart';
// import 'package:yokai_admin/utils/text_styles.dart';
// import 'package:csv/csv.dart';
// import 'package:flutter/material.dart';
// import 'package:yokai_admin/utils/constants.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

// class EditDialog extends StatefulWidget {
//   final String title;
//   final int examId;
//   final int examDetailsId;
//   final bool isTopicalexam;
//   final String examType;

//   EditDialog(
//       {this.isTopicalexam = true,
//       this.title = 'Edit Exam',
//       this.examId = 0,
//       this.examDetailsId = 0,
//       required this.examType});

//   @override
//   _EditDialogState createState() => _EditDialogState();
// }

// class _EditDialogState extends State<EditDialog> {
//   String selectedCreatedby = "Select";
//   String selectedSubject = GlobalApi.getSubjectNameById(
//       prefs?.getString(LocalStorage.subjectId) ?? '');
//   String selectedGrade = prefs?.getString(LocalStorage.standard) ?? '';
//   TextEditingController titleController = TextEditingController(
//       text: '${FinalexamApi.individualExamDetails[0]['title']}');
//   String question = '${FinalexamApi.individualExamDetails[0]['question']}';
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   void onEditExam(BuildContext context) async {
//     String title = titleController.text.trim();
//     int? subjectId = subjectWithId[selectedSubject];
//     String errorMessage = '';

//     if (selectedGrade == "Select") {
//       errorMessage = "Please select a standard.";
//     } else if (selectedSubject == "Select") {
//       errorMessage = "Please select a subject.";
//     } else if (titleController.text.isEmpty) {
//       errorMessage = "Please enter a title.";
//     }

//     if (errorMessage.isNotEmpty) {
//       showErrorSnackBar(
//         errorMessage,
//       );
//       return;
//     }
//     if (subjectId == null) {
//       showErrorSnackBar(
//         "Subject ID not found!",
//       );
//       return;
//     }
//     if (widget.examType == "4") {
      
//     } else {
//       bool success = await FinalexamApi.updateexam(
//           context,
//           {
//             "exam_title": title,
//             "exam_type_id": widget.examType,
//             "subject_id": subjectId.toString(),
//             "standard": selectedGrade,
//             "marks": "${FinalexamApi.individualExamDetails[0]['marks']}",
//             "passing_marks": "NA",
//             "question_paper": (widget.examType == "1")
//                 ? (FinalexamApi.questionsUrls.isNotEmpty
//                     ? FinalexamApi.questionsUrls[0]
//                     : "${FinalexamApi.individualExamDetails[0]['question']}")
//                 : widget.examType == "2"
//                     ? (TopicalexamApi.questionsUrls.isNotEmpty
//                         ? TopicalexamApi.questionsUrls[0]
//                         : "${FinalexamApi.individualExamDetails[0]['question']}")
//                     : (OtherExamApi.questionsUrls.isNotEmpty
//                         ? OtherExamApi.questionsUrls[0]
//                         : "${FinalexamApi.individualExamDetails[0]['question']}"),
//             "answer_key": widget.examType == "1"
//                 ? (FinalexamApi.questionsUrls.isNotEmpty
//                     ? FinalexamApi.questionsUrls[1]
//                     : "${FinalexamApi.individualExamDetails[0]['answer']}")
//                 : widget.examType == "2"
//                     ? (TopicalexamApi.questionsUrls.isNotEmpty
//                         ? TopicalexamApi.questionsUrls[1]
//                         : "${FinalexamApi.individualExamDetails[0]['answer']}")
//                     : (OtherExamApi.questionsUrls.isNotEmpty
//                         ? OtherExamApi.questionsUrls[1]
//                         : "${FinalexamApi.individualExamDetails[0]['answer']}"),
//           },
//           prefs!.getInt(LocalStorage.examId));

//       if (success) {
//         showSuccessSnackBar(
//           '',
//           "Exam Edited",
//         );
//         FinalexamApi.questionsUrls.clear();
//         await SubjectApi.showAllSubjects(context);
//         await SubjectApi.showAllSubjectsByStandard(context, selectedGrade);

//         widget.examType == "1"
//             ? await FinalexamApi.getallfinalexam(context)
//             : widget.examType == "2"
//                 ? await TopicalexamApi.getalltopicalexam(context)
//                 : OtherExamApi.getotherexam(context);
//         widget.examType == "1"
//             ? FinalexamApi.finalexamRoute('0')
//             : widget.examType == "2"
//                 ? TopicalexamApi.topicalexamRoute('0')
//                 : OtherExamApi.otherexamRoute('0');
//         setState(() {});
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       content: SingleChildScrollView(
//         child: Container(
//           width: MediaQuery.of(context).size.width / 3.5,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.pop(context);
//                       dialogOpen.value = false;
//                     },
//                     child: Icon(
//                       Icons.close,
//                       color: Colors.red,
//                     ),
//                   )
//                 ],
//               ),
//               Center(
//                 child: Text(
//                   widget.title,
//                   style: TextStyle(
//                     fontFamily: 'Montserrat',
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: textDark,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: constants.defaultPadding * 2,
//               ),
//               Text(
//                 'Title',
//                 style: AppTextStyle.normalRegular14.copyWith(color: labelColor),
//               ),
//               0.5.ph,
//               TextFeildStyle(
//                 hintText: '${FinalexamApi.individualExamDetails[0]['title']}',
//                 onChanged: (p0) {},
//                 controller: titleController,
//                 height: 50,
//                 // enabledBorder: widget.,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   border: Border.all(color: greyborder),
//                 ),
//                 // hintText: 'johnny@mychetapep.com',
//                 hintStyle:
//                     AppTextStyle.normalRegular10.copyWith(color: hintText),
//                 border: InputBorder.none,
//               ),
//               2.ph,
//               Text(
//                 'Subject',
//                 style: AppTextStyle.normalRegular14.copyWith(color: labelColor),
//               ),
//               0.5.ph,
//               MyDropDown(
//                   borderWidth: 1,
//                   defaultValue: selectedSubject,
//                   onChange: (value) {
//                     setState(() {
//                       selectedSubject = value!;
//                     });
//                   },
//                   array: subjects), // CustomInfoField(

//               2.ph,
//               Text(
//                 'Standard',
//                 style: AppTextStyle.normalRegular14.copyWith(color: labelColor),
//               ),
//               0.5.ph,

//               MyDropDown(
//                   borderWidth: 1,
//                   defaultValue: selectedGrade,
//                   onChange: (value) async {
//                     setState(() {
//                       selectedGrade = value!;
//                     });
//                     await SubjectApi.showAllSubjectsByStandard(
//                         context, selectedGrade);
//                   },
//                   array: grade),
//               if (widget.isTopicalexam == false)
//                 // CustomInfoField(
//                 2.ph,
//               if (widget.isTopicalexam == false)
//                 Text(
//                   widget.isTopicalexam
//                       ? 'Questions with correct answers for Test'
//                       : 'Question Paper',
//                   style:
//                       AppTextStyle.normalRegular14.copyWith(color: labelColor),
//                 ),
//               0.5.ph,
//               if (widget.isTopicalexam == false)
//                 FileUploadWidget(
//                   ques: true,
//                   type: widget.examType,
//                   isMicronotes: false,
//                   showFileTypes: false,
//                   text:
//                       'Click to upload\nThis will replace existing questions list.',
//                 ),
//               if (widget.isTopicalexam == false) 2.ph,
//               if (widget.isTopicalexam == false)
//                 Text(
//                   'Answer Key',
//                   style:
//                       AppTextStyle.normalRegular14.copyWith(color: labelColor),
//                 ),
//               if (widget.isTopicalexam == false) 0.5.ph,
//               if (widget.isTopicalexam == false)
//                 FileUploadWidget(
//                   ques: false,
//                   type: widget.examType,
//                   isMicronotes: false,
//                   showFileTypes: false,
//                   text:
//                       'Click to upload\nThis will replace existing questions list.',
//                 ),
//               2.ph,
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: CustomButton(
//                   isPopup: true,
//                   textSize: 14,
//                   width: MediaQuery.of(context).size.width / 4,
//                   text: 'Save Changes',
//                   onPressed: () {
//                     print("Save Changes");
//                     Navigator.pop(context);
//                     onEditExam(context);
//                     setState(() {
//                       dialogOpen.value = false;
//                     });
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   //   Future<List<Map<String, dynamic>>> convertFileToJson(
//   //     BuildContext context, Uint8List bytes, String fileName) async {
//   //   try {
//   //     List<List<dynamic>> rows;
//   //     if (fileName.endsWith('.csv')) {
//   //       String content = utf8.decode(bytes);
//   //       print("content :: $content");
//   //       rows = CsvToListConverter().convert(content);
//   //       print("rows :: $rows");
//   //     } else if (fileName.endsWith('.xlsx')) {
//   //       var excel = exc.Excel.decodeBytes(bytes);
//   //       var sheet = excel['Sheet1'];
//   //       rows = sheet.rows ?? [];
//   //     } else {
//   //       print('Unsupported file format: $fileName');
//   //       return [];
//   //     }
//   //     List<String> headers = rows[0].map((cell) => cell.toString()).toList();
//   //     print("headers :: $headers");
//   //     List<Map<String, dynamic>> jsonData = [];
//   //     List<Map<String, dynamic>> requestBodyList = [];

//   //     Map<String, dynamic>? currentQuestion;

//   //     for (var i = 1; i < rows.length; i++) {
//   //       var row = rows[i];
//   //       Map<String, dynamic> data = {};

//   //       for (var j = 0; j < headers.length; j++) {
//   //         data[headers[j]] = row[j].toString();
//   //       }

//   //       print('data[] :: ${data['Questions']}');

//   //       if (data['Questions'] != '') {
//   //         if (currentQuestion != null) {
//   //           jsonData.add({
//   //             'Questions': currentQuestion['Questions'],
//   //             'Options': currentQuestion['Options'],
//   //             'correct_answer': currentQuestion['correct_answer']
//   //           });
//   //         }
//   //         currentQuestion = {
//   //           'Questions': data['Questions'],
//   //           'Options': data['Options'],
//   //           'correct_answer': data['correct_answer']
//   //         };
//   //       } else {
//   //         currentQuestion!['Options'] += ', ${data['Options']}';
//   //       }
//   //     }

//   //     if (currentQuestion != null) {
//   //       jsonData.add({
//   //         'Questions': currentQuestion['Questions'],
//   //         'Options': currentQuestion['Options'],
//   //         'correct_answer': currentQuestion['correct_answer']
//   //       });
//   //     }
//   //     final _debouncer = Debouncer(delay: Duration(milliseconds: 500));

//   //     for (var item in jsonData) {
//   //       print('ITEM :: ${item['Questions']}');
//   //       print('ITEM :: ${item['Options']}');
//   //       List<String> options = item['Options'].split(',');

//   //       Map<String, String> optionKeys = {
//   //         "option_a": options.isNotEmpty ? options[0].trim() : "",
//   //         "option_b": options.length > 1 ? options[1].trim() : "",
//   //         "option_c": options.length > 2 ? options[2].trim() : "",
//   //         "option_d": options.length > 3 ? options[3].trim() : "",
//   //         "option_e": options.length > 4 ? options[4].trim() : "",
//   //         "option_f": options.length > 5 ? options[5].trim() : "",
//   //       };

//   //       Map<String, dynamic> requestBody = {
//   //         "exam_id": OtherExamApi.examId.toString(),
//   //         "question": item["Questions"],
//   //         ...optionKeys,
//   //         "correct_answer": item["correct_answer"]
//   //       };
//   //       requestBodyList.add(requestBody);
//   //     }
//   //     print('requestBodyList :: ${requestBodyList.length}');
//   //     for (var requestBody in requestBodyList) {
//   //       // await OtherExamApi.updateexamdetails(context, requestBody);
//   //     }
//   //     showSuccessSnackBar('', 'Exam added Successfully!');
//   //     return jsonData;
//   //   } catch (e) {
//   //     print('Error during file conversion: $e');
//   //     showErrorSnackBar('Error during file conversion: $e');
//   //     return [];
//   //   }
//   // }
// }
