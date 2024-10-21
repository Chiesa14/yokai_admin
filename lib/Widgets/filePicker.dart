import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerWidget extends StatefulWidget {
  final String svgAsset;
  final String uploadText;
  final String fileTypeText;
  final Color backgroundColor;
  final Color borderColor;
  final Color svgColor;
  final TextStyle uploadTextStyle;
  final TextStyle fileTypeTextStyle;

  const FilePickerWidget({
    Key? key,
    required this.svgAsset,
    required this.uploadText,
    required this.fileTypeText,
    required this.backgroundColor,
    required this.borderColor,
    required this.svgColor,
    required this.uploadTextStyle,
    required this.fileTypeTextStyle,
  }) : super(key: key);

  @override
  _FilePickerWidgetState createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  String? _fileName;

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      print('Picked file: ${file.name}');
      setState(() {
        _fileName = file.name;
      });
    } else {
      print('No file picked.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.borderColor),
      ),
      child: InkWell(
        onTap: _selectFile,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              widget.svgAsset,
              color: widget.svgColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.uploadText,
                  style: widget.uploadTextStyle,
                ),
                Text(
                  widget.fileTypeText,
                  style: widget.fileTypeTextStyle,
                ),
              ],
            ),
            if (_fileName != null) ...[
              SizedBox(height: 5),
              Text(
                'Selected file: $_fileName',
                style: widget.uploadTextStyle.copyWith(color: Colors.green),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
