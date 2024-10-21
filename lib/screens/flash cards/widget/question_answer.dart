import 'package:yokai_admin/api/database.dart';
import 'package:yokai_admin/utils/const.dart';
import 'package:yokai_admin/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomQuestionAnswer extends StatefulWidget {
  final String question;
  final String answer;
  final String queimagePath;
  final String ansimagePath;
  final void Function()? onTap;

  CustomQuestionAnswer({
    this.question = '',
    this.answer = '',
    this.queimagePath = '',
    this.ansimagePath = '',
    this.onTap,
  });

  @override
  _CustomQuestionAnswerState createState() => _CustomQuestionAnswerState();
}

class _CustomQuestionAnswerState extends State<CustomQuestionAnswer> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;
        return FractionallySizedBox(
          widthFactor: isSmallScreen ? 1.0 : 1 / 3,
          child: Card(
            margin: EdgeInsets.all(8.0),
            elevation: 1.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: Color.fromRGBO(143, 192, 209, 1),
                width: 1,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 12.0 : 16.0,
                vertical: isSmallScreen ? 8.0 : 16.0,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question:',
                          style: AppTextStyle.normalSemiBold12,
                        ),
                        if (widget.onTap != null)
                          InkWell(
                            onTap: widget.onTap,
                            child: Image.asset('icons/edit_name_icon.png'),
                          ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      widget.question,
                      style: AppTextStyle.questionAnswer,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    1.ph,
                    if (widget.queimagePath.isNotEmpty &&
                        widget.queimagePath != 'string' &&
                        widget.queimagePath != "")
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: widget.queimagePath.contains('.svg')
                                      ? SvgPicture.network(
                                          widget.queimagePath,
                                          height: 100,
                                        )
                                      : Image.network(
                                          '',
                                          fit: BoxFit.contain,
                                        ),
                                );
                              },
                            );
                          },
                          child: widget.queimagePath.contains('.svg')
                              ? SvgPicture.network(
                                  widget.queimagePath,
                                  height: 100,
                                )
                              : Image.network(
                                  '',
                                  height: 60,
                                ),
                        ),
                      ),
                    SizedBox(height: 8.0),
                    Text(
                      'Answer:',
                      style: AppTextStyle.normalSemiBold12,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      widget.answer,
                      textAlign: TextAlign.left,
                      style: AppTextStyle.questionAnswer,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    1.ph,
                    if (widget.ansimagePath.isNotEmpty &&
                        widget.ansimagePath != 'string')
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: widget.ansimagePath.contains('.svg')
                                      ? SvgPicture.network(
                                          widget.ansimagePath,
                                          height: 100,
                                        )
                                      : Image.network(
                                          '',
                                          fit: BoxFit.contain,
                                        ),
                                );
                              },
                            );
                          },
                          child: widget.ansimagePath.contains('.svg')
                              ? SvgPicture.network(
                                  widget.ansimagePath,
                                  height: 100,
                                )
                              : Image.network(
                                  '',
                                  height: 60,
                                ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
