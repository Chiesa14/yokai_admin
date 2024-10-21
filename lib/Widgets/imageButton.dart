import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageButton extends StatefulWidget {
  final String imagePath;
  final VoidCallback? onPressed;

  const ImageButton({
    Key? key,
    required this.imagePath,
    this.onPressed,
  }) : super(key: key);

  @override
  _ImageButtonState createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: widget.imagePath.endsWith('svg')
          ? SvgPicture.asset(
              widget.imagePath,
              color: _isPressed ? Colors.grey : null,
              height: 40,
              width: 40,
            )
          : Image.asset(
              widget.imagePath,
              color: _isPressed ? Colors.grey : null,
              height: 40,
              width: 40,
            ),
    );
  }
}
