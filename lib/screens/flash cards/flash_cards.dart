import 'dart:typed_data';

import 'package:yokai_admin/Widgets/customTable.dart';
import 'package:yokai_admin/Widgets/deleteDialog.dart';
import 'package:yokai_admin/Widgets/imageButton.dart';
import 'package:yokai_admin/Widgets/my_dropdown.dart';
import 'package:yokai_admin/Widgets/new_button.dart';
import 'package:yokai_admin/Widgets/outline_button.dart';
import 'package:yokai_admin/Widgets/progressHud.dart';
import 'package:yokai_admin/Widgets/searchbar.dart';
import 'package:yokai_admin/Widgets/textfield.dart';
import 'package:yokai_admin/api/global_api.dart';
import 'package:yokai_admin/api/local_storage.dart';
import 'package:yokai_admin/main.dart';
// import 'package:yokai_admin/models/getflashcarddetailsbyid.dart';
// import 'package:yokai_admin/screens/dashboard/subject/subject_api.dart';
import 'package:yokai_admin/screens/flash%20cards/widget/createcollection.dart';
import 'package:yokai_admin/screens/flash%20cards/widget/editflashcard.dart';
import 'package:yokai_admin/screens/flash%20cards/widget/question_answer.dart';
import 'package:yokai_admin/screens/flash%20cards/Flashcard%20API/flashcard_api.dart';
//lib/screens/flash cards/Flashcard API/flashcard_api.dart
import 'package:yokai_admin/globalVariable.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/const.dart';
import 'package:yokai_admin/utils/text_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yokai_admin/utils/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FlashCardScreen extends StatefulWidget {
  const FlashCardScreen({Key? key, required this.scaffold}) : super(key: key);

  @override
  _FlashCardScreenState createState() => _FlashCardScreenState();
  final GlobalKey<ScaffoldState> scaffold;
}

