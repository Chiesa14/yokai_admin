import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/text_styles.dart';

class CustomInfoField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType inputType;
  final bool obscureText;
  final bool enable;
  final prefixIcon;
  final sufixIcon;
  final String obscuringCharacter;
  final int maxCharacters;
  final int maxLines;
  final bool counter;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final double? height;
  final int? length;
  final String? suffixText;
  final List<TextInputFormatter>? inputFormatters;

  CustomInfoField(
      {Key? key,
      required this.label,
      this.onChanged,
      required this.controller,
      this.hint = '',
      this.inputType = TextInputType.text,
      this.obscureText = false,
      this.enable = true,
      this.prefixIcon,
      this.sufixIcon,
      this.obscuringCharacter = ".",
      this.maxCharacters = 200,
      this.maxLines = 1,
      this.counter = false,
      this.maxLength,
      this.height,
      this.length,
      this.suffixText,
        this.inputFormatters
      })
      : super(key: key);

  @override
  _CustomInfoFieldState createState() => _CustomInfoFieldState();
}

class _CustomInfoFieldState extends State<CustomInfoField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  int _characterCount = 0;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    _characterCount = widget.controller.text.length;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double padding = screenWidth > 600 ? 24 : 14;
    double fontSize = screenWidth > 600 ? 16 : 14;
    double hintFontSize = screenWidth > 600 ? 16 : 14;
    return Container(
      width: double.infinity,
      height: widget.height,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: textStyle.labelStyle,
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: _focusNode.hasFocus ? primaryColor : Color(0xFFE4E8E9),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              shadows: [
                if (_isFocused)
                  BoxShadow(
                    color: Color(0xFFE2B2F8),
                    blurRadius: 0,
                    offset: Offset(0, 0),
                    spreadRadius: 3,
                  )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    minLines: widget.maxLines,
                    maxLines: widget.maxLines,
                    focusNode: _focusNode,
                    enabled: widget.enable,
                    controller: widget.controller,
                    keyboardType: widget.maxLines > 1
                        ? TextInputType.multiline
                        : TextInputType.text,
                    obscureText: widget.obscureText,
                    onChanged: widget.onChanged,
                    textInputAction: widget.maxLines > 1
                        ? TextInputAction.newline
                        : TextInputAction.done,
                    onSubmitted: (value) {
                      if (widget.maxLines > 1) {
                        FocusScope.of(context).nextFocus();
                      } else {
                        _focusNode.unfocus();
                      }
                    },maxLength: widget.maxLength,
                    inputFormatters: widget.inputFormatters,
                    decoration: InputDecoration(
                      suffixText: widget.suffixText,
                      suffixIcon: widget.sufixIcon,
                      prefixIcon: widget.prefixIcon,
                      hintText: widget.hint,
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 111, 128, 130),
                        fontSize: hintFontSize,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                      ),
                      counterText: '',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 12,
                      ),
                      alignLabelWithHint: true,

                      // counterText: widget.counter
                      //     ? '$_characterCount/${widget.maxCharacters}'
                      //     : '',
                    ),
                    style: TextStyle(
                      color: Color(0xFF556365),
                      fontSize: (widget.obscureText == true) ? 30 : fontSize,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: Text("${widget.length}/${widget.maxCharacters}"),
          // ),
        ],
      ),
    );
  }
}
