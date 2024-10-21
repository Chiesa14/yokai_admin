// import 'package:yokai_admin/Widgets/imageButton.dart';
// // import 'package:yokai_admin/screens/final%20exams/api/finalexam_api.dart';
// import 'package:yokai_admin/utils/colors.dart';
// import 'package:yokai_admin/utils/const.dart';
// import 'package:yokai_admin/utils/text_styles.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';

// import '../globalVariable.dart';
// // import '../screens/topical exams/api/topicalexam_api.dart';

// class FileUploadWithAns extends StatefulWidget {
//   final String title;
//   final String text;
//   final bool isMicronotes;
//   final bool showFileTypes;
//   final String type;
//   FileUploadWithAns(
//       {required this.text,
//       this.isMicronotes = false,
//       this.type = "1",
//       this.showFileTypes = true,
//       this.title = ''});
//   @override
//   _FileUploadWithAnsState createState() => _FileUploadWithAnsState();
// }

// class _FileUploadWithAnsState extends State<FileUploadWithAns> {
//   String _fileNameQue = '';
//   String _fileNameAns = '';

//   ///akash
//   // void _selectFile() async {
//   //   // Open file picker dialog
//   //   html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
//   //   uploadInput.click();
//   //
//   //   uploadInput.onChange.listen((e) async {
//   //     final html.File file = uploadInput.files!.first;
//   //
//   //     // Read the selected file
//   //     final reader = html.FileReader();
//   //     reader.readAsDataUrl(file);
//   //
//   //     reader.onLoadEnd.listen((event) async {
//   //       // Extract text from DOCX file
//   //       String text = await extractTextFromDocx(reader.result as String);
//   //
//   //       // Store extracted text into modal class
//   //       setState(() {
//   //         _docxModel = MyDocxModel(text: text);
//   //       });
//   //     });
//   //   });
//   // }
//   //
//   // Future<String> extractTextFromDocx(String dataUrl) async {
//   //   // Convert data URL to Uint8List
//   //   Uint8List bytes = base64.decode(dataUrl.split(',').last);
//   //
//   //   // Extract text from DOCX using docx_to_text package
//   //   // String text = await DocxTextExtractor().extractTextFromBytes(bytes);
//   //   final text = docxToText(bytes, handleNumbering: true);
//   //   parseQuestions(text);
//   //   print('TEXTTEXT :: $text');
//   //   return text;
//   // }
//   //
//   // List<Question> parseQuestions(String text) {
//   //   List<Question> questions = [];
//   //   List<String> lines = text.split('\n');
//   //
//   //   for (int i = 0; i < lines.length; i++) {
//   //     String line = lines[i].trim();
//   //
//   //     if (line.isNotEmpty) {
//   //       if (line.endsWith(':')) {
//   //         String questionText = line;
//   //         List<String> options = [];
//   //         int correctAnswerIndex = -1;
//   //
//   //         // Collect options until the next question or empty line
//   //         for (int j = i + 1; j < lines.length; j++) {
//   //           String nextLine = lines[j].trim();
//   //
//   //           if (nextLine.isNotEmpty &&
//   //               !nextLine.startsWith(RegExp(r'[0-9]+\.'))) {
//   //             if (nextLine.startsWith(RegExp(r'[A-E]\:'))) {
//   //               options.add(nextLine.substring(2).trim());
//   //
//   //               // Check for correct answer
//   //               if (nextLine.startsWith('A:')) {
//   //                 correctAnswerIndex = options.length - 1;
//   //               }
//   //             }
//   //           } else {
//   //             break;
//   //           }
//   //         }
//   //
//   //         questions.add(Question(
//   //           questionText: questionText,
//   //           options: options,
//   //           correctAnswerIndex: correctAnswerIndex,
//   //         ));
//   //         for (int i = 0; i < questions.length; i++) {
//   //           print('QUESTION :: ${questions[i].questionText}');
//   //         }
//   //       }
//   //     }
//   //   }
//   //
//   //   return questions;
//   // }

//   ///shubhangi
//   Future<void> _selectFile(bool isQuestion) async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf'],
//       );

