import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:socialfish/models/auth.dart';

class AuthService {
  Future<Auth> fetchAuth(String url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Auth.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to check Auth.');
    }
  }
}