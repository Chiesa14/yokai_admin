import 'package:yokai_admin/Widgets/my_dropdown.dart';
import 'package:yokai_admin/Widgets/new_button.dart';
import 'package:yokai_admin/Widgets/textfield.dart';
import 'package:yokai_admin/globalVariable.dart';
// import 'package:yokai_admin/screens/dashboard/subject/subject_api.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/const.dart';
import 'package:yokai_admin/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yokai_admin/utils/constants.dart';

import '../Flashcard API/flashcard_api.dart';

class CreateCollection extends StatefulWidget {
  const CreateCollection({super.key});

  @override
  State<CreateCollection> createState() => _CreateCollectionState();
}

class _CreateCollectionState extends State<CreateCollection> {
  int flashcard = 1;
  String selectedCreatedby = "Select";
  String selectedSubject = "Select";
  String selectedGrade = "Select";
  TextEditingController _collectionNameController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initialLoading();
    // SubjectApi.showAllSubjectsByStandard(context, selectedGrade);
  }

  bool _isLoading = false;
  bool _isAdding = false;
  // Future<void> initialLoading() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   await FlashcardApi.getallflashcard(context);
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  // bool enableSubject = true;
  // void _refreshData() async {
  //   setState(() {
  //     _isLoading = true;
  //     enableSubject = false;
  //   });
  //   if (selectedGrade != "Select") {
  //     await SubjectApi.showAllSubjectsByStandard(context, selectedGrade);
  //   }
  //   await SubjectApi.showAllSubjects(context);

  //   // await MicronotesApi.getallmicronotes(context);

  //   setState(() {
  //     _isLoading = false;
  //     enableSubject = true;
  //   });
  // }

  // void _createFlashcard(BuildContext context) async {
  //   String standard = selectedGrade;
  //   String subject = selectedSubject;
  //   int? subjectId = subjectWithId[selectedSubject];
  //   String errorMessage = '';
  //   if (standard == "Select") {
  //     errorMessage = "Please select a standard.";
  //   } else if (subject == "Select") {
  //     errorMessage = "Please select a subject.";
  //   } else if (_collectionNameController.text.isEmpty) {
  //     errorMessage = "Please enter a collection name.";
  //   }

  //   if (errorMessage.isNotEmpty) {
  //     showErrorSnackBar(errorMessage);
  //     return;
  //   }

  //   if (subjectId == null) {
  //     showErrorSnackBar("Subject ID not found!");
  //     return;
  //   }

  //   bool success = await FlashcardApi.createflashcard(context, {
  //     "admin": "1",
  //     "collection_name": _collectionNameController.text,
  //     "contents": "",
  //     "subject_id": subjectId.toString(),
  //     "standard": standard,
  //     "test": "Yes"
  //   });

  //   if (success) {
  //     showSuccessSnackBar('', "Micronote added successfully!");
  //     setState(() {
  //       _isAdding = true;
  //     });
  //     initialLoading();
  //     // print("csv file");
  //     Navigator.pop(context);

  //     initialLoading();
  //     setState(() {
  //       _isAdding = false;
  //       FlashcardApi.flashcardRoute('0');
  //       selectedGrade = "Select";
  //       selectedSubject = "Select";
  //       _collectionNameController.clear();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
              Text(
                'Create New Collection',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textDark,
                ),
              ),
              const SizedBox(
                height: constants.defaultPadding * 2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Collection Name',
                    style: AppTextStyle.normalRegular14
                        .copyWith(color: labelColor),
                  ),
                  0.5.ph,
                  TextFeildStyle(
                    hintText: 'Collection xyz', onChanged: (p0) {},
                    controller: _collectionNameController,
                    height: 50,
                    // enabledBorder: widget.,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: greyborder),
                    ),
                    // hintText: 'johnny@mychetapep.com',
                    hintStyle:
                        AppTextStyle.normalRegular10.copyWith(color: hintText),
                    border: InputBorder.none,
                  ),
                ],
              ),
              2.5.ph,
              Column(
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
                        // _refreshData();
                      },
                      array: grade),
                ],
              ),
              2.5.ph,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subject',
                    style: AppTextStyle.normalRegular14
                        .copyWith(color: labelColor),
                  ),
                  0.5.ph,
                  // _isLoading
                  //     ? CircularProgressIndicator(
                  //         color: primaryColor,
                  //       )
                  //     :
                  MyDropDown(
                      // enable: enableSubject,
                      borderWidth: 1,
                      defaultValue: selectedSubject,
                      onChange: (value) async {
                        setState(() {
                          selectedSubject = value!;
                        });
                        // await SubjectApi.showAllSubjectsByStandard(
                        //     context, selectedGrade);
                      },
                      array: subjects), // CustomInfoField(
                ],
              ),
              5.ph,
              Center(
                  child: _isAdding
                      ? CircularProgressIndicator(
                          color: primaryColor,
                        )
                      : CustomButton(
                          isPopup: true,
                          textSize: 14,
                          width: MediaQuery.of(context).size.width / 10,
                          text: 'Create',
                          onPressed: () {
                            // _createFlashcard(context);
                          },
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
