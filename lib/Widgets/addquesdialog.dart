import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yokai_admin/Widgets/my_textfield.dart';
import 'package:yokai_admin/Widgets/new_button.dart';
import 'package:yokai_admin/Widgets/outline_button.dart';
import 'package:yokai_admin/Widgets/textfield.dart';
import 'package:yokai_admin/screens/activities/Controller/activities_Controller.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/const.dart';
import 'package:yokai_admin/utils/constants.dart';
import 'package:yokai_admin/utils/text_styles.dart';

import '../api/database.dart';
import '../globalVariable.dart';
import 'customradiotile.dart';

class AddQuestionDialog extends StatefulWidget {
  const AddQuestionDialog(
      {Key? key,
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
      this.explanation = '',
      this.correctAns = '',
      this.isMircoNotes = false,
      this.isAddQue = false,
      required this.examDetailId})
      : super(key: key);

  @override
  _AddQuestionDialogState createState() => _AddQuestionDialogState();
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
  final String explanation;
  final String correctAns;
  final String examDetailId;
}

class _AddQuestionDialogState extends State<AddQuestionDialog> {
  TextEditingController _questioncontroller = TextEditingController();
  TextEditingController optioncontroller1 = TextEditingController();
  TextEditingController optioncontroller2 = TextEditingController();
  TextEditingController optioncontroller4 = TextEditingController();
  TextEditingController optioncontroller3 = TextEditingController();
  TextEditingController optioncontroller5 = TextEditingController();
  TextEditingController explanationcontroller = TextEditingController();

  String? selectedCorrectAnswer;
  bool showAddOptionButton = true;

  @override
  void initState() {
    _questioncontroller = TextEditingController(text: widget.question);
    optioncontroller1 = TextEditingController(text: widget.optionA);
    optioncontroller2 = TextEditingController(text: widget.optionB);
    optioncontroller3 = TextEditingController(text: widget.optionC);
    optioncontroller4 = TextEditingController(text: widget.optionD);
    optioncontroller5 = TextEditingController(text: widget.optionE);
    explanationcontroller = TextEditingController(text: widget.explanation);

    showAddOptionButton =
        (widget.optionE != '' || widget.optionE != 'string') ? false : true;
    selectedCorrectAnswer = (optioncontroller1.text == widget.correctAns)
        ? 'a'
        : (optioncontroller2.text == widget.correctAns)
            ? 'b'
            : (optioncontroller3.text == widget.correctAns)
                ? 'c'
                : (optioncontroller4.text == widget.correctAns)
                    ? 'd'
                    : (optioncontroller5.text == widget.correctAns)
                        ? 'e'
                        : '';
    print('showAddOptionButton :: ${showAddOptionButton}');
    print('selectedCorrectAnswer :: ${selectedCorrectAnswer}');
    super.initState();
  }

  void addOptionE() {
    setState(() {
      showAddOptionButton = false;
    });
  }

