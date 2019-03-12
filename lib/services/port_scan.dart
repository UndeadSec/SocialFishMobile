import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:socialfish/utils/ui_data.dart';

class PortScanService {

  Future<List> fetchPortScan(String server, String token, String ip) async {
    final response = await http.get(server + UIData.apiGetPortScan + token + "/$ip");

    print(server + UIData.apiGetPortScan + token + "/$ip");

    print(response.body.toString());

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to check Port Scan.');
    }
  }

}