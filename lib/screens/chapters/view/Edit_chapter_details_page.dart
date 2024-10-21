import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yokai_admin/Widgets/progressHud.dart';
import 'package:yokai_admin/globalVariable.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/const.dart';

import '../../../Widgets/new_button.dart';
import '../../../api/database.dart';
import '../../../utils/text_styles.dart';
import '../controller/chapters_controller.dart';

class EditChapterDetailsPAge extends StatefulWidget {
  const EditChapterDetailsPAge({super.key});

  @override
  State<EditChapterDetailsPAge> createState() => _EditChapterDetailsPAgeState();
}

class _EditChapterDetailsPAgeState extends State<EditChapterDetailsPAge> {
  RxBool isLoading = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() {
    isLoading(true);
    if (ChaptersController.isEdit.isTrue) {
      ChaptersController.getAllChapterByChapterId(
              ChaptersController.chapterId.value)
          .then((value) {
        ChaptersController.urlEnglishPdf(
            "${DatabaseApi.mainUrlForImage}${(ChaptersController.getChapterByChapterId.value.data?.chapterDocumentEnglish.toString() ?? '').trimLeft().trimRight()}");
        customPrint("chapterDocumentEnglish :: #${ChaptersController.urlEnglishPdf.value}#");
        customPrint(
            "chapterDocumentEnglish :: #${DatabaseApi.mainUrlForImage}#");
        customPrint(
            "chapterDocumentEnglish :: #${ChaptersController.getChapterByChapterId.value.data?.chapterDocumentEnglish.toString() ?? ''}#");

        isLoading(false);
      });
    }
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
              padding: EdgeInsets.symmetric(horizontal: screenWidth / 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              ChaptersController.urlEnglishPdf('');
                              ChaptersController.chapterPage(0);
                            },
                            child: SvgPicture.asset('icons/back.svg',height: 35,width: 35,),),1.pw,
                          Text(
                            'Chapter Details',
                            style:
                                AppTextStyle.normalBold28.copyWith(color: carlo500),
                          ),
                        ],
                      ),
                      CustomButton(
                          text: 'Edit Chapter',
                          textSize: 14,
                          width: screenWidth / 9,
                          onPressed: () {
                            ChaptersController.isEditDetails(true);
                            ChaptersController.forStorySelect(true);
                            ChaptersController.chapterPage(1);
                          }),
                    ],
                  ),
                  2.ph,
                  Text(
                    ((ChaptersController
                                    .getChapterByChapterId.value.data?.chapterNo
                                    .toString() ??
                                '') !=
                            '')
                        ? '${ChaptersController.getChapterByChapterId.value.data?.chapterNo.toString() ?? ''} : ${ChaptersController.getChapterByChapterId.value.data?.name.toString() ?? ''}'
                        : 'Chapter : ',
                    style:
                        AppTextStyle.normalRegular20.copyWith(color: ironColor),
                  ),
                  2.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Story : ${ChaptersController.getChapterByChapterId.value.data?.storyName.toString() ?? ''}',
                        // 'Story : NA',
                        style: AppTextStyle.normalRegular16
                            .copyWith(color: ironColor),
                      ),
                      2.pw,
                      Text(
                        ((ChaptersController
                            .getChapterByChapterId.value.data?.chapterNo
                            .toString() ??
                            '') !=
                            '')
                            ? '${ChaptersController.getChapterByChapterId.value.data?.chapterNo.toString() ?? ''}':'',
                        style: AppTextStyle.normalRegular16
                            .copyWith(color: ironColor),
                      ),
                      2.pw,
                      Text(
                        'Last Updated : ${DateFormat('dd-MM-yyyy').format(DateTime.tryParse(ChaptersController.getChapterByChapterId.value.data?.updatedAt.toString() ?? '') ?? DateTime.now())}',
                        style: AppTextStyle.normalRegular16
                            .copyWith(color: ironColor),
                      ),
                    ],
                  ),
                  5.ph,
                  Text(
                    'Chapter PDF: ',
                    style:
                        AppTextStyle.normalRegular16.copyWith(color: ironColor),
                  ),
                  3.ph,
                  SizedBox(
                    height: screenHeight,
                    child: HtmlWidget(
                      '<iframe src="${ChaptersController.urlEnglishPdf.value}" width="100%" height="700"></iframe>',
                      key: UniqueKey(), // Ensure widget recreation
                    ),
                  ),
                  // SizedBox(
                  //   height: screenHeight,
                  //   child: SfPdfViewer.network(
                  //       'https://www.clickdimensions.com/links/TestPDFfile.pdf'),
                  // ),
                  3.ph,
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
