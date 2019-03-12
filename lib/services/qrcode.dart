import 'package:qrcode_reader/qrcode_reader.dart';

class QRCode {
  // Read QRCode
  Future<String> getQRCode() async {
    // https://pub.dartlang.org/packages/qrcode_reader
    Future<String> futureQRCode = new QRCodeReader()
        .setAutoFocusIntervalInMs(200) // default 5000
        .setForceAutoFocus(true) // default false
        .setTorchEnabled(true) // default false
        .setHandlePermissions(true) // default true
        .setExecuteAfterPermissionGranted(true) // default true
        .scan();

    return futureQRCode;
  }
}