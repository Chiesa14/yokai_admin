import 'dart:typed_data';

import 'package:yokai_admin/api/local_storage.dart';
import 'package:yokai_admin/globalVariable.dart';
import 'package:yokai_admin/main.dart';
import 'package:yokai_admin/screens/flash%20cards/Flashcard%20API/flashcard_api.dart';
import 'package:yokai_admin/utils/constants.dart';

import 'package:yokai_admin/Widgets/new_button.dart';
import 'package:yokai_admin/Widgets/outline_button.dart';
import 'package:yokai_admin/Widgets/textfield.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/const.dart';
import 'package:yokai_admin/utils/text_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditFlashcardDialog extends StatefulWidget {
  final String flashcardId;
  final String question;
  final String questionImg;
  final String ansImg;
  final String srNo;
  final String flashcardDetailsId;
  final String answer;
  final bool isEdit;
  final Function refreshCallback;

  EditFlashcardDialog({
    this.flashcardId = "",
    this.isEdit = false,
    this.answer = '',
    this.question = '',
    this.questionImg = '',
    this.ansImg = '',
    this.srNo = '',
    this.flashcardDetailsId = '',
    required this.refreshCallback,
  });

  @override
  _EditFlashcardDialogState createState() => _EditFlashcardDialogState();
}

class _EditFlashcardDialogState extends State<EditFlashcardDialog> {
  bool _isLoading = false;
  bool _isAdding = false;

