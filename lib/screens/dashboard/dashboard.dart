import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yokai_admin/Widgets/dashboard_Container.dart';
import 'package:yokai_admin/Widgets/progressHud.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/const.dart';
import 'package:yokai_admin/utils/text_styles.dart';

import '../../globalVariable.dart';
import '../chapters/controller/chapters_controller.dart';
import 'controllers/dashboard_controllers.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.scaffold}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffold;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  RxBool isLoading = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading(true);
    fetchDashBoardData();
  }

  fetchDashBoardData() async {
    await DashBoardController.getDashBoardCount().then(
      (value) {
        isLoading(false);
      },
    );
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
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DASHBOARD',
                  style: AppTextStyle.normalBold28.copyWith(
                    color: carlo500,
                  ),
                ),
                4.ph,
                Row(
                  children: [
                    DashboardCountWidget(
                        onTap: () {},
                        title: 'No. of Users',
                        userCount: DashBoardController
                            .getHomeDashboardCount.value.noOfUsers
                            .toString()),
                    2.pw,
                    DashboardCountWidget(
                        onTap: () {},
                        title: 'Stories Posted',
                        userCount: DashBoardController
                            .getHomeDashboardCount.value.storiesPosted
                            .toString()),
                    2.pw,
                    DashboardCountWidget(
                        onTap: () {},
                        title: 'Total Chapters across all stories',
                        userCount: DashBoardController.getHomeDashboardCount
                            .value.totalChaptersAcrossAllStories
                            .toString()),
                  ],
                ),
                2.ph,
                Row(
                  children: [
                    DashboardCountWidget(
                        onTap: () {},
                        title: 'Activities Listed ',
                        userCount: DashBoardController
                            .getHomeDashboardCount.value.activitiesListed
                            .toString()),
                    2.pw,
                    DashboardCountWidget(
                        onTap: () {},
                        title: 'Characters posted',
                        userCount: DashBoardController
                            .getHomeDashboardCount.value.charactersPosted
                            .toString()),
                    2.pw,
                    DashboardCountWidget(
                        onTap: () {},
                        title: 'Avg. no. of Activities Per Story',
                        userCount: DashBoardController.getHomeDashboardCount
                            .value.avgNoOfActivitiesPerStory
                            .toString()),
                  ],
                ),
                2.ph,
                Row(
                  children: [
                    DashboardCountWidget(
                        onTap: () {},
                        title: 'Blocked Users',
                        userCount: DashBoardController
                            .getHomeDashboardCount.value.blockedUsers
                            .toString()),
                    2.pw,
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: screenHeight * 0.13,
                        width: screenWidth / 6,
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: carlo100,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('icons/character.svg'),
                            1.pw,
                            Text(
                              'Add Character',
                              style: AppTextStyle.normalBold18
                                  .copyWith(fontFamily: 'Raleway'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    2.pw,
                    GestureDetector(
                      onTap: () {
                        ChaptersController.chapterPage(1);
                        routePage(context, adminRoute[3]);
                      },
                      child: Container(
                        height: screenHeight * 0.13,
                        width: screenWidth / 6,
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: indigo100,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('icons/book.svg'),
                            1.pw,
                            Text(
                              ' Upload Chapter',
                              style: AppTextStyle.normalBold18
                                  .copyWith(fontFamily: 'Raleway'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
