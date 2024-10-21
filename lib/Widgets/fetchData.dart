import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:doc_text/doc_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:html/parser.dart' as htmlParser;

class FetchDataWidget extends StatefulWidget {
  final String apiUrl;

  const FetchDataWidget({Key? key, required this.apiUrl}) : super(key: key);

  @override
  _FetchDataWidgetState createState() => _FetchDataWidgetState();
}

class _FetchDataWidgetState extends State<FetchDataWidget> {
  String extractedData = '';

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  // Future<void> fetchData() async {
  //   String url = widget.apiUrl;
  //   print("fetchData url :: $url");

  //   var response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     if (url.endsWith('.doc')) {
  //       setState(() {
  //         extractedData = 'Failed to extract text from document.';
  //       });
  //     } else {
  //       var document = htmlParser.parse(utf8.decode(response.bodyBytes));
  //       setState(() {
  //         extractedData = parseHtml(document.body!.text);
  //         print("extractedData :: $extractedData");
  //         sendExamDetails(extractedData);
  //       });
  //     }
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

  // String parseHtml(String htmlString) {
  //   return htmlString.replaceAll(RegExp(r'<[^>]*>'), '');
  // }

  Future<void> sendExamDetails(String extractedData) async {
    List<String> lines = extractedData.split('\n');
    List<Map<String, dynamic>> examDetails = [];

    for (int i = 0; i < lines.length; i += 6) {
      String question = lines[i].substring(lines[i].indexOf('.') + 1).trim();
      String optionA = lines[i + 1].substring(3).trim();
      String optionB = lines[i + 2].substring(3).trim();
      String optionC = lines[i + 3].substring(3).trim();
      String optionD = lines[i + 4].substring(3).trim();
      String optionE = lines[i + 5].substring(3).trim();
      String correctAnswer = lines[i + 6].substring(3).trim();

      examDetails.add({
        'question': question,
        'option_a': optionA,
        'option_b': optionB,
        'option_c': optionC,
        'option_d': optionD,
        'option_e': optionE,
        'correct_answer': correctAnswer,
      });
    }

    Uri apiUrl = Uri.parse(
        'https://api.clickonlineacademy.ac.tz/v1/exam_details/createexamdetails');
    for (var examDetail in examDetails) {
      var response = await http.post(apiUrl, body: jsonEncode(examDetail));
      if (response.statusCode == 200) {
        print('Exam detail added successfully: ${response.body}');
      } else {
        print('Failed to add exam detail: ${response.statusCode}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(extractedData),
    );
  }
}
