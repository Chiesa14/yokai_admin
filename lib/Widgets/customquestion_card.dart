import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yokai_admin/Widgets/imageButton.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/const.dart';
import 'package:yokai_admin/utils/text_styles.dart';

import '../api/database.dart';
import '../globalVariable.dart';
import '../screens/activities/Controller/activities_Controller.dart';

class CustomQuestionCard extends StatefulWidget {
  final String question;
  final List<String> options;
  final List<String> icons;
  final List<void Function()> onPressedActions;
  final String imagePath;
  final String correctAnswer;
  final String explanation;
  final String examDetailId;
  final String examId;
  final String srNo;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String optionE;

  const CustomQuestionCard({
    super.key,
    required this.question,
    this.imagePath = '',
    this.correctAnswer = '',
    this.optionA = '',
    this.optionB = '',
    this.optionC = '',
    this.optionD = '',
    this.optionE = '',
    required this.options,
    required this.icons,
    required this.onPressedActions,
    required this.explanation,
    required this.examDetailId,
    required this.examId,
    required this.srNo,
  });

  @override
  _CustomQuestionCardState createState() => _CustomQuestionCardState();
}

class _CustomQuestionCardState extends State<CustomQuestionCard> {
  String? selectedOption;
  String? imagePath;
  // List<String> selectedOptionList = [];
  @override
  void initState() {
    super.initState();
    // selectedOptionList = List.generate(widget.question.length, (index) => '');
    // updateSelectedOption();
    print("imagepath :: ${widget.imagePath}");
    imagePath = widget.imagePath;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Color(0xffF1F8FA), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = constraints.maxWidth;
            final isDesktop = cardWidth > 600;
            final maxRadioWidth = isDesktop ? 282.0 : cardWidth - 424.0;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.question,
                        style: AppTextStyle.regularBold
                            .copyWith(fontWeight: FontWeight.w400),
                      ),

