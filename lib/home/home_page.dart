import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yokai_admin/Widgets/appName.dart';
import 'package:yokai_admin/home/widgets/side_options.dart';
import 'package:yokai_admin/home/widgets/user_details.dart';
import 'package:yokai_admin/screens/dashboard/dashboard.dart';
import 'package:yokai_admin/screens/userpage/view/userpage.dart';
import 'package:yokai_admin/utils/constants.dart';

import '../Widgets/confirmation_box.dart';
import '../api/local_storage.dart';
import '../authentication/login.dart';
import '../globalVariable.dart';
import '../main.dart';
import '../screens/activities/view/activities_page.dart';
import '../screens/chapters/view/chapter_page.dart';
import '../screens/characters/view/characters_page.dart';
import '../screens/stories/view/stories_page.dart';
import '../utils/colors.dart';
import '../utils/responsive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.selectedTab}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

  final int selectedTab;
}

class _HomePageState extends State<HomePage> {
  int selectedTab = 0;
  Timer? timer;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    selectedTab = widget.selectedTab;
    timer = Timer.periodic(const Duration(minutes: 5), (timer) {});
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: Column(
          children: [
            AppNameContainer(),
            Expanded(
              child: Row(
                children: [
                  Responsive.isDesktop(context)
                      ? Expanded(
                          flex: 2,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: containerBackgroundNew,
                              border: Border(
                                right: BorderSide(color: border),
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                ListView(
                                  children: [
                                    const SizedBox(
                                        height: constants.defaultPadding),
                                    Column(
                                      children: List.generate(
                                        tabTitles.length,
                                        // Ensure we only generate as many items as we have titles/icons/routes
                                        (index) {
                                          return SideOptions(
                                            onPress: () {
                                              if (tabTitles[index] ==
                                                  'Logout') {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return ConfirmationDialog(
                                                        title: "Log Out?",
                                                        content: const Text(
                                                          'Are you sure you want to log out of the Admin? Your data will not be lost. ',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF637577),
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        cancelButtonText:
                                                            'Cancel',
                                                        confirmButtonText:
                                                            'Confirm',
                                                        onCancel: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        displayIcon: true,
                                                        customImageAsset:
                                                            'images/logowithbg.png',
                                                        onConfirm: () async {
                                                          prefs?.setBool(
                                                              LocalStorage
                                                                  .isLogin,
                                                              false);
                                                          prefs?.clear();
                                                          navigator
                                                              ?.pushAndRemoveUntil(
                                                                  MaterialPageRoute(
                                                            builder: (context) {
                                                              return LoginPage();
                                                            },
                                                          ), (route) => false);
                                                        });
                                                  },
                                                );
                                              } else {
                                                routePage(
                                                    context, adminRoute[index]);
                                              }

                                              activityCount = 0;
                                            },
                                            title: tabTitles[index],
                                            selected: index == selectedTab,
                                            icon: tabIcons[index],
                                          );
                                        },
                                      ),

                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                  Expanded(
                    flex: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: getPage(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        drawer: Responsive.isMobile(context)
            ? Container(
                width: MediaQuery.of(context).size.width * 0.6,
                color: Colors.white,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: constants.defaultPadding),
                        UserDetails(
                          // selected: selectedTab == 4 ? true : false,
                          onPress: () {
                            Navigator.pop(context);
                            activityCount = 0;
                          },
                        ),
                        const Divider(
                          thickness: 0.6,
                          color: primaryColorLigth,
                          indent: constants.defaultPadding,
                          endIndent: constants.defaultPadding,
                        ),
                        const SizedBox(
                          height: constants.defaultPadding * 2,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }

  Widget getPage() {
    switch (selectedTab) {
      // case 10:
      //   return ReportScreen(scaffold: _scaffoldKey);
      // case 9:
      //   return LessonPlanScreen(scaffold: _scaffoldKey);
      // case 8:
      //   return FlashCardScreen(scaffold: _scaffoldKey);
      // case 7:
      //   return ActivitiesPage(scaffold: _scaffoldKey);
      // case 6:
      //   return CharactersPage(scaffold: _scaffoldKey);
      case 5:
        return CharactersPage(scaffold: _scaffoldKey);
      case 4:
        return ActivitiesPage(scaffold: _scaffoldKey);
      case 3:
        return ChaptersPage(scaffold: _scaffoldKey);
      case 2:
        return StoriesPage(scaffold: _scaffoldKey);
      case 1:
        return Userpage(
          scaffold: _scaffoldKey,
        );
      case 0:
        return Dashboard(scaffold: _scaffoldKey);
    }
    return Container(
      color: Colors.grey,
    );
  }

  void _navigateToStudentDetailsPage(BuildContext context) {
    print('');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Userpage(scaffold: _scaffoldKey)),
    );
  }
}
