import 'dart:convert';

import 'package:yokai_admin/api/database.dart';
import 'package:yokai_admin/globalVariable.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GlobalApi {
  static Widget? selectedScreen;

  static String getSubjectNameById(String id) {
    for (var entry in subjectWithId.entries) {
      if (entry.value.toString() == id) {
        return entry.key;
      }
    }
    return 'Unknown';
  }

}