                      // Column(
                      //   children: List.generate(
                      //       (widget.options.length + 1) ~/ 2, (index) {
                      //     return Row(
                      //       children: List.generate(2, (idx) {
                      //         int currentIndex = index * 2 + idx;
                      //         if (currentIndex < widget.options.length) {
                      //           final isSelected = selectedOption ==
                      //               widget.options[currentIndex];
                      //           final isCorrectAnswer =
                      //               widget.correctAnswer.trim() ==
                      //                   widget.options[currentIndex]
                      //                       .replaceFirst(
                      //                           RegExp(r'^[a-d]\)\s*'), '')
                      //                       .trim();
                      //           return Padding(
                      //             padding: EdgeInsets.only(
                      //               top: 8.0,
                      //               bottom: 8.0,
                      //               left: 8.0,
                      //               right: idx == 0 ? maxRadioWidth : 16.0,
                      //             ),
                      //             child: GestureDetector(
                      //               onTap: () {
                      //                 setState(() {
                      //                   selectedOption =
                      //                       widget.options[currentIndex];
                      //                 });
                      //               },
                      //               child: Container(
                      //                 width: isDesktop ? 300.0 : cardWidth - 40,
                      //                 // height:
                      //                 //     widget.options[currentIndex].length >
                      //                 //             35
                      //                 //         ? 60.0
                      //                 //         : 40.0,
                      //                 decoration: BoxDecoration(
                      //                   color: isSelected
                      //                       ? Color(0xffA7F3D0)
                      //                       : isCorrectAnswer
                      //                           ? Color(0xffA7F3D0)
                      //                           : Color(0xffF1F8FA),
                      //                   borderRadius:
                      //                       BorderRadius.circular(12.0),
                      //                   border: Border.all(
                      //                     color: isSelected
                      //                         ? Color(0xff10B981)
                      //                         : isCorrectAnswer
                      //                             ? Color(0xff10B981)
                      //                             : Color(0xffCCD4D5),
                      //                   ),
                      //                 ),
                      //                 child: RadioListTile(
                      //                   title: Padding(
                      //                     padding: const EdgeInsets.all(8.0),
                      //                     child: Text(
                      //                       widget.options[currentIndex],
                      //                       style: AppTextStyle.regularBold
                      //                           .copyWith(
                      //                         fontWeight: isSelected
                      //                             ? FontWeight.bold
                      //                             : isCorrectAnswer
                      //                                 ? FontWeight.bold
                      //                                 : FontWeight.w400,
                      //                         color: textDark,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                   value: widget.options[currentIndex],
                      //                   groupValue: isCorrectAnswer
                      //                       ? widget.options[currentIndex]
                      //                       : selectedOption,
                      //                   onChanged: (value) {
                      //                     // setState(() {
                      //                     //   selectedOption = value;
                      //                     //   selectedOptionList?.insert(
                      //                     //     currentIndex,
                      //                     //     selectedOption ?? '',
                      //                     //   );
                      //                     //   print("selectedOptionList :: $selectedOptionList");
                      //                     //   // print("selectedOption :: $selectedOption");
                      //                     // });
                      //                   },
                      //                   activeColor: primaryColor,
                      //                   controlAffinity:
                      //                       ListTileControlAffinity.trailing,
                      //                   contentPadding: EdgeInsets.zero,
                      //                   dense: true,
                      //                   selected: isSelected,
                      //                 ),
                      //               ),
                      //             ),
                      //           );
                      //         } else {
                      //           return SizedBox();
                      //         }
                      //       }),
                      //     );
                      //   }),
                      // ),
                      Column(
                        children: [
                          Column(
                            children: List.generate(
                                (widget.options.length + 1) ~/ 2, (index) {
                              return Row(
                                children: List.generate(2, (idx) {
                                  int currentIndex = index * 2 + idx;
                                  if (currentIndex < 4) {
                                    // Only generate options for index 0 to 3
                                    if (currentIndex < widget.options.length) {
                                      final isSelected = selectedOption ==
                                          widget.options[currentIndex];
                                      final isCorrectAnswer = widget
                                              .correctAnswer
                                              .trim() ==
                                          widget.options[currentIndex]
                                              .replaceFirst(
                                                  RegExp(r'^[a-d]\)\s*'), '')
                                              .trim();
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          top: 8.0,
                                          bottom: 8.0,
                                          left: 8.0,
                                          right:
                                              idx == 0 ? maxRadioWidth : 16.0,
                                          // right: MediaQuery.of(context).size.width*0.05
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedOption =
                                                  widget.options[currentIndex];
                                            });
                                          },
                                          child: Container(
                                            width: isDesktop
                                                ? 300.0
                                                : cardWidth - 40,
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? Color(0xffA7F3D0)
                                                  : isCorrectAnswer
                                                      ? Color(0xffA7F3D0)
                                                      : Color(0xffF1F8FA),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              border: Border.all(
                                                color: isSelected
                                                    ? Color(0xff10B981)
                                                    : isCorrectAnswer
                                                        ? Color(0xff10B981)
                                                        : Color(0xffCCD4D5),
                                              ),
                                            ),
                                            child: RadioListTile(
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  widget.options[currentIndex],
                                                  style: AppTextStyle
                                                      .regularBold
                                                      .copyWith(
                                                    fontWeight: isSelected
                                                        ? FontWeight.bold
                                                        : isCorrectAnswer
                                                            ? FontWeight.bold
                                                            : FontWeight.w400,
                                                    color: textDark,
                                                  ),
                                                ),
                                              ),
                                              value:
                                                  widget.options[currentIndex],
                                              groupValue: isCorrectAnswer
                                                  ? widget.options[currentIndex]
                                                  : selectedOption,
                                              onChanged: (value) {},
                                              activeColor: primaryColor,
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .trailing,
                                              contentPadding: EdgeInsets.zero,
                                              dense: true,
                                              selected: isSelected,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  } else {
                                    return SizedBox(); // Ignore options beyond the first four
                                  }
                                }),
                              );
                            }),
                          ),
                          SizedBox(height: isDesktop ? 16.0 : 12.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Explanation:',
                                      style: AppTextStyle.normalSemiBold14
                                          .copyWith(color: labelColor),
                                    ),
                                    Text(
                                      widget.explanation,
                                      style: AppTextStyle.normalRegular14
                                          .copyWith(color: hintColor),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: isDesktop ? 16.0 : 12.0),
                              (widget.imagePath.isNotEmpty &&
                                      widget.imagePath !=
                                          'https://yokai.anantkaal.com/' &&
                                      // widget.imagePath !=
                                      //     'https://api.clickonlineacademy.ac.tznull' &&
                                      !widget.imagePath.contains('null'))
                                  ? GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              child: Image.network(
                                                '${widget.imagePath}',
                                                fit: BoxFit.contain,
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        height: 130,
                                        width: 230,
                                        decoration: BoxDecoration(
                                            // color: AppColors.black,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Image.network(
                                                widget.imagePath,
                                                height: double.infinity,
                                                width: double.infinity,
                                                fit: BoxFit.fill,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(2),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      // imagePath='';
                                                      setState(() async {
                                                        bool success = await ActivitiesController.updateActivityDetailsById(
                                                            context,
                                                            {
                                                              "activity_id": widget.examId,
                                                              "sr_no": widget.srNo,
                                                                      "question":
                                                                          ActivitiesController.encodeApiString(
                                                                              inputString: widget.question),
                                                                      "option_a":
                                                                          ActivitiesController.encodeApiString(
                                                                              inputString: widget.optionA),
                                                                      "option_b":
                                                                          ActivitiesController.encodeApiString(
                                                                              inputString: widget.optionB),
                                                                      "option_c":
                                                                          ActivitiesController.encodeApiString(
                                                                              inputString: widget.optionC),
                                                                      "option_d":
                                                                          ActivitiesController.encodeApiString(
                                                                              inputString: widget.optionD),
                                                                      // if (uploadUrlImageCover.isNotEmpty)
                                                                "image": ''
                                                            },
                                                            widget.examDetailId);
                                                        if (success) {
                                                          await ActivitiesController.getActivityByActivityId(widget.examId);
                                                        }
                                                      });
                                                    },
                                                    child: SvgPicture.asset(
                                                        'icons/deleteNew.svg')),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Column(
                                    children: [
                                      Container(
                                          // margin: const EdgeInsets.symmetric(
                                          //     vertical: 28),
                                          decoration: BoxDecoration(
                                            color: containerBack,
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(color: arrow),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 50, vertical: 30),
                                            child: InkWell(
                                              onTap: () async {
                                                await pickImage().then(
                                                  (value) async {
                                                    await uploadImage().then(
                                                      (value) {},
                                                    );
                                                  },
                                                );
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    'icons/add.svg',
                                                    color: primaryColor,
                                                  ),
                                                  Text(
                                                    'Click to upload\nquestion image',
                                                    style: AppTextStyle
                                                        .normalRegular15
                                                        .copyWith(
                                                            color: labelColor),
                                                  ),
                                                  if (_fileName != null) ...[
                                                    SizedBox(height: 10),
                                                    Text(
                                                      'Selected file: $_fileName',
                                                      // style: widget.textStyle.copyWith(color: Colors.green),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      0.5.ph,
                                      Text(
                                        'Square Image\n(Recommended size 720×400)',
                                        //textStyle.labelStyle,
                                        style: textStyle.labelStyle.copyWith(
                                            color: bordercolor,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                            ],
                          ),
                        ],
                      )

                    ],
                  ),
                ),
                SizedBox(width: isDesktop ? 16.0 : 8.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(widget.icons.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ImageButton(
                        imagePath: widget.icons[index],
                        onPressed: widget.onPressedActions[index],
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String? _fileName;

  ///pick cover image
  Uint8List? _fileBytesImageCover;
  String? _fileNameImageCover;
  RxString uploadUrlImageCover = ''.obs;
  RxString uploadUrlImageUrlCover = ''.obs;
  RxString uploadUrlImageUrlEditCover = ''.obs;

  //
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
        setState(() async {
          bool success = await ActivitiesController.updateActivityDetailsById(
              context,
              {
                "activity_id": widget.examId,
                "sr_no": widget.srNo,
                "question": ActivitiesController.encodeApiString(
                    inputString: widget.question),
                // "question_image": OtherExamApi
                //     .imagesUrl.isNotEmpty
                //     ? OtherExamApi.imagesUrl[0]
                //     : '',
                "option_a": ActivitiesController.encodeApiString(
                    inputString: widget.optionA),
                "option_b": ActivitiesController.encodeApiString(
                    inputString: widget.optionB),
                "option_c": ActivitiesController.encodeApiString(
                    inputString: widget.optionC),
                "option_d": ActivitiesController.encodeApiString(
                    inputString: widget.optionD),
                if (uploadUrlImageCover.isNotEmpty)
                  "image": uploadUrlImageCover.value
              },
              widget.examDetailId);
          if (success) {
            await ActivitiesController.getActivityByActivityId(widget.examId);
            // showSuccessSnackBar(
            //     '', "Question Image uploaded successfully");

            // Navigator.pop(context);
            // setState(() {
            // _isAdding = false;
            // OtherExamApi.imagesUrl.clear();
            // });
          }
          // dialogOpen.value = false;
        });
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
}
