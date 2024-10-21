import 'package:yokai_admin/Widgets/customTable.dart';
import 'package:yokai_admin/Widgets/customeditableTable.dart';
import 'package:yokai_admin/Widgets/deleteDialog.dart';
import 'package:yokai_admin/Widgets/editDialog.dart';
import 'package:yokai_admin/Widgets/filePicker.dart';
import 'package:yokai_admin/Widgets/imageButton.dart';
import 'package:yokai_admin/Widgets/my_dropdown.dart';
import 'package:yokai_admin/Widgets/searchbar.dart';
import 'package:yokai_admin/globalVariable.dart';
import 'package:yokai_admin/lesson%20plans/API/lessonplan_api.dart';

import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/const.dart';
import 'package:yokai_admin/Widgets/my_textfield.dart';
import 'package:yokai_admin/Widgets/new_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:yokai_admin/utils/constants.dart';
import '../../utils/text_styles.dart';

class LessonPlanScreen extends StatefulWidget {
  const LessonPlanScreen({Key? key, required this.scaffold}) : super(key: key);

  @override
  _LessonPlanScreenState createState() => _LessonPlanScreenState();
  final GlobalKey<ScaffoldState> scaffold;
}

class _LessonPlanScreenState extends State<LessonPlanScreen> {
  final TextEditingController _controller = TextEditingController();
  int _characterCount = 0;
  final int maxCharacterCount = 50;
  RxInt selected = 0.obs;
  @override
  void initState() {
    super.initState();
    // SubjectApi.showAllSubjectsByStandard(context, selectedGrade);
  }

