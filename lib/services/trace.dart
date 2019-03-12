import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:socialfish/models/trace.dart';

class TraceService {
  Future<Trace> fetchTraceData(String url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Trace.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to check Trace.');
    }
  }
}