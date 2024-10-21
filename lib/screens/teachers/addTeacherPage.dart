import 'package:yokai_admin/Widgets/customTable.dart';
import 'package:yokai_admin/Widgets/my_dropdown.dart';
import 'package:yokai_admin/Widgets/new_button.dart';
import 'package:yokai_admin/Widgets/outline_button.dart';
import 'package:yokai_admin/Widgets/textfield.dart';
// import 'package:yokai_admin/screens/dashboard/subject/subject_api.dart';
import 'package:yokai_admin/globalVariable.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/const.dart';
import 'package:yokai_admin/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yokai_admin/utils/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AddTeacherScreen extends StatefulWidget {
  const AddTeacherScreen({Key? key, required this.scaffold, this.name = ''})
      : super(key: key);

  final GlobalKey<ScaffoldState> scaffold;
  final String name;

  @override
  _AddTeacherScreenState createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
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
    // TODO: implement initState
    super.initState();
    // SubjectApi.showAllSubjectsByStandard(context, selectedGrade);
  }

  // String selectedSubject = "Select";
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            // vertical: 15,
          ),
          child: Obx(() {
            return Container(
              color: Colors.white,
              // margin: EdgeInsets.all(Responsive.isMobile(context)
              //     ? constants.defaultPadding
              //     : constants.defaultPadding * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Expanded(
                      flex: 7,
                      child: Text(
                        'Students > ${widget.name}',
                        style: AppTextStyle.normalBold28
                            .copyWith(color: primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: constants.defaultPadding,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Expanded(
                      flex: 7,
                      child: Text(
                        'General Details',
                        style: AppTextStyle.normalBold18
                            .copyWith(color: textColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: constants.defaultPadding,
                  ),
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
                              0.5.ph,
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
                                // controller: name,
                                height: 50,
                                // enabledBorder: widget.,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: greyborder),
                                ),
                                // hintText: 'johnny@mychetapep.com',
                                hintStyle: AppTextStyle.normalRegular10
                                    .copyWith(color: hintText),
                                border: InputBorder.none,
                              ),
                              if (_errorName != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    top: 3,
                                  ),
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
                              0.5.ph,
                              TextFeildStyle(
                                enabled: editEnabled ? true : false,

                                hintText: '●●●●●●●●●',
                                // onChanged: (value) {
                                //   _validatePassword(value);
                                // },
                                validation: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a  password.';
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
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    top: 3,
                                  ),
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
                              0.5.ph,
                              TextFeildStyle(
                                enabled: editEnabled ? true : false,

                                hintText: 'Enter',
                                // onChanged: (p0) {
                                //   validateEmail(p0);
                                // },
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
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    top: 3,
                                  ),
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
                                0.5.ph,
                                MyDropDown(
                                    enable: editEnabled ? true : false,
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
                              0.5.ph,
                              IntlPhoneField(
                                enabled: editEnabled ? true : false,

                                initialCountryCode: 'TZ',
                                disableLengthCheck: true,
                                // initialValue: 'TZ',
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      left: 12, right: 10),
                                  // focusColor: widget.focusColor,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: greyborder),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: greyborder),
                                    borderRadius: BorderRadius.circular(12),
                                  ),

                                  // fillColor: widget.fillColor,
                                  // filled: widget.filled,

                                  // enabledBorder: widget.enabledBorder,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            greyborder), // Customize the border color
                                    borderRadius: BorderRadius.circular(
                                        12), // Set the border radius
                                  ),
                                  // hintText: '',
                                  // hintTextDirection: widget.hintTextDirection,
                                  hintStyle: AppTextStyle.normalRegular14
                                      .copyWith(color: hintColor),
                                  // labelText: widget.labelText,
                                  labelStyle: AppTextStyle.normalRegular14
                                      .copyWith(color: textColor),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              greyborder), // Customize the border color
                                      borderRadius: BorderRadius.circular(12)),
                                  // suffixText: widget.suffixText,
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
                                  text: !editEnabled
                                      ? "Update Details"
                                      : "Save Changes",
                                  textSize: 14,
                                  onPressed: () {
                                    setState(() {
                                      editEnabled = !editEnabled;
                                    });
                                  }),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: constants.defaultPadding,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Expanded(
                      flex: 7,
                      child: Text(
                        'Purchase History',
                        style: AppTextStyle.normalBold18
                            .copyWith(color: textColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: constants.defaultPadding,
                  ),
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
              ),
            );
          }),
        ),
      ),
    );
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
