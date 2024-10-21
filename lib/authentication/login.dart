import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yokai_admin/authentication/API/authentication_api.dart';
import 'package:yokai_admin/globalVariable.dart';
import 'package:yokai_admin/home/home_page.dart';
import 'package:yokai_admin/main.dart';
import 'package:yokai_admin/utils/const.dart';
import 'package:yokai_admin/utils/constants.dart';

import '../Widgets/textfield.dart';
import '../utils/colors.dart';
import '../utils/responsive.dart';
import '../utils/text_styles.dart';
import '../Widgets/my_textfield.dart';
import '../Widgets/new_button.dart';
import '../Widgets/progressHud.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final idController = TextEditingController();
  final passController = TextEditingController();
  RxBool isLoading = false.obs;
  final _passwordcontroller = TextEditingController();
  bool setobscureText = true;

  bool editEnabled = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Obx(() {
        return Scaffold(
          backgroundColor: Colors.white,
          body: ProgressHUD(
            isLoading: isLoading.value,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double screenWidth = constraints.maxWidth;
                final bool isDesktop = Responsive.isDesktop(context);
                final double imageWidth = isDesktop ? 350.0 : screenWidth * 0.4;
                final double formWidth = isDesktop ? 333.0 : screenWidth * 0.5;

                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.05,
                      vertical: constants.defaultPadding * 10,
                    ),
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none, // Allow overflow
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Container(
                          //   color: Colors.black12,
                          //   height: imageWidth,
                          //   width: imageWidth,
                          // ),
                          Image.asset(
                            'images/applogo.png',
                            height: imageWidth,
                            width: imageWidth,
                          ),
                          const SizedBox(
                            width: constants.defaultPadding,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "$appName",
                                style: AppTextStyle.normalSemiBold30.copyWith(
                                  color: headingOrange,
                                ),
                              ),
                              const SizedBox(
                                height: constants.defaultPadding * 2,
                              ),
                              Container(
                                height: Responsive.isMobile(context)
                                    ? double.infinity
                                    : constraints.maxHeight * 0.5,
                                width: formWidth,
                                padding: const EdgeInsets.all(
                                    constants.defaultPadding * 1.5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: colorWhite,
                                  border: Border.all(
                                    color: const Color(0xff5A9DB6),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Admin Access",
                                      style: AppTextStyle.normalSemiBold18,
                                    ),
                                    const SizedBox(
                                      height: constants.defaultPadding,
                                    ),
                                    CustomInfoField(
                                      controller: idController,
                                      hint: "admin@gmail.com",
                                      label: 'Email',
                                    ),
                                    const SizedBox(
                                      height: constants.defaultPadding,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Password',
                                          style: AppTextStyle.normalRegular14
                                              .copyWith(color: labelColor),
                                        ),
                                        0.5.ph,
                                        TextFeildStyle(
                                          hintText: '●●●●●●●●●',
                                          validation: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter a  password.';
                                            }
                                            return null;
                                          },
                                          obscureText: setobscureText,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                setobscureText =
                                                    !setobscureText;
                                              });
                                            },
                                            icon: SvgPicture.asset(
                                              setobscureText
                                                  ? "icons/password.svg"
                                                  : "icons/closepasswordeye_icon.svg",
                                              color: headingOrange,
                                            ),
                                          ),
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          controller: _passwordcontroller,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border:
                                                Border.all(color: greyborder),
                                          ),
                                          hintStyle: AppTextStyle
                                              .normalRegular10
                                              .copyWith(color: hintText),
                                          border: InputBorder.none,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: constants.defaultPadding * 2,
                                    ),
                                    CustomButton(
                                      width: double.infinity,
                                      onPressed: () {
                                        // loginFunction();

                                        isLoading(true);
                                        final List<TextEditingController>
                                            controllerList = [
                                          idController,
                                          _passwordcontroller
                                        ];
                                        final List<String> fieldsName = [
                                          'Email',
                                          'Password'
                                        ];
                                        bool valid = validateMyFields(context,
                                            controllerList, fieldsName);
                                        if (!valid) {
                                          isLoading(false);
                                          return;
                                        }
                                        final body = {
                                          "email": idController.text,
                                          "password": _passwordcontroller.text
                                        };
                                        AuthenticationApi.login(context, body)
                                            .then((value) {
                                          if (value) {
                                            nextPage(
                                              context,
                                              const HomePage(selectedTab: 0),
                                            );
                                          }
                                          isLoading(false);
                                        });
                                      },
                                      text: 'Login',
                                    ),
                                    const SizedBox(
                                      height: constants.defaultPadding,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showForgotPasswordDialog(context);
                                      },
                                      child: Text(
                                        'Forgot password?',
                                        textAlign: TextAlign.right,
                                        style: AppTextStyle.normalSemiBold14
                                            .copyWith(color: labelColor),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }

  void showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width / 5,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Admin Access : Forgot Password',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff637577),
                    ),
                  ),
                  const SizedBox(
                    height: constants.defaultPadding * 2,
                  ),
                  const Text(
                    'We’ve sent the reset password link to the registered email for the admin:',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff366A84),
                    ),
                  ),
                  const Text(
                    '<emailaddresssname@gmail.com>',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff366A84),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Please check your email for the steps to set a new password and log in with the new password after changing it.',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff366A84),
                    ),
                  ),
                  const SizedBox(
                    height: constants.defaultPadding * 5,
                  ),
                  CustomButton(
                      text: 'Login',
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  const SizedBox(
                    height: constants.defaultPadding * 2,
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Resend Link',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: labelColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // void loginFunction() {
  //   final String email = idController.text;
  //   final String password = _passwordcontroller.text;
  //   setState(() {
  //     isLoading = true;
  //   });
  //   AuthenticationApi.loginApi(context, email, password).then((success) {
  //     if (success) {
  //       prefs!.setBool(LocalStorage.isLogin, true);
  //       print(
  //           " Is logged in :: ${prefs!.getBool(LocalStorage.isLogin) ?? false}");
  //       nextPage(
  //         context,
  //         HomePage(selectedTab: 0),
  //       );
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   });
  // }
}