  String selectedCreatedby = "Select";
  String selectedSubject = "Select";
  String selectedGrade = "Select";
  String selectedExamType = "Select";
  String? uploadedFileName;
  List<String> buttonTexts = ['Question Paper', 'Answer Key'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              // vertical: 15,
            ),
            child: Container(
                color: Colors.white,
                child: LessonPlanApi.lessonplanRoute.value == '0'
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: Text(
                                  'Lesson Plans / Schemes of Work',
                                  style: AppTextStyle.normalBold28
                                      .copyWith(color: primaryColor),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: CustomButton(
                                      text: '  + Add New Template  ',
                                      textSize: 14,
                                      onPressed: () {
                                        setState(() {
                                          LessonPlanApi.lessonplanRoute('2');
                                        });
                                        // createCollection(context);
                                      })),
                            ],
                          ),
                          const SizedBox(
                            height: constants.defaultPadding * 2,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Standard',
                                        style: AppTextStyle.normalRegular14
                                            .copyWith(color: labelColor),
                                      ),
                                      0.5.ph,
                                      MyDropDown(
                                          borderWidth: 1,
                                          defaultValue: selectedGrade,
                                          onChange: (value) {
                                            setState(() {
                                              selectedGrade = value!;
                                            });
                                          },
                                          array: grade), // CustomInfoField(
                                      //
                                    ],
                                  )),
                              5.pw,
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Subject',
                                        style: AppTextStyle.normalRegular14
                                            .copyWith(color: labelColor),
                                      ),
                                      0.5.ph,
                                      MyDropDown(
                                          borderWidth: 1,
                                          defaultValue: selectedSubject,
                                          onChange: (value) async {
                                            setState(() {
                                              selectedSubject = value!;
                                            });
                                            // await SubjectApi
                                            //     .showAllSubjectsByStandard(
                                            //         context, selectedGrade);
                                          },
                                          array: subjects), // CustomInfoField(
                                      //
                                    ],
                                  )),
                              5.pw,
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Type',
                                        style: AppTextStyle.normalRegular14
                                            .copyWith(color: labelColor),
                                      ),
                                      0.5.ph,
                                      MyDropDown(
                                          borderWidth: 1,
                                          defaultValue: selectedExamType,
                                          onChange: (value) {
                                            setState(() {
                                              selectedExamType = value!;
                                            });
                                          },
                                          array: [
                                            "Select",
                                            "Term Exam",
                                            "Final Exam"
                                          ]), // CustomInfoField(
                                      //
                                    ],
                                  )),
                              5.pw,
                              5.pw,
                              Expanded(
                                flex: 2,
                                child: CustomSearchBar(
                                  hintText: 'Search by Name',
                                  // controller: ,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: constants.defaultPadding * 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTable(
                              rows: 6,
                              columns: 2,
                              rowNames: [
                                '23-12-2024',
                                '23-12-2024',
                                '23-12-2024',
                                '23-12-2024',
                                '23-12-2024',
                                '23-12-2024',
                              ],
                              columnNames: [
                                'Title',
                                // 'Downloads',
                                'Action',
                              ],
                              onTap: (int rowIndex) {
                                setState(() {
                                  LessonPlanApi.lessonplanRoute('1');
                                });
                                print('Cell in row $rowIndex is tapped');
                              },
                              firstColname: 'Last Updated ',
                              initialValues: [
                                [
                                  ' Companies Accounting LAws',
                                  // '10',
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ImageButton(
                                        imagePath: 'icons/edit_icon.png',
                                        onPressed: () {
                                          // editCard(context);
                                          print('button pressed');
                                        },
                                      ),
                                      1.pw,
                                      ImageButton(
                                        imagePath: 'icons/delete_icon.png',
                                        onPressed: () {
                                          deleteExamCard(context);
                                          print('button pressed');
                                        },
                                      ),
                                    ],
                                  )
                                ],
                                [
                                  ' Companies Accounting LAws',
                                  // '10',
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ImageButton(
                                        imagePath: 'icons/edit_icon.png',
                                        onPressed: () {
                                          // editCard(context);
                                          print('button pressed');
                                        },
                                      ),
                                      1.pw,
                                      ImageButton(
                                        imagePath: 'icons/delete_icon.png',
                                        onPressed: () {
                                          deleteExamCard(context);
                                          print('button pressed');
                                        },
                                      ),
                                    ],
                                  )
                                ],
                                [
                                  ' Companies Accounting LAws',
                                  // '10',
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ImageButton(
                                        imagePath: 'icons/edit_icon.png',
                                        onPressed: () {
                                          // editCard(context);
                                          print('button pressed');
                                        },
                                      ),
                                      1.pw,
                                      ImageButton(
                                        imagePath: 'icons/delete_icon.png',
                                        onPressed: () {
                                          deleteExamCard(context);
                                          print('button pressed');
                                        },
                                      ),
                                    ],
                                  )
                                ],
                                [
                                  ' Companies Accounting LAws',
                                  // '10',
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ImageButton(
                                        imagePath: 'icons/edit_icon.png',
                                        onPressed: () {
                                          // editCard(context);
                                          print('button pressed');
                                        },
                                      ),
                                      1.pw,
                                      ImageButton(
                                        imagePath: 'icons/delete_icon.png',
                                        onPressed: () {
                                          deleteExamCard(context);
                                          print('button pressed');
                                        },
                                      ),
                                    ],
                                  )
                                ],
                                [
                                  ' Companies Accounting LAws',
                                  // '10',
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ImageButton(
                                        imagePath: 'icons/edit_icon.png',
                                        onPressed: () {
                                          // editCard(context);
                                          print('button pressed');
                                        },
                                      ),
                                      1.pw,
                                      ImageButton(
                                        imagePath: 'icons/delete_icon.png',
                                        onPressed: () {
                                          deleteExamCard(context);
                                          print('button pressed');
                                        },
                                      ),
                                    ],
                                  )
                                ],
                                [
                                  ' Companies Accounting LAws',
                                  // '10',
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ImageButton(
                                        imagePath: 'icons/edit_icon.png',
                                        onPressed: () {
                                          // editCard(context);
                                          print('button pressed');
                                        },
                                      ),
                                      1.pw,
                                      ImageButton(
                                        imagePath: 'icons/delete_icon.png',
                                        onPressed: () {
                                          deleteExamCard(context);
                                          print('button pressed');
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ],
                            ),
                          ),
                        ],
                      )
                    : LessonPlanApi.lessonplanRoute.value == '2'
                        ? AddOtherExam(context)
                        : description(context))),
      ),
    );
  }

  void deleteExamCard(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDeleteWidget(
          title: 'Delete ?',
          message:
              'All its’ details will be lost and students will not be able to see the exam on the app. ',
          onCancelPressed: () {
            Navigator.pop(context);
          },
          onConfirmPressed: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Widget AddOtherExam(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              SizedBox(
                height: 30,
                child: ImageButton(
                  imagePath: 'icons/backbutton.png',
                  onPressed: () {
                    setState(() {
                      LessonPlanApi.lessonplanRoute('0');
                      // FinalexamApi.finalexamRoute('0');
                      // Top.notesRoute('0');
                    });
                  },
                ),
              ),
              5.pw,
              Text(
                'Add Template',
                style: AppTextStyle.normalBold28.copyWith(color: primaryColor),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: constants.defaultPadding * 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Standard',
                      style: AppTextStyle.normalRegular14
                          .copyWith(color: labelColor),
                    ),
                    0.5.ph,
                    MyDropDown(
                        borderWidth: 1,
                        defaultValue: selectedGrade,
                        onChange: (value) {
                          setState(() {
                            selectedGrade = value!;
                          });
                        },
                        array: grade), // CustomInfoField(
                    //
                  ],
                )),
            5.pw,
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Type',
                      style: AppTextStyle.normalRegular14
                          .copyWith(color: labelColor),
                    ),
                    0.5.ph,
                    MyDropDown(
                        borderWidth: 1,
                        defaultValue: selectedExamType,
                        onChange: (value) {
                          setState(() {
                            selectedExamType = value!;
                          });
                        },
                        array: [
                          "Select",
                          "Term Exam",
                          "Final Exam"
                        ]), // CustomInfoField(
                    //
                  ],
                )),
            5.pw,
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Subject',
                      style: AppTextStyle.normalRegular14
                          .copyWith(color: labelColor),
                    ),
                    0.5.ph,
                    MyDropDown(
                        borderWidth: 1,
                        defaultValue: selectedSubject,
                        onChange: (value) {
                          setState(() {
                            selectedSubject = value!;
                          });
                        },
                        array: subjects), // CustomInfoField(
                    //
                  ],
                )),
          ],
        ),
        const SizedBox(
          height: constants.defaultPadding,
        ),
        CustomInfoField(
          label: 'Title*',
          controller: _controller,
          onChanged: (value) {
            setState(() {
              _characterCount = value.length;
            });
          },
          maxCharacters: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '$_characterCount / $maxCharacterCount', //textStyle.labelStyle,
              style: textStyle.labelStyle.copyWith(
                  color: _characterCount <= maxCharacterCount
                      ? textBlack
                      : Colors.red,
                  fontSize: 12),
            ),
          ],
        ),
        const SizedBox(
          height: constants.defaultPadding,
        ),
        // FileUploadWidget(
        //   title: 'Upload Template :',
        //   text: 'Click to browse',
        // ),
        const SizedBox(
          height: constants.defaultPadding * 3,
        ),
        Center(
            child: CustomButton(
          text: 'Add Template',
          onPressed: () {},
          width: MediaQuery.of(context).size.width / 5,
        )),
        const SizedBox(
          height: constants.defaultPadding / 2,
        ),
        Center(
          child: Text(
            'You can always edit your questions in the future',
            style: AppTextStyle.normalRegular14,
          ),
        ),
        10.ph
      ],
    );
  }

  Widget description(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 7,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 30,
                    child: ImageButton(
                      imagePath: 'icons/backbutton.png',
                      onPressed: () {
                        setState(() {
                          LessonPlanApi.lessonplanRoute('0');
                        });
                      },
                    ),
                  ),
                  5.pw,
                  Text(
                    'Exam Details',
                    style:
                        AppTextStyle.normalBold28.copyWith(color: primaryColor),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: CustomButton(
                iconSvgPath: 'icons/pdf.png',
                text: 'PDF ',
                textSize: 14,
                onPressed: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return EditDialog(
                  //       examType: "",
                  //       isTopicalexam: true,
                  //     );
                  //   },
                  // );

                  // editFlashcard(context);
                },
              ),
            ),
            1.pw,
            Expanded(
              flex: 2,
              child: CustomButton(
                text: ' Edit Template ',
                textSize: 14,
                onPressed: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return EditDialog(
                  //       examType: "",
                  //       isTopicalexam: true,
                  //     );
                  //   },
                  // );

                  // editFlashcard(context);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: constants.defaultPadding * 2),
        Text(
          'Title : Golden Rules of Accounting part 1 Introduction to basics',
          style: AppTextStyle.normalRegular20
              .copyWith(color: ironColor, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: constants.defaultPadding),
        Row(
          children: [
            Text(
              'Subject : Business Accounting Basics',
              style: AppTextStyle.normalRegular16
                  .copyWith(color: ironColor, fontWeight: FontWeight.w500),
            ),
            20.pw,
            Text(
              'Standard : Form 4 ',
              style: AppTextStyle.normalRegular16
                  .copyWith(color: ironColor, fontWeight: FontWeight.w500),
            ),
            20.pw,
            Text(
              'Updated : 29-07-2024',
              style: AppTextStyle.normalRegular16
                  .copyWith(color: ironColor, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        // const SizedBox(height: constants.defaultPadding * 5),
        const SizedBox(height: constants.defaultPadding * 4),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomEditableTable(
            rows: 8,
            columns: 13,
            rowNames: [for (int i = 1; i <= 8; i++) '$i'],
            columnNames: [
              'Competence',
              'Specific Objectives',
              'Month',
              'Week',
              'Periods',
              'Main Topic',
              'Sub Topic',
              'Teaching Activities',
              'Learning Activities ',
              'Learning Aids ',
              'Assessment',
              'References',
              'Remarks',
            ],
            onTap: (int rowIndex) {
              setState(() {
                LessonPlanApi.lessonplanRoute('1');
              });
              print('Cell in row $rowIndex is tapped');
            },
            firstColname: 'SR NO.',
            initialValues: [
              [
                '''The student should have ability to: Demonstrate good leadership in society''',
                '''The student should be able to:  1. Explain the importance of good leader ship, team work, positive relationship, self worth and confidence qualities.''',
                '2',
                '2',
                '2',
                '''k 2 PROMOTION OF LIFESKILLS''',
                '''Good leadership, team work, positive relationship s, self worth and confidence.''',
                '1. To use case studies to guide students to discuss in groups and explain the importance of each of the following: good leadership, team work, positive relationships, self worth and confidence.',
                'i) students to discuss in groups and explain the importance of each of the following: good leadership, team work, positive relationships, self worth and confidence.  ii) students in their groups to present their groups work for class discussion and clarification.  iii.students in groups to role play, discuss and present skills or qualities of:  o a good leader o teamwork o good relationship',
                'Readings from newspapers and magazines about leadership',
                'Are students able to explain the importance of :  o Good leadership o Teamwork o Positive relationships o Self worth o Confidence  Are students able to demonstrate : o good leadership o team work o positive relationships. o self worth o confidence?',
                'Civics For Secondary Schools, Students Book Form Three. By T.I.E',
                '--'
              ],
              [
                '''The student should have ability to: Demonstrate good leadership in society''',
                '''The student should be able to:  1. Explain the importance of good leader ship, team work, positive relationship, self worth and confidence qualities.''',
                '2',
                '2',
                '2',
                '''k 2 PROMOTION OF LIFESKILLS''',
                '''Good leadership, team work, positive relationship s, self worth and confidence.''',
                '1. To use case studies to guide students to discuss in groups and explain the importance of each of the following: good leadership, team work, positive relationships, self worth and confidence.',
                'i) students to discuss in groups and explain the importance of each of the following: good leadership, team work, positive relationships, self worth and confidence.  ii) students in their groups to present their groups work for class discussion and clarification.  iii.students in groups to role play, discuss and present skills or qualities of:  o a good leader o teamwork o good relationship',
                'Readings from newspapers and magazines about leadership',
                'Are students able to explain the importance of :  o Good leadership o Teamwork o Positive relationships o Self worth o Confidence  Are students able to demonstrate : o good leadership o team work o positive relationships. o self worth o confidence?',
                'Civics For Secondary Schools, Students Book Form Three. By T.I.E',
                '--'
              ],
              [
                '''The student should have ability to: Demonstrate good leadership in society''',
                '''The student should be able to:  1. Explain the importance of good leader ship, team work, positive relationship, self worth and confidence qualities.''',
                '2',
                '2',
                '2',
                '''k 2 PROMOTION OF LIFESKILLS''',
                '''Good leadership, team work, positive relationship s, self worth and confidence.''',
                '1. To use case studies to guide students to discuss in groups and explain the importance of each of the following: good leadership, team work, positive relationships, self worth and confidence.',
                'i) students to discuss in groups and explain the importance of each of the following: good leadership, team work, positive relationships, self worth and confidence.  ii) students in their groups to present their groups work for class discussion and clarification.  iii.students in groups to role play, discuss and present skills or qualities of:  o a good leader o teamwork o good relationship',
                'Readings from newspapers and magazines about leadership',
                'Are students able to explain the importance of :  o Good leadership o Teamwork o Positive relationships o Self worth o Confidence  Are students able to demonstrate : o good leadership o team work o positive relationships. o self worth o confidence?',
                'Civics For Secondary Schools, Students Book Form Three. By T.I.E',
                '--'
              ],
              [
                '''The student should have ability to: Demonstrate good leadership in society''',
                '''The student should be able to:  1. Explain the importance of good leader ship, team work, positive relationship, self worth and confidence qualities.''',
                '2',
                '2',
                '2',
                '''k 2 PROMOTION OF LIFESKILLS''',
                '''Good leadership, team work, positive relationship s, self worth and confidence.''',
                '1. To use case studies to guide students to discuss in groups and explain the importance of each of the following: good leadership, team work, positive relationships, self worth and confidence.',
                'i) students to discuss in groups and explain the importance of each of the following: good leadership, team work, positive relationships, self worth and confidence.  ii) students in their groups to present their groups work for class discussion and clarification.  iii.students in groups to role play, discuss and present skills or qualities of:  o a good leader o teamwork o good relationship',
                'Readings from newspapers and magazines about leadership',
                'Are students able to explain the importance of :  o Good leadership o Teamwork o Positive relationships o Self worth o Confidence  Are students able to demonstrate : o good leadership o team work o positive relationships. o self worth o confidence?',
                'Civics For Secondary Schools, Students Book Form Three. By T.I.E',
                '--'
              ],
              [
                '''The student should have ability to: Demonstrate good leadership in society''',
                '''The student should be able to:  1. Explain the importance of good leader ship, team work, positive relationship, self worth and confidence qualities.''',
                '2',
                '2',
                '2',
                '''k 2 PROMOTION OF LIFESKILLS''',
                '''Good leadership, team work, positive relationship s, self worth and confidence.''',
                '1. To use case studies to guide students to discuss in groups and explain the importance of each of the following: good leadership, team work, positive relationships, self worth and confidence.',
                'i) students to discuss in groups and explain the importance of each of the following: good leadership, team work, positive relationships, self worth and confidence.  ii) students in their groups to present their groups work for class discussion and clarification.  iii.students in groups to role play, discuss and present skills or qualities of:  o a good leader o teamwork o good relationship',
                'Readings from newspapers and magazines about leadership',
                'Are students able to explain the importance of :  o Good leadership o Teamwork o Positive relationships o Self worth o Confidence  Are students able to demonstrate : o good leadership o team work o positive relationships. o self worth o confidence?',
                'Civics For Secondary Schools, Students Book Form Three. By T.I.E',
                '--'
              ],
              [
                '''The student should have ability to: Demonstrate good leadership in society''',
                '''The student should be able to:  1. Explain the importance of good leader ship, team work, positive relationship, self worth and confidence qualities.''',
                '2',
                '2',
                '2',
                '''k 2 PROMOTION OF LIFESKILLS''',
                '''Good leadership, team work, positive relationship s, self worth and confidence.''',
                '1. To use case studies to guide students to discuss in groups and explain the importance of each of the following: good leadership, team work, positive relationships, self worth and confidence.',
                'i) students to discuss in groups and explain the importance of each of the following: good leadership, team work, positive relationships, self worth and confidence.  ii) students in their groups to present their groups work for class discussion and clarification.  iii.students in groups to role play, discuss and present skills or qualities of:  o a good leader o teamwork o good relationship',
                'Readings from newspapers and magazines about leadership',
                'Are students able to explain the importance of :  o Good leadership o Teamwork o Positive relationships o Self worth o Confidence  Are students able to demonstrate : o good leadership o team work o positive relationships. o self worth o confidence?',
                'Civics For Secondary Schools, Students Book Form Three. By T.I.E',
                '--'
              ],
              [
                '''The student should have ability to: Demonstrate good leadership in society''',
                '''The student should be able to:  1. Explain the importance of good leader ship, team work, positive relationship, self worth and confidence qualities.''',
                '2',
                '2',
                '2',
                '''k 2 PROMOTION OF LIFESKILLS''',
                '''Good leadership, team work, positive relationship s, self worth and confidence.''',
                '1. To use case studies to guide students to discuss in groups and explain the importance of each of the following: good leadership, team work, positive relationships, self worth and confidence.',
                'i) students to discuss in groups and explain the importance of each of the following: good leadership, team work, positive relationships, self worth and confidence.  ii) students in their groups to present their groups work for class discussion and clarification.  iii.students in groups to role play, discuss and present skills or qualities of:  o a good leader o teamwork o good relationship',
                'Readings from newspapers and magazines about leadership',
                'Are students able to explain the importance of :  o Good leadership o Teamwork o Positive relationships o Self worth o Confidence  Are students able to demonstrate : o good leadership o team work o positive relationships. o self worth o confidence?',
                'Civics For Secondary Schools, Students Book Form Three. By T.I.E',
                '--'
              ],
              [
                '''The student should have ability to: Demonstrate good leadership in society''',
                '''The student should be able to:  1. Explain the importance of good leader ship, team work, positive relationship, self worth and confidence qualities.''',
                '2',
                '2',
                '2',
                '''k 2 PROMOTION OF LIFESKILLS''',
                '''Good leadership, team work, positive relationship s, self worth and confidence.''',
                '1. To use case studies to guide students to discuss in groups and explain the importance of each of the following: good leadership, team work, positive relationships, self worth and confidence.',
                'i) students to discuss in groups and explain the importance of each of the following: good leadership, team work, positive relationships, self worth and confidence.  ii) students in their groups to present their groups work for class discussion and clarification.  iii.students in groups to role play, discuss and present skills or qualities of:  o a good leader o teamwork o good relationship',
                'Readings from newspapers and magazines about leadership',
                'Are students able to explain the importance of :  o Good leadership o Teamwork o Positive relationships o Self worth o Confidence  Are students able to demonstrate : o good leadership o team work o positive relationships. o self worth o confidence?',
                'Civics For Secondary Schools, Students Book Form Three. By T.I.E',
                '--'
              ],
            ],
          ),
        ),
      ],
    );
  }
}
