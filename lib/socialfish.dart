import 'package:flutter/material.dart';

import 'package:socialfish/screens/login/login.dart';
import 'package:socialfish/utils/ui_data.dart';

class SocialFish extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      title: UIData.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Poppins",
      ),
      home: LoginPage(),
    );
  }
}