// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:file_picker/file_picker.dart';
//
// class ImagePickerWidget extends StatefulWidget {
//   final String svgAsset;
//   final String text;
//   final Color backgroundColor;
//   final Color borderColor;
//   final Color svgColor;
//   final TextStyle textStyle;
//
//   const ImagePickerWidget({
//     Key? key,
//     required this.svgAsset,
//     required this.text,
//     required this.backgroundColor,
//     required this.borderColor,
//     required this.svgColor,
//     required this.textStyle,
//   }) : super(key: key);
//
//   @override
//   _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
// }
//
// class _ImagePickerWidgetState extends State<ImagePickerWidget> {
//   String? _fileName;
//   late File _selectedImage;
//
//   Future<void> _selectFile() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['jpeg', 'jpg', 'png', 'svg'],
//       );
//
//       if (result != null) {
//         PlatformFile file = result.files.first;
//         print('Picked file: ${file.name}');
//         setState(() {
//           _fileName = file.name;
//           _selectedImage = File(file.path!);
//         });
//       } else {
//         print('No file picked.');
//       }
//     } catch (e) {
//       print('Error picking file: $e');
//     }
//   }
//
//   void _clearSelection() {
//     setState(() {
//       _fileName = null;
//       _selectedImage = File('');
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedImage = File('');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: 1,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 28),
//         decoration: BoxDecoration(
//           color: widget.backgroundColor,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: widget.borderColor),
//         ),
//         child: InkWell(
//           onTap: _selectFile,
//           child: _selectedImage.path.isNotEmpty
//               ? Stack(
//                   fit: StackFit.expand,
//                   children: [
//                     Image.file(
//                       _selectedImage,
//                       fit: BoxFit.cover,
//                     ),
//                     Positioned(
//                       top: 8,
//                       left: 8,
//                       child: IconButton(
//                         icon: Icon(Icons.cancel, color: Colors.white),
//                         onPressed: _clearSelection,
//                       ),
//                     ),
//                   ],
//                 )
//               : Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SvgPicture.asset(
//                       widget.svgAsset,
//                       color: widget.svgColor,
//                     ),
//                     Text(
//                       widget.text,
//                       style: widget.textStyle,
//                     ),
//                     if (_fileName != null) ...[
//                       SizedBox(height: 10),
//                       Text(
//                         'Selected file: $_fileName',
//                         style: widget.textStyle.copyWith(color: Colors.green),
//                       ),
//                     ],
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }
// }
///import from lms

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yokai_admin/utils/const.dart';

import '../globalVariable.dart';
import '../screens/activities/Controller/activities_Controller.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';
import './new_button.dart';

class ImagePickerWidget extends StatefulWidget {
  final String title;
  final String text;
  final String examId;
  final String srNo;
  final bool isMircoNotes;
  final bool isAddQue;
  final String question;
  final String questionImg;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String optionE;
  final String optionF;
  final String correctAns;
  final String examDetailId;

  ImagePickerWidget(
      {required this.text,
      this.title = '',
      this.examId = '',
      this.srNo = '',
      this.question = '',
      this.questionImg = '',
      this.optionA = '',
      this.optionB = '',
      this.optionC = '',
      this.optionD = '',
      this.optionE = '',
      this.optionF = '',
      this.correctAns = '',
      this.isMircoNotes = false,
      this.isAddQue = false,
      required this.examDetailId});

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  String _fileName = '';
  Uint8List? filePath;

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpeg', 'jpg', 'png', 'svg'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      print('Picked file: ${file.name}');
      filePath = file.bytes;
      setState(() {
        _fileName = file.name;
      });
    } else {
      print('No file picked.');
    }
  }

  bool _isAdding = false;

  @override
  Widget build(BuildContext context) {
    return _fileName.isNotEmpty
        ? Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.memory(
                        filePath!,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            filePath = null;
                            _fileName = '';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          padding: EdgeInsets.all(2),
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                1.ph,
                _isAdding
                    ? CircularProgressIndicator(
                        color: primaryColor,
                      )
                    : CustomButton(
                        width: 200,
                        text: 'Upload',
                        onPressed: () async {
                          setState(() {
                            _isAdding = true;
                          });
                          if (filePath!.isNotEmpty) {
                            // OtherExamApi.uploadImage(filePath!, _fileName).then(
                            //   (value) async {
                            //     if (value) {
                                  bool success = await ActivitiesController
                                      .updateActivityDetailsById(
                                          context,
                                          {
                                            "exam_id": widget.examId,
                                            "sr_no": widget.srNo,
                                            "question": widget.question,
                                            // "question_image": OtherExamApi
                                            //     .imagesUrl.isNotEmpty
                                            //     ? OtherExamApi.imagesUrl[0]
                                            //     : '',
                                            "option_a": widget.optionA,
                                            "option_b": widget.optionB,
                                            "option_c": widget.optionC,
                                            "option_d": widget.optionD,
                                            "option_e": widget.optionE,
                                            "option_f": "",
                                            "correct_answer": widget.correctAns
                                          },
                                          widget.examDetailId);

                                  if (success) {
                                    await ActivitiesController
                                        .getActivityByActivityId(widget.examId);
                                    showSuccessSnackBar('',
                                        "Question Image uploaded successfully");

                                    Navigator.pop(context);
                                    setState(() {
                                      _isAdding = false;
                                      // OtherExamApi.imagesUrl.clear();
                                    });
                                  }
                                } else {
                                  showErrorSnackBar(
                                      "Failed to upload Question Image",colorError);
                                  setState(() {
                                    _isAdding = false;
                                  });
                                }
                            //   },
                            // );
                          }
                        // },
                      ),
              ],
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title.isNotEmpty || _fileName.isEmpty)
                Text(
                  widget.title,
                  style: AppTextStyle.normalRegular14,
                ),
              if (widget.title.isNotEmpty) SizedBox(height: 10),
              InkWell(
                onTap: () {
                  if (_fileName == '') {
                    _selectFile();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1, color: primaryColor),
                    color: Color(0xffF5F6F6),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Icon(
                            Icons.add,
                            color: primaryColor,
                          ),
                          SizedBox(height: 10),
                          Text(
                            widget.text,
                            style: AppTextStyle.normalRegular14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
