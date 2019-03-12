import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:socialfish/utils/ui_data.dart';

class AttacksListService {

  Future<List> fetchAttacksList(String server, String token) async {
    final response = await http.get(server + UIData.apiGetSuccessfulAttacksList + token);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to check Attacks List.');
    }
  }

}