import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:socialfish/utils/ui_data.dart';

class SendMailService {

  Future<String> createRequestSendMail(String server, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();

    HttpClientRequest request = await httpClient.postUrl(Uri.parse(server + UIData.apiSendMail));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));

    HttpClientResponse response = await request.close();

    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();

    return reply;
  }

}