//       if (result != null && result.files.isNotEmpty) {
//         setState(() {
//           if (isQuestion) {
//             _fileNameQue = result.files.first.name;
//           } else {
//             _fileNameAns = result.files.first.name;
//           }
//           filePath = result.files.single.bytes;
//         });

//         if (filePath != null) {
//           String fileName = isQuestion ? _fileNameQue : _fileNameAns;

//           if (fileName.toLowerCase().endsWith('.pdf')) {
//             bool success = (widget.type == "1" || widget.type == "3")
//                 ? await FinalexamApi.uploadQuestionPaper(
//                     filePath!, fileName, isQuestion)
//                 : await TopicalexamApi.uploadQuestionPaper(
//                     filePath!, fileName, isQuestion);
//             if (success) {
//               String message = isQuestion
//                   ? 'Question file uploaded successfully.'
//                   : 'Answer file uploaded successfully.';
//               print(message);
//               showSuccessSnackBar('', message);
//             } else {
//               String errorMessage = isQuestion
//                   ? 'Failed to upload Question file.'
//                   : 'Failed to upload Answer file.';
//               print(errorMessage);
//               showErrorSnackBar(
//                 errorMessage,
//               );
//             }
//           } else {
//             showErrorSnackBar(
//               "Invalid file format",
//             );
//           }
//         }
//       } else {
//         showErrorSnackBar(
//           "No file selected",
//         );
//       }
//     } catch (e) {
//       print("Error selecting file: $e");
//       showErrorSnackBar(
//         "Error selecting file",
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Question Paper: ',
//               style: textStyle.labelStyle,
//             ),
//             if (widget.title.isNotEmpty) 2.ph,
//             InkWell(
//               onTap: () {
//                 if (_fileNameQue == '') {
//                   _selectFile(true);
//                   // _selectFile();
//                   // filePath = '';
//                 }
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(width: 1, color: primaryColor),
//                   color: Color(0xffF5F6F6),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(20),
//                   child: _fileNameQue.isNotEmpty
//                       ? Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Uploaded',
//                               style: AppTextStyle.normalRegular14
//                                   .copyWith(color: labelColor),
//                             ),
//                             1.ph,
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 border:
//                                     Border.all(width: 1, color: bordercolor),
//                                 color: Color(0xffF5F6F6),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       '$_fileNameQue',
//                                       style: AppTextStyle.normalRegular14
//                                           .copyWith(color: labelColor),
//                                     ),
//                                     3.pw,
//                                     InkWell(
//                                       onTap: () {
//                                         print("Delete file");
//                                         setState(() {
//                                           _fileNameQue = '';
//                                           (widget.type == "1" ||
//                                                   widget.type == "3")
//                                               ? FinalexamApi.questionsUrls
//                                                   .removeAt(0)
//                                               : TopicalexamApi.questionsUrls
//                                                   .removeAt(0);
//                                         });
//                                         //  widget.type == "1"?FinalexamApi.questionsUrls[0].
//                                       },
//                                       child: Image.asset(
//                                         'icons/mi_delete.png',
//                                         height: 20,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       : Column(
//                           children: [
//                             Text(
//                               widget.text,
//                               style: AppTextStyle.normalRegular14
//                                   .copyWith(color: labelColor),
//                             ),
//                             2.ph,
//                             Column(
//                               children: [
//                                 Text(
//                                   'Supported format :',
//                                   style: textStyle.labelStyle,
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(10),
//                                   child: ImageButton(
//                                     imagePath: 'icons/download_pdf.svg',
//                                     onPressed: () {
//                                       print('button pressed');
//                                     },
//                                   ),
//                                   //  Column(
//                                   //   crossAxisAlignment:
//                                   //       CrossAxisAlignment.start,
//                                   //   children: [
//                                   //     Row(
//                                   //       mainAxisSize: MainAxisSize.min,
//                                   //       children: [
//                                   //         if (widget.isMicronotes == true)
//                                   //           ImageButton(
//                                   //             imagePath:
//                                   //                 'icons/download_csv.svg',
//                                   //             onPressed: () {
//                                   //               print('button pressed');
//                                   //             },
//                                   //           ),
//                                   //         if (widget.isMicronotes == true)
//                                   //           10.pw,
//                                   //         ImageButton(
//                                   //           imagePath: 'icons/download_pdf.svg',
//                                   //           onPressed: () {
//                                   //             print('button pressed');
//                                   //           },
//                                   //         ),
//                                   //         10.pw,
//                                   //         ImageButton(
//                                   //           imagePath: 'icons/download_csv.svg',
//                                   //           onPressed: () {
//                                   //             print('button pressed');
//                                   //           },
//                                   //         ),
//                                   //       ],
//                                   //     )
//                                   //   ],
//                                   // ),
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Answer Key: ',
//               style: textStyle.labelStyle,
//             ),
//             if (widget.title.isNotEmpty) 2.ph,
//             InkWell(
//               onTap: () {
//                 print("Answer key");
//                 if (_fileNameAns == '') {
//                   _selectFile(false);
//                 }
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(width: 1, color: primaryColor),
//                   color: Color(0xffF5F6F6),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(20),
//                   child: _fileNameAns.isNotEmpty
//                       ? Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Uploaded',
//                               style: AppTextStyle.normalRegular14
//                                   .copyWith(color: labelColor),
//                             ),
//                             1.ph,
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 border:
//                                     Border.all(width: 1, color: bordercolor),
//                                 color: Color(0xffF5F6F6),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       '$_fileNameAns',
//                                       style: AppTextStyle.normalRegular14
//                                           .copyWith(color: labelColor),
//                                     ),
//                                     3.pw,
//                                     InkWell(
//                                       onTap: () {
//                                         print("Delete file");
//                                         setState(() {
//                                           _fileNameAns = '';
//                                           (widget.type == "1" ||
//                                                   widget.type == "3")
//                                               ? FinalexamApi.questionsUrls
//                                                   .removeAt(0)
//                                               : TopicalexamApi.questionsUrls
//                                                   .removeAt(0);
//                                         });
//                                       },
//                                       child: Image.asset(
//                                         'icons/mi_delete.png',
//                                         height: 20,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       : Column(
//                           children: [
//                             Text(
//                               widget.text,
//                               style: AppTextStyle.normalRegular14
//                                   .copyWith(color: labelColor),
//                             ),
//                             2.ph,
//                             Column(
//                               children: [
//                                 Text(
//                                   'Supported format :',
//                                   style: textStyle.labelStyle,
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(10),
//                                   child: ImageButton(
//                                     imagePath: 'icons/download_pdf.svg',
//                                     onPressed: () {
//                                       print('button pressed');
//                                     },
//                                   ),
//                                   //  Column(
//                                   //   crossAxisAlignment:
//                                   //       CrossAxisAlignment.start,
//                                   //   children: [
//                                   //     Row(
//                                   //       mainAxisSize: MainAxisSize.min,
//                                   //       children: [
//                                   //         if (widget.isMicronotes == true)
//                                   //           ImageButton(
//                                   //             imagePath:
//                                   //                 'icons/download_csv.svg',
//                                   //             onPressed: () {
//                                   //               print('button pressed');
//                                   //             },
//                                   //           ),
//                                   //         if (widget.isMicronotes == true)
//                                   //           10.pw,
//                                   //         ImageButton(
//                                   //           imagePath: 'icons/download_pdf.svg',
//                                   //           onPressed: () {
//                                   //             print('button pressed');
//                                   //           },
//                                   //         ),
//                                   //         10.pw,
//                                   //         ImageButton(
//                                   //           imagePath: 'icons/download_csv.svg',
//                                   //           onPressed: () {
//                                   //             print('button pressed');
//                                   //           },
//                                   //         ),
//                                   //       ],
//                                   //     )
//                                   //   ],
//                                   // ),
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class MyDocxModel {
//   String text;

//   MyDocxModel({required this.text});
// }

// class Question {
//   final String questionText;
//   final List<String> options;
//   final int correctAnswerIndex;

//   Question({
//     required this.questionText,
//     required this.options,
//     required this.correctAnswerIndex,
//   });
// }
