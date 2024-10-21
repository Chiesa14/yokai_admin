import 'package:yokai_admin/Widgets/my_dropdown.dart';
import 'package:yokai_admin/Widgets/new_button.dart';
import 'package:yokai_admin/Widgets/outline_button.dart';
import 'package:yokai_admin/Widgets/textfield.dart';
import 'package:yokai_admin/globalVariable.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/const.dart';
import 'package:yokai_admin/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:yokai_admin/utils/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AddTeacherDialog extends StatefulWidget {
  @override
  _AddTeacherDialogState createState() => _AddTeacherDialogState();
}

class _AddTeacherDialogState extends State<AddTeacherDialog> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  bool setobscureText = true;
  String? _errorName;
  String? _errorEmail;
  String? _errorPassword;
  String selectedCreatedby = "Select";
  String selectedSubject = "Select";
  String selectedGrade = "Select";
  @override
  void initState() {
    super.initState();
    // SubjectApi.showAllSubjectsByStandard(context, selectedGrade);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
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
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                Text(
                  'Add Teacher',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff122E59),
                  ),
                ),
                const SizedBox(
                  height: constants.defaultPadding * 2,
                ),
                Text(
                  'The created teacher’s account will be able to access the teacher panel. Once created, the teacher can also edit these details.',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff122E59),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Name',
                  style:
                      AppTextStyle.normalRegular14.copyWith(color: labelColor),
                ),
                0.5.ph,
                TextFeildStyle(
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
                  hintStyle:
                      AppTextStyle.normalRegular10.copyWith(color: hintText),
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
                1.ph,
                Text(
                  'Password',
                  style:
                      AppTextStyle.normalRegular14.copyWith(color: labelColor),
                ),
                0.5.ph,
                TextFeildStyle(
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
                  hintStyle:
                      AppTextStyle.normalRegular10.copyWith(color: hintText),
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

                1.ph,
                Text(
                  'Phone Number',
                  style:
                      AppTextStyle.normalRegular14.copyWith(color: labelColor),
                ),
                0.5.ph,
                IntlPhoneField(
                  initialCountryCode: 'TZ',
                  disableLengthCheck: true,
                  // initialValue: 'TZ',
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 12, right: 10),
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
                          color: greyborder), // Customize the border color
                      borderRadius:
                          BorderRadius.circular(12), // Set the border radius
                    ),
                    // hintText: '',
                    // hintTextDirection: widget.hintTextDirection,
                    hintStyle:
                        AppTextStyle.normalRegular14.copyWith(color: hintColor),
                    // labelText: widget.labelText,
                    labelStyle:
                        AppTextStyle.normalRegular14.copyWith(color: textColor),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: greyborder), // Customize the border color
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
                1.ph,
                Text(
                  'Email',
                  style:
                      AppTextStyle.normalRegular14.copyWith(color: labelColor),
                ),
                0.5.ph,
                TextFeildStyle(
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
                  hintStyle:
                      AppTextStyle.normalRegular10.copyWith(color: hintText),
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
                1.ph,
                Text(
                  'Subject',
                  style:
                      AppTextStyle.normalRegular14.copyWith(color: labelColor),
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
                const SizedBox(
                  height: constants.defaultPadding * 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: OutlineButton(
                              textSize: 14,
                              text: 'Cancel',
                              // width: MediaQuery.of(context).size.width,
                              onPressed: () {})),
                      const SizedBox(
                        width: constants.defaultPadding,
                      ),
                      Expanded(
                          flex: 5,
                          child: CustomButton(
                            isPopup: true,
                            textSize: 14,
                            // width: MediaQuery.of(context).size.width,
                            text: 'Add Teacher',
                            onPressed: () {},
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

void addTeacher(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AddTeacherDialog();
    },
  );
}