class _FlashCardScreenState extends State<FlashCardScreen> {
  int flashcard = 1;
  // String selectedCreatedby = "Select";
  // String selectedSubject = "Select";
  String selectedGrade = "Select";
  // List<Datum> flashcardDetailsList = [];/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initialLoading();
    // fetchData();
    // SubjectApi.showAllSubjectsByStandard(context, selectedGrade);
  }

  // Future<void> fetchData() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   bool success =
  //       await FlashcardApi.getflashcarddetailsbyid(context, flashcardId);

  //   if (success) {
  //     setState(() {
  //       flashcardDetailsList =
  //           FlashcardApi.getFlashcardDetailsById.value.data ?? [];
  //       _isLoading = false;
  //     });
  //   } else {
  //     setState(() {
  //       flashcardDetailsList = [];

  //       _isLoading = false;
  //     });
  //   }
  // }

  // bool _isLoading = false;
  // Future<void> initialLoading() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   await FlashcardApi.getallflashcard(context);
  //   setState(() {
  //     _isLoading = false;
  //   });
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

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // body: Padding(
      //   padding: EdgeInsets.symmetric(
      //     horizontal: 20,
      //     // vertical: 15,
      //   ),
      //   child: Obx(() {
      //     return ProgressHUD(
      //       isLoading: _isLoading,
      //       child: SingleChildScrollView(
      //         child: Container(
      //             color: Colors.white,
      //             // margin: EdgeInsets.all(Responsive.isMobile(context)
      //             //     ? constants.defaultPadding
      //             //     : constants.defaultPadding * 2),
      //             child: FlashcardApi.flashcardRoute.value == '0'
      //                 ? flashcardHome(context)
      //                 : flashcardDetails(context)),
      //       ),
      //     );
      //   }),
      // ),
    );
  }

  // Widget flashcardDetails(BuildContext context) {
  //   return SingleChildScrollView(
  //     child: (flashcardDetailsList == null || flashcardDetailsList.isEmpty)
  //         ? Center(
  //             child: CircularProgressIndicator(
  //             color: primaryColor,
  //           ))
  //         : Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     flex: 7,
  //                     child: Row(
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: [
  //                         SizedBox(
  //                           height: 30,
  //                           child: ImageButton(
  //                             imagePath: 'icons/backbutton.png',
  //                             onPressed: () {
  //                               setState(() {
  //                                 FlashcardApi.flashcardRoute('0');
  //                               });
  //                             },
  //                           ),
  //                         ),
  //                         5.pw,
  //                         Text(
  //                           'Flash Cards - Cards',
  //                           style: AppTextStyle.normalBold28
  //                               .copyWith(color: primaryColor),
  //                         ),
  //                         2.pw,
  //                         Image.asset('icons/edit_name_icon.png')
  //                       ],
  //                     ),
  //                   ),
  //                   Expanded(
  //                     flex: 2,
  //                     child: CustomButton(
  //                       text: ' + Add Flash Cards ',
  //                       textSize: 14,
  //                       onPressed: () async {
  //                         editFlashcard(context, false);
  //                         await FlashcardApi.getflashcarddetailsbyid(
  //                             context, flashcardId);
  //                       },
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: constants.defaultPadding * 2),
  //               Text(
  //                 'Title : ${flashcardDetailsList[0].flashcard?.collectionName}',
  //                 style: AppTextStyle.normalRegular20
  //                     .copyWith(color: ironColor, fontWeight: FontWeight.w500),
  //               ),
  //               const SizedBox(height: constants.defaultPadding),
  //               Row(
  //                 children: [
  //                   Text(
  //                     'Subject : ${GlobalApi.getSubjectNameById(flashcardDetailsList[0].flashcard?.subjectId ?? '')}',
  //                     style: AppTextStyle.normalRegular16.copyWith(
  //                         color: ironColor, fontWeight: FontWeight.w500),
  //                   ),
  //                   20.pw,
  //                   Text(
  //                     'Standard : ${flashcardDetailsList[0].flashcard?.standard}',
  //                     style: AppTextStyle.normalRegular16.copyWith(
  //                         color: ironColor, fontWeight: FontWeight.w500),
  //                   ),
  //                   20.pw,
  //                   Text(
  //                     'Updated : ${DateFormat('dd-MM-yy').format(DateTime.parse(flashcardDetailsList[0].flashcard?.updatedAt.toString() ?? ''))}',
  //                     style: AppTextStyle.normalRegular16.copyWith(
  //                         color: ironColor, fontWeight: FontWeight.w500),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: constants.defaultPadding * 5),
  //               (flashcardDetailsList.isEmpty ||
  //                       flashcardDetailsList[0].flashcardDetails == null ||
  //                       flashcardDetailsList[0].flashcardDetails!.isEmpty)
  //                   ? Center(
  //                       child: Image.asset(
  //                         'images/no_flashcard.jpg',
  //                         height: 400,
  //                         width: 400,
  //                       ),
  //                     )
  //                   : Wrap(
  //                       children:
  //                           flashcardDetailsList.expand<Widget>((flashcard) {
  //                         return flashcard.flashcardDetails
  //                                 ?.map((flashcardDetail) {
  //                               return CustomQuestionAnswer(
  //                                 onTap: () {
  //                                   showDialog(
  //                                     context: context,
  //                                     builder: (BuildContext context) {
  //                                       print(
  //                                           "flashcard id editFlashcard :: ${flashcardId.toString()}");
  //                                       return EditFlashcardDialog(
  //                                         isEdit: true,
  //                                         flashcardId: flashcardId.toString(),
  //                                         answer: flashcardDetail.answer ?? "",
  //                                         question:
  //                                             flashcardDetail.question ?? "",
  //                                         questionImg:
  //                                             flashcardDetail.questionImage ??
  //                                                 "",
  //                                         ansImg:
  //                                             flashcardDetail.answerImage ?? "",
  //                                         refreshCallback: fetchData,
  //                                         srNo: flashcardDetail.srNo ?? "",
  //                                         flashcardDetailsId:
  //                                             flashcardDetail.id.toString(),
  //                                       );
  //                                     },
  //                                   );
  //                                 },
  //                                 question: flashcardDetail.question ?? "",
  //                                 answer: flashcardDetail.answer ?? "",
  //                                 queimagePath:
  //                                     flashcardDetail.questionImage ?? "",
  //                                 ansimagePath:
  //                                     flashcardDetail.answerImage ?? "",
  //                               );
  //                             }).toList() ??
  //                             [];
  //                       }).toList(),
  //                     ),
  //             ],
  //           ),
  //   );
  // }

  // List<Map<String, dynamic>> filteredFlashcard = [];
  // String selectedFilterSubject = "Select";
  // String selectedFilterGrade = "Select";
  // TextEditingController searchController = TextEditingController();
  // int flashcardId = 0;

  // Widget flashcardHome(BuildContext context) {
  //   if (searchController.text.isNotEmpty &&
  //       selectedFilterGrade == "Select" &&
  //       selectedFilterSubject == "Select") {
  //   } else if (searchController.text.isEmpty &&
  //       selectedFilterGrade != "Select" &&
  //       selectedFilterSubject == "Select") {
  //     FlashcardApi.searchFlash('', selectedFilterGrade, '').then((result) {
  //       setState(() {
  //         filteredFlashcard = result;
  //         print("filteredExams searchbar :: $filteredFlashcard");
  //       });
  //     });
  //   } else if (searchController.text.isEmpty &&
  //       selectedFilterGrade != "Select" &&
  //       selectedFilterSubject != "Select") {
  //     FlashcardApi.searchFlash(
  //             '', selectedFilterGrade, subjectWithId[selectedFilterSubject])
  //         .then((result) {
  //       setState(() {
  //         filteredFlashcard = result;
  //         print("filteredExams searchbar :: $filteredFlashcard");
  //       });
  //     });
  //   } else if (searchController.text.isNotEmpty &&
  //       selectedFilterGrade != "Select" &&
  //       selectedFilterSubject == "Select") {
  //     FlashcardApi.searchFlash(searchController.text, selectedFilterGrade, '')
  //         .then((result) {
  //       setState(() {
  //         filteredFlashcard = result;
  //         print("filteredExams searchbar :: $filteredFlashcard");
  //       });
  //     });
  //   } else if (searchController.text.isNotEmpty &&
  //       selectedFilterGrade != "Select" &&
  //       selectedFilterSubject != "Select") {
  //     FlashcardApi.searchFlash(searchController.text, selectedFilterGrade,
  //             subjectWithId[selectedFilterSubject])
  //         .then((result) {
  //       setState(() {
  //         filteredFlashcard = result;
  //         print("filteredExams searchbar :: $filteredFlashcard");
  //       });
  //     });
  //   } else {
  //     filteredFlashcard = FlashcardApi.flashcardList;
  //     print('filteredFlashcard all: $filteredFlashcard');
  //   }
  //   // else {
  //   // if (FinalexamApi.filteredDetails.isNotEmpty) {
  //   // filteredFlashcard = MicronotesApi.filteredDetails;
  //   // print('filteredFlashcard : $filteredFlashcard');
  //   // }
  //   // }
  //   // filteredFlashcard = FlashcardApi.flashcardList;

  //   print('filteredFlashcard :: $filteredFlashcard');
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         children: [
  //           Expanded(
  //             flex: 7,
  //             child: Text(
  //               'Flash Cards - Collections',
  //               style: AppTextStyle.normalBold28.copyWith(color: primaryColor),
  //             ),
  //           ),
  //           Expanded(
  //               flex: 2,
  //               child: CustomButton(
  //                   text: '  + Add Flash Card Collection  ',
  //                   textSize: 14,
  //                   onPressed: () {
  //                     showDialog(
  //                       context: context,
  //                       builder: (BuildContext context) {
  //                         return CreateCollection();
  //                       },
  //                     );
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
  //                       onChange: (value) {
  //                         setState(() {
  //                           selectedFilterGrade = value!;
  //                         });
  //                         _refreshData();
  //                       },
  //                       array: grade), // CustomInfoField(
  //                   //
  //                 ],
  //               )),
  //           5.pw,
  //           Expanded(
  //               flex: 1,
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
  //                         await SubjectApi.showAllSubjectsByStandard(
  //                             context, selectedFilterGrade);
  //                       },
  //                       array: subjects), // CustomInfoField(
  //                   //
  //                 ],
  //               )),
  //           5.pw,
  //           // Expanded(
  //           //     flex: 1,
  //           //     child: Column(
  //           //       crossAxisAlignment: CrossAxisAlignment.start,
  //           //       children: [
  //           //         Text(
  //           //           'Created By',
  //           //           style: AppTextStyle.normalRegular14
  //           //               .copyWith(color: labelColor),
  //           //         ),
  //           //         0.5.ph,
  //           //         MyDropDown(
  //           //             borderWidth: 1,
  //           //             defaultValue: selectedCreatedby,
  //           //             onChange: (value) {
  //           //               setState(() {
  //           //                 selectedCreatedby = value!;
  //           //               });
  //           //             },
  //           //             array: createdby),
  //           //         // CustomInfoField(
  //           //         //
  //           //       ],
  //           //     )),

  //           5.pw,
  //           Expanded(
  //             flex: 1,
  //             child: CustomSearchBar(
  //               hintText: 'Search Flash Cards by Name',
  //               controller: searchController,
  //               onTextChanged: (keyword) async {
  //                 await FlashcardApi.searchFlash(searchController.text, '', '')
  //                     .then((result) {
  //                   setState(() {
  //                     filteredFlashcard = result;
  //                     print("filteredExams searchbar :: $filteredFlashcard");
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
  //       filteredFlashcard.isEmpty
  //           ? Padding(
  //               padding: const EdgeInsets.all(30.0),
  //               child: Center(
  //                   child: Text(
  //                 "No flashcards available",
  //                 style: AppTextStyle.normalBold20
  //                     .copyWith(color: Colors.grey[400]),
  //               )),
  //             )
  //           : (filteredFlashcard.isEmpty &&
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
  //                     rows: filteredFlashcard.length,
  //                     columns: 4,
  //                     rowNames: List.generate(filteredFlashcard.length,
  //                         (index) => filteredFlashcard[index]['date'] ?? 'NA'),
  //                     columnNames: [
  //                       'Title',
  //                       'Created By',
  //                       'Test',
  //                       'Action',
  //                     ],
  //                     onTap: (int rowIndex) async {
  //                       setState(() {
  //                         FlashcardApi.flashcardRoute('2');
  //                         _isLoading = true;
  //                       });
  //                       print('Cell in row $rowIndex is tapped');
  //                       flashcardId = FlashcardApi.flashcardList[rowIndex]
  //                           ['flashcard_id'];
  //                       prefs!.setInt(LocalStorage.flashcardId, flashcardId);

  //                       print("flashcardId :: $flashcardId");
  //                       await fetchData();
  //                     },
  //                     firstColname: 'Date Created ',
  //                     initialValues: [
  //                       for (int i = 0; i < filteredFlashcard.length; i++)
  //                         [
  //                           filteredFlashcard[i]['title'],
  //                           'Admin',
  //                           'Yes',
  //                           Row(
  //                             mainAxisSize: MainAxisSize.min,
  //                             children: [
  //                               ImageButton(
  //                                 imagePath: 'icons/delete_icon.png',
  //                                 onPressed: () {
  //                                   deleteCard(context,
  //                                       filteredFlashcard[i]['flashcard_id']);
  //                                   print('button pressed');
  //                                 },
  //                               ),
  //                             ],
  //                           )
  //                         ],
  //                     ],
  //                   ),
  //                 ),
  //     ],
  //   );
  // }

  // void createCollection(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //     },
  //   );
  // }

  // void deleteCard(BuildContext context, int flashId) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return CustomDeleteWidget(
  //         title: 'Delete Collection ?',
  //         message:
  //             'All your saved flashcards will be lost and cannot be recovered once this collection is deleted.',
  //         onCancelPressed: () {
  //           Navigator.pop(context);
  //         },
  //         onConfirmPressed: () async {
  //           bool success = await FlashcardApi.deleteflashcard(context, flashId);
  //           if (success) {
  //             initialLoading();
  //             Navigator.pop(context);
  //           }
  //         },
  //       );
  //     },
  //   );
  // }

  // void editFlashcard(BuildContext context, bool isEdit) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       print("flashcard id editFlashcard :: ${flashcardId.toString()}");
  //       return EditFlashcardDialog(
  //         refreshCallback: fetchData,
  //         isEdit: isEdit,
  //         flashcardId: flashcardId.toString(),
  //       );
  //     },
  //   );
  // }
}
