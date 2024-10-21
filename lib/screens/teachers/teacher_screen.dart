import 'package:yokai_admin/Widgets/customTable.dart';
import 'package:yokai_admin/Widgets/imageButton.dart';
import 'package:yokai_admin/Widgets/my_dropdown.dart';
import 'package:yokai_admin/Widgets/new_button.dart';
import 'package:yokai_admin/Widgets/outline_button.dart';
import 'package:yokai_admin/Widgets/searchbar.dart';
import 'package:yokai_admin/Widgets/textfield.dart';
import 'package:yokai_admin/api/local_storage.dart';
import 'package:yokai_admin/main.dart';
// import 'package:yokai_admin/screens/dashboard/subject/subject_api.dart';
import 'package:yokai_admin/globalVariable.dart';

import 'package:yokai_admin/screens/teachers/addTeacherPage.dart';
import 'package:yokai_admin/screens/teachers/teacher%20api/teacher_api.dart';
import 'package:yokai_admin/screens/teachers/widget/addTeacher.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/const.dart';
import 'package:yokai_admin/utils/responsive.dart';
import 'package:yokai_admin/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yokai_admin/utils/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:url_launcher/url_launcher.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({Key? key, required this.scaffold}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffold;

  @override
  _TeacherScreenState createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  bool setobscureText = true;
  String? _errorName;
  String? _errorEmail;
  String? _errorPassword;
  bool editEnabled = false;
  String selectedCreatedby = "Select";
  String selectedSubject = "Select";
  String selectedGrade = "Select";
  @override
  void initState() {
    super.initState();
    // SubjectApi.showAllSubjectsByStandard(
    //     context, prefs?.getString(LocalStorage.standard) ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          // vertical: 15,
        ),
        child: Obx(() {
          return SingleChildScrollView(
            child: Container(
                color: Colors.white,
                child: TeacherApi.teacherRoute.value == '0'
                    ? teacherList(context)
                    : teacherDetails(context)),
          );
        }),
      ),
    );
  }

  Widget teacherList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18.0, bottom: 20),
          child: Row(
            children: [
              Expanded(
                flex: 7,
                child: Text(
                  'Teachers',
                  style:
                      AppTextStyle.normalBold28.copyWith(color: primaryColor),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: CustomButton(
                      text: '  + Add Teacher  ',
                      textSize: 14,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddTeacherDialog();
                          },
                        );
                      })),
              5.pw,
              Expanded(
                flex: 6,
                child: CustomSearchBar(
                  hintText: 'Search Teachers by Name / email / Ph. no.',
                  // controller: ,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: constants.defaultPadding,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTable(
            rows: 6,
            columns: 4,
            rowNames: [
              'Baraka  M.Jaa',
              'John',
              'Salma  Godwin',
              'Abdul',
              'Joshua Mick',
              'Christina',
            ],
            columnNames: [
              'Ph. No.',
              'Email',
              'Subject',
              'Actions',
            ],
            onTap: (int rowIndex) {
              // navigateToAddTeacherScreen(context);
              setState(() {
                TeacherApi.teacherRoute('1');
              });
              print('Cell in row $rowIndex is tapped');
            },
            firstColname: 'Teacher Name ',
            initialValues: [
              [
                ' +255 754 805 256  ',
                'emailaddressgfsdf@gmail.com',
                'Physics',
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageButton(
                      imagePath: 'icons/logo_wa.svg',
                      onPressed: () {
                        _openWhatsApp();
                        print('button pressed');
                      },
                    ),
                    // 1.pw,
                    // ImageButton(
                    //   imagePath: 'icons/logo_gmail.png',
                    //   onPressed: () {
                    //     _openEmail();
                    //     print('button pressed');
                    //   },
                    // ),
                    // 1.pw,
                    // ImageButton(
                    //   imagePath: 'icons/logo_user.png',
                    //   onPressed: () {
                    //     deleteTeacher(context);
                    //     print('button pressed');
                    //   },
                    // ),
                  ],
                )
              ],
              [
                ' +255 754 805 256  ',
                'emailaddressgfsdf@gmail.com',
                'Chemistry ',
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageButton(
                      imagePath: 'icons/logo_wa.svg',
                      onPressed: () {
                        _openWhatsApp();
                        print('button pressed');
                      },
                    ),
                    // 1.pw,
                    // ImageButton(
                    //   imagePath: 'icons/logo_gmail.png',
                    //   onPressed: () {
                    //     _openEmail();
                    //     print('button pressed');
                    //   },
                    // ),
                    // 1.pw,
                    // ImageButton(
                    //   imagePath: 'icons/logo_user.png',
                    //   onPressed: () {
                    //     deleteTeacher(context);
                    //     print('button pressed');
                    //   },
                    // ),
                  ],
                )
              ],
              [
                ' +255 754 805 256  ',
                'emailaddressgfsdf@gmail.com',
                'Maths',
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageButton(
                      imagePath: 'icons/logo_wa.svg',
                      onPressed: () {
                        _openWhatsApp();
                        print('button pressed');
                      },
                    ),
                    // 1.pw,
                    // ImageButton(
                    //   imagePath: 'icons/logo_gmail.png',
                    //   onPressed: () {
                    //     _openEmail();
                    //     print('button pressed');
                    //   },
                    // ),
                    // 1.pw,
                    // ImageButton(
                    //   imagePath: 'icons/logo_user.png',
                    //   onPressed: () {
                    //     deleteTeacher(context);
                    //     print('button pressed');
                    //   },
                    // ),
                  ],
                )
              ],
              [
                ' +255 754 805 256  ',
                'emailaddressgfsdf@gmail.com',
                'Accounts',
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageButton(
                      imagePath: 'icons/logo_wa.svg',
                      onPressed: () {
                        _openWhatsApp();
                        print('button pressed');
                      },
                    ),
                    // 1.pw,
                    // ImageButton(
                    //   imagePath: 'icons/logo_gmail.png',
                    //   onPressed: () {
                    //     _openEmail();
                    //     print('button pressed');
                    //   },
                    // ),
                    // 1.pw,
                    // ImageButton(
                    //   imagePath: 'icons/logo_user.png',
                    //   onPressed: () {
                    //     deleteTeacher(context);
                    //     print('button pressed');
                    //   },
                    // ),
                  ],
                )
              ],
              [
                ' +255 754 805 256  ',
                'emailaddressgfsdf@gmail.com',
                'Bio',
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageButton(
                      imagePath: 'icons/logo_wa.svg',
                      onPressed: () {
                        print('button pressed');
                      },
                    ),
                    // 1.pw,
                    // ImageButton(
                    //   imagePath: 'icons/logo_gmail.png',
                    //   onPressed: () {
                    //     print('button pressed');
                    //   },
                    // ),
                    // 1.pw,
                    // ImageButton(
                    //   imagePath: 'icons/logo_user.png',
                    //   onPressed: () {
                    //     print('button pressed');
                    //   },
                    // ),
                  ],
                )
              ],
              [
                ' +255 754 805 256  ',
                'emailaddressgfsdf@gmail.com',
                'Kiswahili',
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageButton(
                      imagePath: 'icons/logo_wa.svg',
                      onPressed: () {
                        _openWhatsApp();
                        print('button pressed');
                      },
                    ),
                    // 1.pw,
                    // ImageButton(
                    //   imagePath: 'icons/logo_gmail.png',
                    //   onPressed: () {
                    //     _openEmail();
                    //     print('button pressed');
                    //   },
                    // ),
                    // 1.pw,
                    // ImageButton(
                    //   imagePath: 'icons/logo_user.png',
                    //   onPressed: () {
                    //     deleteTeacher(context);
                    //     print('button pressed');
                    //   },
                    // ),
                  ],
                )
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget teacherDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Row(
            children: [
              SizedBox(
                height: 30,
                child: ImageButton(
                  imagePath: 'icons/backbutton.png',
                  onPressed: () {
                    setState(() {
                      TeacherApi.teacherRoute('0');
                    });
                  },
                ),
              ),
              5.pw,
              Expanded(
                flex: 7,
                child: Text(
                  'Teacher > ${TeacherApi.teacherName}',
                  style:
                      AppTextStyle.normalBold28.copyWith(color: primaryColor),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: constants.defaultPadding * 3),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Text(
            'General Details',
            style: AppTextStyle.normalBold18.copyWith(color: textColor),
          ),
        ),
        SizedBox(height: constants.defaultPadding),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: AppTextStyle.normalRegular14
                          .copyWith(color: labelColor),
                    ),
                    SizedBox(height: 0.5),
                    TextFeildStyle(
                      enabled: editEnabled ? true : false,
                      hintText: 'Enter',
                      onChanged: (p0) {},
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid name.';
                        }
                        // Add more validation rules as needed
                        return null;
                      },
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: greyborder),
                      ),
                      hintStyle: AppTextStyle.normalRegular10
                          .copyWith(color: hintText),
                      border: InputBorder.none,
                    ),
                    if (_errorName != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 3),
                        child: Text(
                          _errorName!,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              fontFamily: "Montserrat"),
                        ),
                      ),
                  ],
                ),
              ),
              10.pw,
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: AppTextStyle.normalRegular14
                          .copyWith(color: labelColor),
                    ),
                    SizedBox(height: 0.5),
                    TextFeildStyle(
                      enabled: editEnabled ? true : false,
                      hintText: '●●●●●●●●●',
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password.';
                        }
                        // Add more validation rules as needed
                        return null;
                      },
                      obscureText: setobscureText,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            setobscureText = !setobscureText;
                          });
                        },
                        icon: SvgPicture.asset(
                          setobscureText
                              ? "icons/password.svg"
                              : "icons/closepasswordeye_icon.svg",
                          color: headingOrange,
                        ),
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      controller: _passwordcontroller,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: greyborder),
                      ),
                      hintStyle: AppTextStyle.normalRegular10
                          .copyWith(color: hintText),
                      border: InputBorder.none,
                    ),
                    if (_errorPassword != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 3),
                        child: Text(
                          _errorPassword!,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              fontFamily: "Montserrat"),
                        ),
                      ),
                  ],
                ),
              ),
              10.pw,
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: AppTextStyle.normalRegular14
                          .copyWith(color: labelColor),
                    ),
                    SizedBox(height: 0.5),
                    TextFeildStyle(
                      enabled: editEnabled ? true : false,
                      hintText: 'Enter',
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid email.';
                        }
                        // Add more validation rules as needed
                        return null;
                      },
                      controller: _emailcontroller,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: greyborder),
                      ),
                      hintStyle: AppTextStyle.normalRegular10
                          .copyWith(color: hintText),
                      border: InputBorder.none,
                    ),
                    if (_errorEmail != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 3),
                        child: Text(
                          _errorEmail!,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              fontFamily: "Montserrat"),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        2.ph,
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Row(
            children: [
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
                    SizedBox(height: 0.5),
                    MyDropDown(
                      enable: editEnabled ? true : false,
                      borderWidth: 1,
                      defaultValue: selectedSubject,
                      onChange: (value) async {
                        setState(() {
                          selectedSubject = value!;
                        });
                        // await SubjectApi.showAllSubjectsByStandard(
                        //     context, selectedGrade);
                      },
                      array: subjects,
                    ),
                  ],
                ),
              ),
              10.pw,
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phone Number',
                      style: AppTextStyle.normalRegular14
                          .copyWith(color: labelColor),
                    ),
                    SizedBox(height: 0.5),
                    IntlPhoneField(
                      enabled: editEnabled ? true : false,
                      initialCountryCode: 'TZ',
                      disableLengthCheck: true,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(left: 12, right: 10),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: greyborder),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: greyborder),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: greyborder),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintStyle: AppTextStyle.normalRegular14
                            .copyWith(color: hintColor),
                        labelStyle: AppTextStyle.normalRegular14
                            .copyWith(color: textColor),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: greyborder),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      languageCode: "en",
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                      onCountryChanged: (country) {
                        print('Country changed to: ' + country.name);
                      },
                    ),
                  ],
                ),
              ),
              10.pw,
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 100.0),
                  child: CustomButton(
                    text: !editEnabled ? "Update Details" : "Save Changes",
                    textSize: 14,
                    onPressed: () {
                      setState(() {
                        editEnabled = !editEnabled;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: constants.defaultPadding * 3),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Text(
            'Purchase History',
            style: AppTextStyle.normalBold18.copyWith(color: textColor),
          ),
        ),
        SizedBox(height: constants.defaultPadding),
        CustomTable(
          rows: 6,
          columns: 4,
          rowNames: [
            '23-12-2024',
            '23-12-2024',
            '23-12-2024',
            '23-12-2024',
            '23-12-2024',
            '23-12-2024',
          ],
          columnNames: [
            'Name',
            'Type',
            'Subject',
            'Standard',
          ],
          firstColname: 'Date',
          initialValues: [
            [
              'ABDALAH HAMAD MAJOSA SCHEME OF WORK OF CIVICS FORM THREE YEAR OF 2024',
              'Lesson Plan',
              'Physics',
              'F2 '
            ],
            [
              'ABDALAH HAMAD MAJOSA SCHEME OF WORK OF CIVICS FORM THREE YEAR OF 2024',
              'Lesson Plan',
              'Physics',
              'F2 '
            ],
            [
              'ABDALAH HAMAD MAJOSA SCHEME OF WORK OF CIVICS FORM THREE YEAR OF 2024',
              'Lesson Plan',
              'Physics',
              'F2 '
            ],
            [
              'ABDALAH HAMAD MAJOSA SCHEME OF WORK OF CIVICS FORM THREE YEAR OF 2024',
              'Lesson Plan',
              'Physics',
              'F2 '
            ],
            [
              'ABDALAH HAMAD MAJOSA SCHEME OF WORK OF CIVICS FORM THREE YEAR OF 2024',
              'Lesson Plan',
              'Physics',
              'F2 '
            ],
            [
              'ABDALAH HAMAD MAJOSA SCHEME OF WORK OF CIVICS FORM THREE YEAR OF 2024',
              'Lesson Plan',
              'Physics',
              'F2 '
            ],
          ],
        ),
      ],
    );
  }

  void navigateToAddTeacherScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FractionallySizedBox(
          widthFactor: 0.8, // Adjust this value as needed
          child: Material(
            child: AddTeacherScreen(
              scaffold: widget.scaffold,
            ),
          ),
        ),
      ),
    );
  }

  _openEmail() async {
    const email = 'mailto:emailaddressgfsdf@gmail.com';
    await launch(email);
  }

  _openWhatsApp() async {
    const phoneNumber = 'whatsapp://send?phone=+255652313846';

    try {
      await launch(phoneNumber);
    } catch (e) {
      print('Error launching WhatsApp: $e');
    }
  }
}

void deleteTeacher(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          width: MediaQuery.of(context).size.width / 3,
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
                'Delete Teacher',
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
              Text(
                'Are you sure you want to delete this teacher account ? The user will lose all their data and it will not be recoverable.',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: textDark,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'To prevent this user from creating an account again with the same email or phone number, press “Delete & Block.” ',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textDark,
                ),
              ),
              const SizedBox(
                height: constants.defaultPadding * 5,
              ),
              Row(
                children: [
                  Expanded(
                      child: OutlineButton(
                          textSize: 14,
                          text: 'Delete & Block',
                          width: MediaQuery.of(context).size.width / 5,
                          onPressed: () {})),
                  const SizedBox(
                    width: constants.defaultPadding,
                  ),
                  Expanded(
                      child: CustomButton(
                    isPopup: true,
                    textSize: 14,
                    width: MediaQuery.of(context).size.width / 5,
                    text: 'Delete Account',
                    onPressed: () {},
                  )),
                  const SizedBox(
                    width: constants.defaultPadding,
                  ),
                  Expanded(
                      child: OutlineButton(
                    textSize: 14,
                    text: 'Cancel',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    width: MediaQuery.of(context).size.width / 5,
                  )),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