  String _queFileName = '';
  String _ansFileName = '';
  Uint8List? queFilePath;
  Uint8List? ansFilePath;
  bool _isQuestionSelected = false;
  bool _isAnswerSelected = false;
  TextEditingController _questionController = TextEditingController();
  TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      _questionController = TextEditingController(text: widget.question);
      _answerController = TextEditingController(text: widget.answer);
    }
  }

  @override
  void didUpdateWidget(covariant EditFlashcardDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isEdit != oldWidget.isEdit) {
      if (widget.isEdit) {
        _questionController.text = widget.question;
        _answerController.text = widget.answer;
      } else {
        _questionController.clear();
        _answerController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: Container(
            width: MediaQuery.of(context).size.width / 4,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        // FlashcardApi.imagesUrl.clear();
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                2.ph,
                _buildFileSelectionRow(
                  title: 'Question:',
                  fileName: _queFileName,
                  onTap: () {
                    // _selectFile(true);
                  },
                ),
                2.ph,
                TextFeildStyle(
                  maxLines: 5,
                  hintText: 'Enter question...',
                  controller: _questionController,
                ),
                2.ph,
                if (_isQuestionSelected)
                  _buildImagePreview(
                    filePath: queFilePath!,
                    fileName: _queFileName,
                    onClose: () {
                      setState(() {
                        queFilePath = null;
                        _queFileName = '';
                        _isQuestionSelected = false;
                        // _removeImageFromList(true);
                      });
                    },
                  ),
                3.ph,
                _buildFileSelectionRow(
                  title: 'Answer:',
                  fileName: _ansFileName,
                  onTap: () {
                    // _selectFile(false);
                  },
                ),
                2.ph,
                TextFeildStyle(
                  maxLines: 5,
                  hintText: 'Enter answer...',
                  controller: _answerController,
                ),
                2.ph,
                if (_isAnswerSelected)
                  _buildImagePreview(
                    filePath: ansFilePath!,
                    fileName: _ansFileName,
                    onClose: () {
                      setState(() {
                        ansFilePath = null;
                        _ansFileName = '';
                        _isAnswerSelected = false;
                        // _removeImageFromList(false);
                      });
                    },
                  ),
                2.ph,
                Row(
                  children: [
                    Expanded(
                      child: OutlineButton(
                        textSize: 14,
                        text: 'Delete',
                        color: headingOrange,
                        iconSvgPath: 'icons/delete.svg',
                        onPressed: () async {
                          // onDeleteFlashcard(context);
                          Navigator.pop(context);
                        },
                        width: MediaQuery.of(context).size.width / 5,
                      ),
                    ),
                    const SizedBox(
                      width: constants.defaultPadding * 4,
                    ),
                    _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : Expanded(
                            child: CustomButton(
                              textSize: 14,
                              isPopup: true,
                              width: MediaQuery.of(context).size.width / 5,
                              text: 'Save Changes',
                              onPressed: () {
                                // widget.isEdit
                                //     ? onEditFlashcard(context)
                                //     : onAddFlashcard(context);
                              },
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFileSelectionRow({
    required String title,
    required String fileName,
    required VoidCallback onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.normalSemiBold12,
        ),
        InkWell(
          onTap: onTap,
          child: Image.asset(
            'icons/gallery.png',
            height: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildImagePreview({
    required Uint8List filePath,
    required String fileName,
    required VoidCallback onClose,
  }) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.memory(
                  filePath,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: onClose,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    padding: EdgeInsets.all(2),
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          1.ph,
          // _isAdding
          //     ? CircularProgressIndicator(
          //         color: primaryColor,
          //       )
          //     : CustomButton(
          //         width: 200,
          //         text: 'Upload',
          //         onPressed: () {
          //           setState(() {
          //             _isAdding = true;
          //           });
          //           if (queFilePath!.isNotEmpty) {
          //             FlashcardApi.uploadImage(queFilePath!, _queFileName, true)
          //                 .then(
          //               (value) {
          //                 if (value) {
          //                   showSuccessSnackBar(
          //                       '', "Question Image uploaded successfully");
          //                   setState(() {
          //                     _isAdding = false;
          //                   });
          //                 } else {
          //                   showErrorSnackBar(
          //                       "Failed to upload Question Image");
          //                   setState(() {
          //                     _isAdding = false;
          //                   });
          //                 }
          //               },
          //             );
          //           } else if (ansFilePath!.isNotEmpty) {
          //             FlashcardApi.uploadImage(
          //                     ansFilePath!, _ansFileName, false)
          //                 .then(
          //               (value) {
          //                 if (value) {
          //                   showSuccessSnackBar(
          //                       '', "Answer Image uploaded successfully");
          //                   setState(() {
          //                     _isAdding = false;
          //                   });
          //                 } else {
          //                   showErrorSnackBar("Failed to upload Answer Image");
          //                   setState(() {
          //                     _isAdding = false;
          //                   });
          //                 }
          //               },
          //             );
          //           }
          //         },
          //       ),
        ],
      ),
    );
  }

  // void _removeImageFromList(bool isQuestion) {
  //   if (FlashcardApi.imagesUrl.isNotEmpty) {
  //     if (isQuestion) {
  //       FlashcardApi.imagesUrl.removeAt(0);
  //     } else {
  //       FlashcardApi.imagesUrl.removeAt(1);
  //     }
  //   }
  // }

  // Future<void> _selectFile(bool que) async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['jpeg', 'jpg', 'png'],
  //   );

  //   if (result != null) {
  //     PlatformFile file = result.files.first;
  //     print('Picked file: ${file.name}');
  //     if (que) {
  //       setState(() {
  //         _queFileName = file.name;
  //         queFilePath = file.bytes;
  //         _isQuestionSelected = true;
  //       });
  //     } else {
  //       setState(() {
  //         _ansFileName = file.name;
  //         ansFilePath = file.bytes;
  //         _isAnswerSelected = true;
  //       });
  //     }
  //   } else {
  //     print('No file picked.');
  //   }
  // }

  // void onAddFlashcard(BuildContext context) async {
  //   String errorMessage = '';

  //   if (_questionController.text.isEmpty) {
  //     errorMessage = "Question cannot be empty";
  //   } else if (_answerController.text.isEmpty) {
  //     errorMessage = "Answer cannot be empty";
  //   }

  //   if (errorMessage.isNotEmpty) {
  //     showErrorSnackBar(errorMessage);
  //     return;
  //   }

  //   setState(() {
  //     _isLoading = true;
  //   });
  //   if (queFilePath != null && queFilePath!.isNotEmpty) {
  //     setState(() {
  //       _isAdding = true;
  //     });
  //     bool questionUploadSuccess =
  //         await FlashcardApi.uploadImage(queFilePath!, _queFileName, true);
  //     if (questionUploadSuccess) {
  //       showSuccessSnackBar('', "Question Image uploaded successfully");
  //     } else {
  //       showErrorSnackBar("Failed to upload Question Image");
  //     }
  //     setState(() {
  //       _isAdding = false;
  //     });
  //   }
  //   if (ansFilePath != null && ansFilePath!.isNotEmpty) {
  //     setState(() {
  //       _isAdding = true;
  //     });
  //     bool answerUploadSuccess =
  //         await FlashcardApi.uploadImage(ansFilePath!, _ansFileName, false);
  //     if (answerUploadSuccess) {
  //       showSuccessSnackBar('', "Answer Image uploaded successfully");
  //     } else {
  //       showErrorSnackBar("Failed to upload Answer Image");
  //     }
  //     setState(() {
  //       _isAdding = false;
  //     });
  //   }

  //   if (!_isAdding) {
  //     if ((queFilePath != null && queFilePath!.isNotEmpty) ||
  //         (ansFilePath != null && ansFilePath!.isNotEmpty)) {
  //       await Future.delayed(Duration(seconds: 1));
  //       if (FlashcardApi.imagesUrl.isNotEmpty) {
  //         bool success = await FlashcardApi.createflashcarddetails(
  //           context,
  //           {
  //             "flashcard_id": widget.flashcardId,
  //             "question": _questionController.text,
  //             "question_image": FlashcardApi.imagesUrl.isNotEmpty
  //                 ? FlashcardApi.imagesUrl[0]
  //                 : null,
  //             "answer": _answerController.text,
  //             "answer_image": FlashcardApi.imagesUrl.length == 2
  //                 ? FlashcardApi.imagesUrl[1]
  //                 : null
  //           },
  //         );

  //         if (success) {
  //           showSuccessSnackBar(
  //             '',
  //             "Flash card Added",
  //           );
  //           widget.refreshCallback();
  //           Navigator.pop(context);
  //         } else {
  //           showErrorSnackBar("Error occurred");
  //         }
  //       } else {
  //         showErrorSnackBar("Images not uploaded successfully");
  //       }
  //     } else {
  //       bool success = await FlashcardApi.createflashcarddetails(
  //         context,
  //         {
  //           "flashcard_id": widget.flashcardId,
  //           "question": _questionController.text,
  //           "answer": _answerController.text,
  //         },
  //       );

  //       if (success) {
  //         showSuccessSnackBar(
  //           '',
  //           "Flash card Added",
  //         );
  //         widget.refreshCallback();
  //         Navigator.pop(context);
  //       } else {
  //         showErrorSnackBar("Error occurred");
  //       }
  //     }
  //   }
  //   setState(() {
  //     _questionController.clear();
  //     _answerController.clear();
  //     FlashcardApi.imagesUrl.clear();
  //   });
  // }

  // void onEditFlashcard(BuildContext context) async {
  //   String errorMessage = '';
  //   if (_questionController.text.isEmpty) {
  //     errorMessage = "Question cannot be empty";
  //   } else if (_answerController.text.isEmpty) {
  //     errorMessage = "Answer cannot be empty";
  //   }

  //   if (errorMessage.isNotEmpty) {
  //     showErrorSnackBar(errorMessage);
  //     return;
  //   }

  //   setState(() {
  //     _isLoading = true;
  //   });

  //   if (queFilePath != null && queFilePath!.isNotEmpty) {
  //     setState(() {
  //       _isAdding = true;
  //     });
  //     bool questionUploadSuccess =
  //         await FlashcardApi.uploadImage(queFilePath!, _queFileName, true);
  //     if (questionUploadSuccess) {
  //       showSuccessSnackBar('', "Question Image uploaded successfully");
  //     } else {
  //       showErrorSnackBar("Failed to upload Question Image");
  //     }
  //     setState(() {
  //       _isAdding = false;
  //     });
  //   } else if (ansFilePath != null && ansFilePath!.isNotEmpty) {
  //     setState(() {
  //       _isAdding = true;
  //     });
  //     // Upload answer image
  //     bool answerUploadSuccess =
  //         await FlashcardApi.uploadImage(ansFilePath!, _ansFileName, false);
  //     if (answerUploadSuccess) {
  //       showSuccessSnackBar('', "Answer Image uploaded successfully");
  //     } else {
  //       showErrorSnackBar("Failed to upload Answer Image");
  //     }
  //     setState(() {
  //       _isAdding = false;
  //     });
  //   }

  //   if (!_isAdding) {
  //     if ((queFilePath != null && queFilePath!.isNotEmpty) ||
  //         (ansFilePath != null && ansFilePath!.isNotEmpty)) {
  //       await Future.delayed(Duration(seconds: 1));
  //       if (FlashcardApi.imagesUrl.isNotEmpty) {
  //         bool success = await FlashcardApi.updateflashcarddetails(
  //           context,
  //           {
  //             "flashcard_id": widget.flashcardId,
  //             "sr_no": widget.srNo,
  //             "question": _questionController.text,
  //             "question_image": FlashcardApi.imagesUrl[0].isNotEmpty
  //                 ? FlashcardApi.imagesUrl[0]
  //                 : widget.questionImg,
  //             "answer": _answerController.text,
  //             "answer_image": FlashcardApi.imagesUrl.length == 2
  //                 ? FlashcardApi.imagesUrl[1]
  //                 : widget.ansImg
  //           },
  //           widget.flashcardDetailsId,
  //         );

  //         if (success) {
  //           showSuccessSnackBar(
  //             '',
  //             "Flash card Edited",
  //           );
  //           widget.refreshCallback();
  //           Navigator.pop(context);
  //         } else {
  //           showErrorSnackBar("Error occurred");
  //         }
  //       } else {
  //         showErrorSnackBar("Images not uploaded successfully");
  //       }
  //     } else {
  //       bool success = await FlashcardApi.updateflashcarddetails(
  //         context,
  //         {
  //           "flashcard_id": widget.flashcardId,
  //           "sr_no": widget.srNo,
  //           "question": _questionController.text,
  //           "answer": _answerController.text,
  //         },
  //         widget.flashcardDetailsId,
  //       );

  //       if (success) {
  //         showSuccessSnackBar(
  //           '',
  //           "Flash card Edited",
  //         );
  //         widget.refreshCallback();
  //         Navigator.pop(context);
  //         setState(() {
  //           FlashcardApi.imagesUrl.clear();
  //         });
  //       } else {
  //         showErrorSnackBar("Error occurred");
  //       }
  //     }
  //   }
  // }

  // void onDeleteFlashcard(BuildContext context) async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   bool success = await FlashcardApi.deleteflashcarddetails(
  //       context, widget.flashcardDetailsId);

  //   if (success) {
  //     showSuccessSnackBar(
  //       '',
  //       "Flash card Deleted",
  //     );
  //     widget.refreshCallback();
  //     Navigator.pop(context);
  //   } else {
  //     showErrorSnackBar("Error occured");
  //   }
  // }

}
