import 'package:flutter/material.dart';
import 'package:progress_hud/progress_hud.dart';

import 'package:socialfish/utils/ui_data.dart';

class Progress {
  static var progressConnecting = new ProgressHUD(
    backgroundColor: Colors.black12,
    color: Colors.white,
    containerColor: UIData.blueLogin,
    borderRadius: 5.0,
    text: "Connecting...",
  );

  static var progressLaunching = new ProgressHUD(
    backgroundColor: Colors.black12,
    color: Colors.white,
    containerColor: UIData.blueSwitch,
    borderRadius: 5.0,
    text: "Launching...",
  );

  static var progressSending = new ProgressHUD(
    backgroundColor: Colors.black12,
    color: Colors.white,
    containerColor: UIData.blueSendMail,
    borderRadius: 5.0,
    text: "Sending...",
  );

  static var progressLoading = new ProgressHUD(
    backgroundColor: Colors.black12,
    color: Colors.white,
    containerColor: UIData.blueSwitch,
    borderRadius: 5.0,
    text: "Loading...",
  );

}
