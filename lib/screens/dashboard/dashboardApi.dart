import 'dart:convert';

import 'package:yokai_admin/api/database.dart';
import 'package:yokai_admin/globalVariable.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DashboardApi {
  static RxList<String> topic = <String>[
    'No. Of Student',
    'No. Of Teachers',
    'No. of Subjects across standards',
    'Final exams added overall',
    'Topical Exams added overall',
    'Other Exams added',
    'Lesson videos added overall',
    'Flashcard collections overall',
    'Lesson Plans pp'
  ].obs;
  // static RxString selectedSchoolGrage = 'Grade'.obs;
  static RxString noOfStudent = '00'.obs;
  static RxString noOfTeachers = '00'.obs;
  static RxString noOfSubjectsAcrossStandards = '00'.obs;
  static RxString finalExamsAdded = '00'.obs;
  static RxString topicalExamsAdded = topicalexamTitles.length.toString().obs;
  static RxString practiceTestsAdded = '00'.obs;
  static RxString lessonVideosTestsAdded = '00'.obs;
  static RxString flashcardsCollectionsAdded = '00'.obs;
  static RxString lessonPlansPp = '00'.obs;
  
}
