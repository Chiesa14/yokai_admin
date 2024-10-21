import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yokai_admin/utils/const.dart';

import '../../../Widgets/imageButton.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_styles.dart';

class CustomQuestionCard extends StatefulWidget {
  final String question;
  final List<String> options;
  final List<String> icons;
  final List<void Function()> onPressedActions;
  final String imagePath;
  final String correctAnswer;

  const CustomQuestionCard({
    super.key,
    required this.question,
    this.imagePath = '',
    this.correctAnswer = '',
    required this.options,
    required this.icons,
    required this.onPressedActions,
  });

  @override
  _CustomQuestionCardState createState() => _CustomQuestionCardState();
}

class _CustomQuestionCardState extends State<CustomQuestionCard> {
  String? selectedOption;
  // List<String> selectedOptionList = [];
  @override
  void initState() {
    super.initState();
    // selectedOptionList = List.generate(widget.question.length, (index) => '');
    // updateSelectedOption();
    print("imagepath :: ${widget.imagePath}");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Color(0xffF1F8FA), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = constraints.maxWidth;
            final isDesktop = cardWidth > 600;
            final maxRadioWidth = isDesktop ? 282.0 : cardWidth - 424.0;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.question,
                        style: AppTextStyle.regularBold
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: isDesktop ? 16.0 : 12.0),
                      if (widget.imagePath.isNotEmpty &&
                          widget.imagePath !=
                              'https://api.clickonlineacademy.ac.tz' &&
                          widget.imagePath !=
                              'https://api.clickonlineacademy.ac.tznull' &&
                          !widget.imagePath.contains('null'))
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: Image.network(
                                    widget.imagePath,
                                    fit: BoxFit.contain,
                                  ),
                                );
                              },
                            );
                          },
                          child: Center(
                            child: Image.network(
                              widget.imagePath,
                              height: 100,
                            ),
                          ),
                        ),
                      SizedBox(height: isDesktop ? 16.0 : 12.0),
                      Column(
                        children: List.generate(
                            (widget.options.length + 1) ~/ 2, (index) {
                          return Row(
                            children: List.generate(2, (idx) {
                              int currentIndex = index * 2 + idx;
                              if (currentIndex < widget.options.length) {
                                final isSelected = selectedOption ==
                                    widget.options[currentIndex];
                                final isCorrectAnswer =
                                    widget.correctAnswer.trim() ==
                                        widget.options[currentIndex]
                                            .replaceFirst(
                                                RegExp(r'^[a-d]\)\s*'), '')
                                            .trim();
                                return Padding(
                                  padding: EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 8.0,
                                    left: 8.0,
                                    right: idx == 0 ? maxRadioWidth : 16.0,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedOption =
                                            widget.options[currentIndex];
                                      });
                                    },
                                    child: Container(
                                      width: isDesktop ? 300.0 : cardWidth - 40,
                                      // height:
                                      //     widget.options[currentIndex].length >
                                      //             35
                                      //         ? 60.0
                                      //         : 40.0,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Color(0xffA7F3D0)
                                            : isCorrectAnswer
                                                ? Color(0xffA7F3D0)
                                                : Color(0xffF1F8FA),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        border: Border.all(
                                          color: isSelected
                                              ? Color(0xff10B981)
                                              : isCorrectAnswer
                                                  ? Color(0xff10B981)
                                                  : Color(0xffCCD4D5),
                                        ),
                                      ),
                                      child: RadioListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            widget.options[currentIndex],
                                            style: AppTextStyle.regularBold
                                                .copyWith(
                                              fontWeight: isSelected
                                                  ? FontWeight.bold
                                                  : isCorrectAnswer
                                                      ? FontWeight.bold
                                                      : FontWeight.w400,
                                              color: textDark,
                                            ),
                                          ),
                                        ),
                                        value: widget.options[currentIndex],
                                        groupValue: isCorrectAnswer
                                            ? widget.options[currentIndex]
                                            : selectedOption,
                                        onChanged: (value) {
                                          // setState(() {
                                          //   selectedOption = value;
                                          //   selectedOptionList?.insert(
                                          //     currentIndex,
                                          //     selectedOption ?? '',
                                          //   );
                                          //   print("selectedOptionList :: $selectedOptionList");
                                          //   // print("selectedOption :: $selectedOption");
                                          // });
                                        },
                                        activeColor: primaryColor,
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        contentPadding: EdgeInsets.zero,
                                        dense: true,
                                        selected: isSelected,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            }),
                          );
                        }),
                      ),
                      2.ph,
                      Text(
                        'Explaination',
                        style: AppTextStyle.regularBold
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      0.5.ph,
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Feeling stressed? It happens to everyone! But how we handle those tough moments can make a big difference. This short quiz will explore your coping mechanisms and see if you have a healthy toolbox for dealing with life\'s challenges. Let\'s see if your go-to strategies are helping you thrive! Let\'s see if your go-to strategies are helping you thrive! Let\'s see if your go-to strategies are helping you thrive!',
                              style: AppTextStyle.regularBold.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff667085)),
                            ),
                          ),
                          1.pw,
                          SvgPicture.asset('images/queImg.svg')
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: isDesktop ? 16.0 : 8.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(widget.icons.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ImageButton(
                        imagePath: widget.icons[index],
                        onPressed: widget.onPressedActions[index],
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
