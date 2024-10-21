import 'dart:convert';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:yokai_admin/api/database.dart';
import 'package:yokai_admin/globalVariable.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TopicalexamApi {
  static RxString topicalexamRoute = '0'.obs;
  
}
