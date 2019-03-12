import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:socialfish/models/statistic.dart';

class StatisticService {
  Future<Statistic> fetchStatistic(String url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Statistic.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to check Statistics.');
    }
  }
}