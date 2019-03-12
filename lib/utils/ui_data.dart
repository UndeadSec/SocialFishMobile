import 'dart:ui';

import 'package:flutter/material.dart';

class UIData {

  // Strings
  static const String appName = "SocialFish";
  static const String appBarTitle = "SocialFish";
  static const String appVersion = "1.0";
  static const String yearCopyright = "2019";

  // API
  static const String apiCheckAuth = "/api/checkKey/";
  static const String apiCheckStatistic = "/api/statistics/";
  static const String apiLaunchAttack = "/api/configure";
  static const String apiSendMail = "/api/mail";
  static const String apiGetSuccessfulAttacksList = "/api/getJson/";
  static const String apiGetTrace = "/api/trace/";
  static const String apiGetPortScan = "/api/scansf/";
  static const String apiGetInfoReport = "/api/infoReport/";

  // Colors
  static const Color blueLogin = Color.fromRGBO(30, 182, 218, 1.0);
  static const Color blueSwitch = Color.fromRGBO(0, 162, 185, 1.0);
  static const Color blueSendMail = Color.fromRGBO(61, 60, 219, 1.0);
  static const Color blueGenerateReport = Color.fromRGBO(30, 131, 147, 1.0);

  // Msg
  static const String errorMsgLogin = "Could not authenticate."
      "\nMake sure your credentials and port are correct, check if server are running"
      " or check if you have an internet connection.";

  static const String errorLoadSharedPreferences =
      "Error to load Shared Preferences";

  static const String errorFailedLaunchAttack =
      "Failed to Launch Attack.";

  static const String errorFailedSendMail =
      "Failed to Send Mail.";

  static const String errorFailedToLoadTraceInformation =
      "Failed to load Trace IP information.";

  static const String errorFailedToLoadPortScanInformation =
      "Failed to load Port Scan information.";

  static const String errorFailedToOpenGoogleMapsAndroid =
      "Failed to open Google Maps.\nCheck if Google Maps is installed.";

  static const String errorScanQRCode =
      "Failed to scan the QRCode.";

}
