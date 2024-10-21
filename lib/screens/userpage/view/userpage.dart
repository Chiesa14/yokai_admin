import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yokai_admin/Widgets/progressHud.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/const.dart';

import '../../../Widgets/new_button.dart';
import '../../../Widgets/new_button2.dart';
import '../../../Widgets/searchbar.dart';
import '../../../utils/text_styles.dart';
import '../controller/user_controller.dart';

class Userpage extends StatefulWidget {
  const Userpage({Key? key, required this.scaffold}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffold;

  @override
  _UserpageState createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {
  RxBool isLoading = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading(true);
    fetchAllUserData();
  }

  fetchAllUserData() async {
    await UserController.getAllUser('').then((value) {
      isLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Obx(() {
      return ProgressHUD(
        isLoading: isLoading.value,
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Text(
                          'Users',
                          style: AppTextStyle.normalBold28
                              .copyWith(color: carlo500),
                        ),
                      ),
                      5.pw,
                      Expanded(
                        flex: 6,
                        child: CustomSearchBar(
                          hintText: 'Search Users by Name / email / Ph. no.',
                          controller: UserController.searchUserController,
                          onTextChanged: (p0) async {
                            if (UserController.isBlocked.isFalse) {
                              await UserController.getAllUser(p0)
                                  .then((value) {});
                            } else {
                              await UserController.getAllBlockedUser(p0)
                                  .then((value) {});
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  2.ph,
                  Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          UserController.isBlocked(false);
                          UserController.searchUserController.clear();
                          isLoading(true);
                          await UserController.getAllUser('').then((value) {
                            isLoading(false);
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              gradient: UserController.isBlocked.isFalse
                                  ? customGradient
                                  : indigo50,
                              border: Border.all(
                                  color: (UserController.isBlocked.isFalse)
                                      ? indigo700
                                      : containerBackgroundNew,
                                  width: 2),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(14),
                                topLeft: Radius.circular(14),
                              )),
                          child: Text(
                            'Active Users',
                            style: textStyle.smallTextColorDark.copyWith(
                                color: UserController.isBlocked.isFalse
                                    ? colorWhite
                                    : indigo800,
                                fontWeight: UserController.isBlocked.isFalse
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                fontSize:
                                    UserController.isBlocked.isFalse ? 15 : 13),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          UserController.isBlocked(true);
                          UserController.searchUserController.clear();
                          isLoading(true);
                          await UserController.getAllBlockedUser('')
                              .then((value) {
                            isLoading(false);
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              gradient: UserController.isBlocked.isTrue
                                  ? customGradient
                                  : indigo50,
                              border: Border.all(
                                  color: (UserController.isBlocked.isTrue)
                                      ? indigo700
                                      : containerBackgroundNew,
                                  width: 2),
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(14),
                                topRight: Radius.circular(14),
                              )),
                          child: Text(
                            'Deactivated Users',
                            style: textStyle.smallTextColorDark.copyWith(
                                color: UserController.isBlocked.isTrue
                                    ? colorWhite
                                    : indigo800,
                                fontWeight: UserController.isBlocked.isTrue
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                fontSize:
                                    UserController.isBlocked.isTrue ? 15 : 13),
                          ),
                        ),
                      ),
                    ],
                  ),
                  2.ph,
                  (UserController.isBlocked.isFalse)
                      ? activateUsers(screenWidth: screenWidth)
                      : deActivateUsers(screenWidth: screenWidth),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  activateUsers({required double screenWidth}) {
    return Column(
      children: [
        Table(
          children: [
            TableRow(
              decoration: const BoxDecoration(color: carlo50),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 10, left: 10, top: 15, bottom: 15),
                  child: Row(
                    children: [
                      Expanded(
                        // flex: 2,
                        child: Text(
                          'Name ',
                          style: AppTextStyle.normalRegular16
                              .copyWith(color: hoverColor),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      2.pw,
                      Expanded(
                        child: Text(
                          'Ph. No.',
                          style: AppTextStyle.normalRegular16
                              .copyWith(color: hoverColor),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      2.pw,
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Email',
                          style: AppTextStyle.normalRegular16
                              .copyWith(color: hoverColor),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      // Expanded(
                      //   child: MyDropDown(
                      //     // enable: editEnabled ? true : false,
                      //     color: carlo50,
                      //     borderWidth: 1,
                      //     defaultValue: UserController.selectedSubject,
                      //     onChange: (value) async {
                      //       setState(() {
                      //         UserController.selectedSubject = value!;
                      //       });
                      //       // await SubjectApi.showAllSubjectsByStandard(
                      //       //     context, selectedGrade);
                      //     },
                      //     array: subjects,
                      //   ),
                      // ),
                      2.pw,
                      Expanded(
                        child: Text(
                          'Date Joined',
                          style: AppTextStyle.normalRegular16
                              .copyWith(color: hoverColor),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      2.pw,
                      Expanded(
                        child: Text(
                          'Actions',
                          style: AppTextStyle.normalRegular16
                              .copyWith(color: hoverColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ((UserController.getAllUserModel.value.data?.length ?? 0) > 0)
                ? TableRow(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            UserController.getAllUserModel.value.data?.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      // flex: 2,
                                      child: Text(
                                        UserController.getAllUserModel.value
                                                .data?[index].name
                                                .toString() ??
                                            '',
                                        textAlign: TextAlign.start,
                                        style: AppTextStyle.normalRegular14
                                            .copyWith(color: grey2),
                                      ),
                                    ),
                                    2.pw,

                                    Expanded(
                                      child: Text(
                                        UserController.getAllUserModel.value
                                                .data?[index].phoneNumber
                                                .toString() ??
                                            '',
                                        textAlign: TextAlign.start,
                                        style: AppTextStyle.normalSemiBold14
                                            .copyWith(
                                          color: indigo800,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                    2.pw,
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        UserController.getAllUserModel.value
                                                .data?[index].email
                                                .toString() ??
                                            '',
                                        textAlign: TextAlign.start,
                                        style: AppTextStyle.normalRegular14
                                            .copyWith(color: grey2),
                                      ),
                                    ),
                                    2.pw,
                                    Expanded(
                                      child: Text(
                                        DateFormat('yyyy-MM-dd   hh:mm a')
                                            .format(DateTime.parse(
                                                UserController
                                                        .getAllUserModel
                                                        .value
                                                        .data?[index]
                                                        .createdAt
                                                        .toString() ??
                                                    '')),
                                        textAlign: TextAlign.start,
                                        style: AppTextStyle.normalRegular14
                                            .copyWith(color: grey2),
                                      ),
                                    ),
                                    2.pw,
                                    Expanded(
                                      child: InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    elevation: 1,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.7,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              3,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                offset:
                                                                    const Offset(
                                                                        12, 26),
                                                                blurRadius: 50,
                                                                spreadRadius: 0,
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        .1)),
                                                          ]),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    Get.back();
                                                                  },
                                                                  child: SvgPicture
                                                                      .asset(
                                                                          'icons/cancel.svg'),
                                                                ),
                                                              ],
                                                            ),
                                                            Center(
                                                              child: Text(
                                                                'Delete User',
                                                                style: AppTextStyle
                                                                    .normalBold18
                                                                    .copyWith(
                                                                        color:
                                                                            textDark),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            Text(
                                                              "Are you sure you want to delete this user account ?\nThe user will lose all their data and it will not be recoverable. ",
                                                              style: AppTextStyle
                                                                  .normalRegular14
                                                                  .copyWith(
                                                                      color:
                                                                          textDark),
                                                            ),
                                                            3.ph,
                                                            Text(
                                                              "To prevent this user from creating an account again with the same\nemail or phone number, press “Block User” ",
                                                              style: AppTextStyle
                                                                  .normalSemiBold14
                                                                  .copyWith(
                                                                      color:
                                                                          textDark),
                                                            ),
                                                            3.ph,
                                                            Text(
                                                              "On deleting, you cannot recover the account data again.",
                                                              style: AppTextStyle
                                                                  .normalRegular14
                                                                  .copyWith(
                                                                      color:
                                                                          textDark),
                                                            ),
                                                            3.ph,
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        CustomButton2(
                                                                      width:
                                                                          screenWidth /
                                                                              10,
                                                                      textSize:
                                                                          14,
                                                                      color:
                                                                          indigo700,
                                                                      colorText:
                                                                          indigo700,
                                                                      onPressed:
                                                                          () {
                                                                        final body =
                                                                            {
                                                                          "user_id":
                                                                              UserController.getAllUserModel.value.data?[index].id.toString() ?? '',
                                                                          "account_status":
                                                                              "Deactivate"
                                                                        };
                                                                        UserController.deleteAndBlockUser(context,
                                                                                body)
                                                                            .then((value) {
                                                                          Navigator.pop(
                                                                              context);
                                                                          isLoading(
                                                                              true);
                                                                          fetchAllUserData();
                                                                        });
                                                                      },
                                                                      text:
                                                                          'Block User',
                                                                    ),
                                                                  ),
                                                                  2.pw,
                                                                  Expanded(
                                                                    child:
                                                                        CustomButton(
                                                                      width:
                                                                          screenWidth /
                                                                              10,
                                                                      textSize:
                                                                          14,
                                                                      onPressed:
                                                                          () {
                                                                        UserController.deleteUser(context,
                                                                                UserController.getAllUserModel.value.data?[index].id.toString() ?? '')
                                                                            .then((value) {
                                                                          Navigator.pop(
                                                                              context);
                                                                          isLoading(
                                                                              true);
                                                                          fetchAllUserData();
                                                                        });
                                                                      },
                                                                      text:
                                                                          'Delete Account',
                                                                    ),
                                                                  ),
                                                                  2.pw,
                                                                  Expanded(
                                                                    child:
                                                                        CustomButton2(
                                                                      width:
                                                                          screenWidth /
                                                                              10,
                                                                      textSize:
                                                                          14,
                                                                      color:
                                                                          indigo700,
                                                                      colorText:
                                                                          indigo700,
                                                                      onPressed:
                                                                          () {},
                                                                      text:
                                                                          'Cancel',
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: SvgPicture.asset(
                                              'icons/logo_wa.svg')),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: bottomBorder,
                              )
                            ],
                          );
                        },
                      )
                    ],
                  )
                : TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Center(
                          child: Text(
                            'No Data Found',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.normalRegular14
                                .copyWith(color: indigo800),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ],
    );
  }

  deActivateUsers({required double screenWidth}) {
    return Column(
      children: [
        Table(
          children: [
            TableRow(
              decoration: const BoxDecoration(color: carlo50),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 10, left: 10, top: 15, bottom: 15),
                  child: Row(
                    children: [
                      Expanded(
                        // flex: 2,
                        child: Text(
                          'Name ',
                          style: AppTextStyle.normalRegular16
                              .copyWith(color: hoverColor),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      2.pw,
                      Expanded(
                        child: Text(
                          'Ph. No.',
                          style: AppTextStyle.normalRegular16
                              .copyWith(color: hoverColor),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      2.pw,
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Email',
                          style: AppTextStyle.normalRegular16
                              .copyWith(color: hoverColor),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      // Expanded(
                      //   child: MyDropDown(
                      //     // enable: editEnabled ? true : false,
                      //     color: carlo50,
                      //     borderWidth: 1,
                      //     defaultValue: UserController.selectedSubject,
                      //     onChange: (value) async {
                      //       setState(() {
                      //         UserController.selectedSubject = value!;
                      //       });
                      //       // await SubjectApi.showAllSubjectsByStandard(
                      //       //     context, selectedGrade);
                      //     },
                      //     array: subjects,
                      //   ),
                      // ),
                      2.pw,
                      Expanded(
                        child: Text(
                          'Date Joined',
                          style: AppTextStyle.normalRegular16
                              .copyWith(color: hoverColor),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      2.pw,
                      Expanded(
                        child: Text(
                          'Actions',
                          style: AppTextStyle.normalRegular16
                              .copyWith(color: hoverColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ((UserController.getAllBlockedUserModel.value.data?.length ?? 0) >
                    0)
                ? TableRow(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: UserController
                            .getAllBlockedUserModel.value.data?.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      // flex: 2,
                                      child: Text(
                                        UserController.getAllBlockedUserModel
                                                .value.data?[index].name
                                                .toString() ??
                                            '',
                                        textAlign: TextAlign.start,
                                        style: AppTextStyle.normalRegular14
                                            .copyWith(color: grey2),
                                      ),
                                    ),
                                    2.pw,
                                    Expanded(
                                      child: Text(
                                        UserController.getAllBlockedUserModel
                                                .value.data?[index].phoneNumber
                                                .toString() ??
                                            '',
                                        textAlign: TextAlign.start,
                                        style: AppTextStyle.normalSemiBold14
                                            .copyWith(
                                          color: indigo800,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                    2.pw,
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        UserController.getAllBlockedUserModel
                                                .value.data?[index].email
                                                .toString() ??
                                            '',
                                        textAlign: TextAlign.start,
                                        style: AppTextStyle.normalRegular14
                                            .copyWith(color: grey2),
                                      ),
                                    ),
                                    2.pw,
                                    Expanded(
                                      child: Text(
                                        DateFormat('yyyy-MM-dd   hh:mm a')
                                            .format(DateTime.parse(
                                                UserController
                                                        .getAllBlockedUserModel
                                                        .value
                                                        .data?[index]
                                                        .createdAt
                                                        .toString() ??
                                                    '')),
                                        textAlign: TextAlign.start,
                                        style: AppTextStyle.normalRegular14
                                            .copyWith(color: grey2),
                                      ),
                                    ),
                                    2.pw,
                                    Expanded(
                                      child: InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    elevation: 1,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.7,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              3,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                offset:
                                                                    const Offset(
                                                                        12, 26),
                                                                blurRadius: 50,
                                                                spreadRadius: 0,
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        .1)),
                                                          ]),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    Get.back();
                                                                  },
                                                                  child: SvgPicture
                                                                      .asset(
                                                                          'icons/cancel.svg'),
                                                                ),
                                                              ],
                                                            ),
                                                            Center(
                                                              child: Text(
                                                                // 'Delete User',
                                                                'Activate User',
                                                                style: AppTextStyle
                                                                    .normalBold18
                                                                    .copyWith(
                                                                        color:
                                                                            textDark),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            Text(
                                                              "Are you sure you want to delete this user account ?\nThe user will lose all their data and it will not be recoverable. ",
                                                              style: AppTextStyle
                                                                  .normalRegular14
                                                                  .copyWith(
                                                                      color:
                                                                          textDark),
                                                            ),
                                                            // 3.ph,
                                                            // Text(
                                                            //   "To prevent this user from creating an account again with the same\nemail or phone number, press “Delete & Block.” ",
                                                            //   style: AppTextStyle
                                                            //       .normalSemiBold14
                                                            //       .copyWith(
                                                            //           color:
                                                            //               textDark),
                                                            // ),
                                                            3.ph,
                                                            Text(
                                                              "On deleting, you cannot recover the account data again.",
                                                              style: AppTextStyle
                                                                  .normalRegular14
                                                                  .copyWith(
                                                                      color:
                                                                          textDark),
                                                            ),
                                                            3.ph,
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        CustomButton2(
                                                                      width:
                                                                          screenWidth /
                                                                              10,
                                                                      textSize:
                                                                          14,
                                                                      color:
                                                                          indigo700,
                                                                      colorText:
                                                                          indigo700,
                                                                      onPressed:
                                                                          () {
                                                                        final body =
                                                                            {
                                                                          "user_id":
                                                                              UserController.getAllBlockedUserModel.value.data?[index].id.toString() ?? '',
                                                                          "account_status":
                                                                              "Activate"
                                                                        };
                                                                        UserController.deleteAndBlockUser(context,
                                                                                body)
                                                                            .then((value) async {
                                                                          Navigator.pop(
                                                                              context);
                                                                          isLoading(true);
                                                                          await UserController.getAllBlockedUser('')
                                                                              .then((value) {
                                                                            isLoading(false);
                                                                          });
                                                                        });
                                                                      },
                                                                      text:
                                                                          'Activate User',
                                                                    ),
                                                                  ),
                                                                  2.pw,
                                                                  Expanded(
                                                                    child:
                                                                        CustomButton(
                                                                      width:
                                                                          screenWidth /
                                                                              10,
                                                                      textSize:
                                                                          14,
                                                                      onPressed:
                                                                          () {
                                                                        UserController.deleteUser(context,
                                                                                UserController.getAllBlockedUserModel.value.data?[index].id.toString() ?? '')
                                                                            .then((value) async {
                                                                          Navigator.pop(
                                                                              context);
                                                                          isLoading(true);
                                                                          await UserController.getAllBlockedUser('')
                                                                              .then((value) {
                                                                            isLoading(false);
                                                                          });
                                                                        });
                                                                      },
                                                                      text:
                                                                          'Permanently Delete Account',
                                                                    ),
                                                                  ),
                                                                  2.pw,
                                                                  Expanded(
                                                                    child:
                                                                        CustomButton2(
                                                                      width:
                                                                          screenWidth /
                                                                              10,
                                                                      textSize:
                                                                          14,
                                                                      color:
                                                                          indigo700,
                                                                      colorText:
                                                                          indigo700,
                                                                      onPressed:
                                                                          () {},
                                                                      text:
                                                                          'Cancel',
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: SvgPicture.asset(
                                              'icons/logo_wa.svg')),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: bottomBorder,
                              )
                            ],
                          );
                        },
                      )
                    ],
                  )
                : TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Center(
                          child: Text(
                            'No Data Found',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.normalRegular14
                                .copyWith(color: indigo800),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ],
    );
  }
}