  String? _fileName;

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpeg', 'jpg', 'png', 'svg'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      print('Picked file: ${file.name}');
      setState(() {
        _fileName = file.name;
      });
    } else {
      print('No file picked.');
    }
  }

  ///pick cover image
  Uint8List? _fileBytesImageCover;
  String? _fileNameImageCover;
  RxString uploadUrlImageCover = ''.obs;
  RxString uploadUrlImageUrlCover = ''.obs;
  RxString uploadUrlImageUrlEditCover = ''.obs;

  RxString selectUrlImageCover = ''.obs;

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      // Handle the picked video file
      // setState(() {
      _fileBytesImageCover = result.files.single.bytes;
      _fileNameImageCover = result.files.single.name;
      selectUrlImageCover("$_fileNameImageCover");
      uploadUrlImageCover.value = _fileNameImageCover!;
      // });
    } else {
      // Handle no video picked
      print('No video selected.');
      _fileBytesImageCover = null;
      _fileNameImageCover = '';
      selectUrlImageCover("$_fileNameImageCover");
      uploadUrlImageCover.value = _fileNameImageCover!;
      return;
    }
  }

  Future<void> uploadImage() async {
    if (_fileBytesImageCover == null) {
      return;
    }
    // isLoading(true);
    final url = Uri.parse(DatabaseApi.uploadDocument);

    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(
        http.MultipartFile.fromBytes(
          'images',
          _fileBytesImageCover!,
          filename: _fileNameImageCover!,
        ),
      );
      customPrint("BITES ${_fileBytesImageCover!.buffer.lengthInBytes}");
      // isLoading(true);
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        final jsonData = json.decode(responseBody);
        uploadUrlImageCover('');
        uploadUrlImageCover(jsonData['image_urls']
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll("{", '')
            .replaceAll("}", '')
            .replaceAll("url:", '')
            .replaceAll(" /", ''));
        // isLoading(false);
        customPrint('images uploaded successfully!  ${responseBody}');
        customPrint(
            'images uploaded successfully  ${uploadUrlImageCover.value}');
        // isLoading(false);
        showSuccessSnackBar('icons/check.svg', 'File uploaded successfully!');
      } else {
        customPrint(
            'Failed to upload file. Status code: ${response.statusCode}');
      }
    } catch (e) {
      customPrint('Error uploading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: Container(
            width: MediaQuery.of(context).size.width / 3.5,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          // dialogOpen.value = false;
                        });
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                Center(
                  child: Text(
                    widget.isAddQue ? 'Add Question' : 'Edit Question',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: textDark,
                    ),
                  ),
                ),
                const SizedBox(
                  height: constants.defaultPadding,
                ),
                Text(
                  'Question',
                  style:
                      AppTextStyle.normalRegular14.copyWith(color: labelColor),
                ),
                0.5.ph,
                TextFeildStyle(
                  hintText:
                      'According to the "Debit the Receiver, Credit the Giver" rule, which of the following accounts is debited ',
                  onChanged: (p0) {},
                  controller: _questioncontroller,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: greyborder),
                  ),
                  hintStyle:
                      AppTextStyle.normalRegular10.copyWith(color: hintText),
                  border: InputBorder.none,
                ),
                3.ph,

                // Container(
                //   margin: const EdgeInsets.symmetric(vertical: 28),
                //   decoration: BoxDecoration(
                //     color: containerBack,
                //     borderRadius: BorderRadius.circular(12),
                //     border: Border.all(color: arrow),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                //     child: InkWell(
                //       onTap: () async {
                //         await pickImage().then(
                //           (value) async {
                //             await uploadImage().then(
                //               (value) {},
                //             );
                //           },
                //         );
                //       },
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           SvgPicture.asset(
                //             'icons/add.svg',
                //             color: primaryColor,
                //           ),
                //           Text(
                //             'Click to upload\nquestion image',
                //             style: AppTextStyle.normalRegular15
                //                 .copyWith(color: labelColor),
                //           ),
                //           if (_fileName != null) ...[
                //             SizedBox(height: 10),
                //             Text(
                //               'Selected file: $_fileName',
                //               // style: widget.textStyle.copyWith(color: Colors.green),
                //             ),
                //           ],
                //         ],
                //       ),
                //     ),
                //   ),
                // ),

                Text(
                  'Option A',
                  style:
                      AppTextStyle.normalRegular14.copyWith(color: labelColor),
                ),
                0.5.ph,
                TextFeildStyle(
                  hintText: 'a) ${widget.optionA}',
                  onChanged: (p0) {},
                  controller: optioncontroller1,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: greyborder),
                  ),
                  hintStyle:
                      AppTextStyle.normalRegular10.copyWith(color: hintText),
                  border: InputBorder.none,
                ),
                1.5.ph,
                Text(
                  'Option B',
                  style:
                      AppTextStyle.normalRegular14.copyWith(color: labelColor),
                ),
                0.5.ph,
                TextFeildStyle(
                  hintText: 'b) ${widget.optionA}',
                  onChanged: (p0) {},
                  controller: optioncontroller2,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: greyborder),
                  ),
                  hintStyle:
                      AppTextStyle.normalRegular10.copyWith(color: hintText),
                  border: InputBorder.none,
                ),
                1.5.ph,
                Text(
                  'Option C',
                  style:
                      AppTextStyle.normalRegular14.copyWith(color: labelColor),
                ),
                0.5.ph,
                TextFeildStyle(
                  hintText: 'c) ${widget.optionC}',
                  onChanged: (p0) {},
                  controller: optioncontroller3,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: greyborder),
                  ),
                  hintStyle:
                      AppTextStyle.normalRegular10.copyWith(color: hintText),
                  border: InputBorder.none,
                ),
                1.5.ph,
                Text(
                  'Option D',
                  style:
                      AppTextStyle.normalRegular14.copyWith(color: labelColor),
                ),
                0.5.ph,
                TextFeildStyle(
                  hintText: 'd) ${widget.optionD}',
                  onChanged: (p0) {},
                  controller: optioncontroller4,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: greyborder),
                  ),
                  hintStyle:
                      AppTextStyle.normalRegular10.copyWith(color: hintText),
                  border: InputBorder.none,
                ),
                1.5.ph,
                Visibility(
                  visible: showAddOptionButton,
                  child: OutlineButton(
                    textSize: 14,
                    text: '+ Add Option',
                    width: 200,
                    onPressed: () {
                      addOptionE();
                    },
                  ),
                ),
                // if (!showAddOptionButton)
                //   Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         'Option E',
                //         style: AppTextStyle.normalRegular14
                //             .copyWith(color: labelColor),
                //       ),
                //       0.5.ph,
                //       TextFeildStyle(
                //         hintText: widget.optionE,
                //         onChanged: (p0) {},
                //         controller: optioncontroller5,
                //         height: 50,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(100),
                //           border: Border.all(color: greyborder),
                //         ),
                //         hintStyle: AppTextStyle.normalRegular10
                //             .copyWith(color: hintText),
                //         border: InputBorder.none,
                //       ),
                //     ],
                //   ),
                1.5.ph,
                // Text(
                //   'Explanation',
                //   style:
                //       AppTextStyle.normalRegular14.copyWith(color: labelColor),
                // ),
                CustomInfoField(
                  // maxCharacters: 400,
                  // maxLength: 400,
                  counter: true,
                  maxLines: 5,
                  controller:explanationcontroller,
                  hint:widget.explanation,
                  label: 'Explanation',
                ),
                Text(
                  'Correct Answer',
                  style:
                      AppTextStyle.normalRegular14.copyWith(color: labelColor),
                ),
                0.5.ph,
                Wrap(
                  direction: Axis.horizontal,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomRadioListTile(
                            title: ' A',
                            value: 'a',
                            groupValue: selectedCorrectAnswer,
                            onChanged: (value) {
                              setState(() {
                                if (optioncontroller1.text.isNotEmpty) {
                                  selectedCorrectAnswer = value;
                                  print(
                                      "selectedCorrectAnswer :: $selectedCorrectAnswer");
                                }
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomRadioListTile(
                            title: ' B',
                            value: 'b',
                            groupValue: selectedCorrectAnswer,
                            onChanged: (value) {
                              setState(() {
                                if (optioncontroller2.text.isNotEmpty) {
                                  selectedCorrectAnswer = value;
                                  print(
                                      "selectedCorrectAnswer :: $selectedCorrectAnswer");
                                }
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomRadioListTile(
                            title: ' C',
                            value: 'c',
                            groupValue: selectedCorrectAnswer,
                            onChanged: (value) {
                              setState(() {
                                if (optioncontroller3.text.isNotEmpty) {
                                  selectedCorrectAnswer = value;
                                  print(
                                      "selectedCorrectAnswer :: $selectedCorrectAnswer");
                                }
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomRadioListTile(
                            title: ' D',
                            value: 'd',
                            groupValue: selectedCorrectAnswer,
                            onChanged: (value) {
                              setState(() {
                                if (optioncontroller4.text.isNotEmpty) {
                                  selectedCorrectAnswer = value;
                                  print(
                                      "selectedCorrectAnswer :: $selectedCorrectAnswer");
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: CustomRadioListTile(
                    //         title: ' D',
                    //         value: 'd',
                    //         groupValue: selectedCorrectAnswer,
                    //         onChanged: (value) {
                    //           setState(() {
                    //             if (optioncontroller4.text.isNotEmpty) {
                    //               selectedCorrectAnswer = value;
                    //               print(
                    //                   "selectedCorrectAnswer :: $selectedCorrectAnswer");
                    //             }
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //     if (!showAddOptionButton)
                    //       Expanded(
                    //         child: CustomRadioListTile(
                    //           title: ' E',
                    //           value: 'e',
                    //           groupValue: selectedCorrectAnswer,
                    //           onChanged: (value) {
                    //             setState(() {
                    //               if (optioncontroller5.text.isNotEmpty) {
                    //                 selectedCorrectAnswer = value;
                    //                 print(
                    //                     "selectedCorrectAnswer :: $selectedCorrectAnswer");
                    //               }
                    //             });
                    //           },
                    //         ),
                    //       ),
                    //   ],
                    // ),
                  ],
                ),

                2.ph,
                widget.isAddQue
                    ? CustomButton(
                        text: 'Add',
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            // dialogOpen.value = false;
                          });
                        },
                      )
                    : CustomButton(
                        text: 'Update',
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() async {
                            bool success = await ActivitiesController
                                .updateActivityDetailsById(
                                    context,
                                    {
                                      "activity_id": widget.examId,
                                      "sr_no": widget.srNo,
                                      "question":
                                          ActivitiesController.encodeApiString(
                                              inputString:
                                                  _questioncontroller.text),
                                      // "question_image": OtherExamApi
                                      //     .imagesUrl.isNotEmpty
                                      //     ? OtherExamApi.imagesUrl[0]
                                      //     : '',
                                      "option_a":
                                          ActivitiesController.encodeApiString(
                                              inputString:
                                                  optioncontroller1.text),
                                      "option_b":
                                          ActivitiesController.encodeApiString(
                                              inputString:
                                                  optioncontroller2.text),
                                      "option_c":
                                          ActivitiesController.encodeApiString(
                                              inputString:
                                                  optioncontroller3.text),
                                      "option_d":
                                          ActivitiesController.encodeApiString(
                                              inputString:
                                                  optioncontroller4.text),
                                      // "option_e": widget.optionE,
                                      // "option_f": "",
                                      "explation":
                                          ActivitiesController.encodeApiString(
                                              inputString:
                                                  explanationcontroller.text),
                                      "correct_answer": (selectedCorrectAnswer ==
                                              'a')
                                          ? ActivitiesController
                                              .encodeApiString(
                                                  inputString:
                                                      optioncontroller1.text)
                                          : (selectedCorrectAnswer == 'b')
                                              ? ActivitiesController
                                                  .encodeApiString(
                                                      inputString:
                                                          optioncontroller2
                                                              .text)
                                              : (selectedCorrectAnswer == 'c')
                                                  ? ActivitiesController
                                                      .encodeApiString(
                                                          inputString:
                                                              optioncontroller3
                                                                  .text)
                                                  : (selectedCorrectAnswer ==
                                                          'd')
                                                      ? ActivitiesController
                                                          .encodeApiString(
                                                              inputString:
                                                                  optioncontroller4
                                                                      .text)
                                                      : '',
                                      if (uploadUrlImageCover.isNotEmpty)
                                        "image": uploadUrlImageCover.value
                                    },
                                    widget.examDetailId);
                            if (success) {
                              await ActivitiesController
                                  .getActivityByActivityId(widget.examId);
                              // showSuccessSnackBar(
                              //     '', "Question Image uploaded successfully");

                              Navigator.pop(context);
                              setState(() {
                                // _isAdding = false;
                                // OtherExamApi.imagesUrl.clear();
                              });
                            }
                            // dialogOpen.value = false;
                          });
                        },
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
