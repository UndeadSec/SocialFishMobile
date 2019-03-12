import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:socialfish/screens/login/login_validate.dart';
import 'package:socialfish/screens/widgets/dialog.dart';
import 'package:socialfish/utils/ui_data.dart';
import 'package:socialfish/services/qrcode.dart';

class LoginFields extends StatelessWidget {

  final bool autoValidate;
  final TextEditingController server;
  final TextEditingController token;

  const LoginFields({
    Key key,
    this.autoValidate,
    this.server,
    this.token
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              controller: server,
              keyboardType: TextInputType.url,
              autovalidate: autoValidate,
              maxLines: 1,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.dns),
                hintText: "http://0.0.0.0:5000",
                fillColor: Colors.white,
                labelText: "SERVER",
              ),
              validator: LoginValidate.validateServer,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
            child: TextFormField(
              controller: token,
              autovalidate: autoValidate,
              maxLines: 1,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(FontAwesomeIcons.qrcode),
                  tooltip: "Scan QRCode",
                  onPressed: () {
                    QRCode().getQRCode().then((value){
                      token.text = value;
                    }).catchError((e){
                      DialogMsg().dialogError(context, UIData.errorMsgLogin + " \n\nLog: " + e.toString());
                    });
                  },
                ),
                labelText: "TOKEN",
              ),
              validator: LoginValidate.validateToken,
            ),
          ),
        ],
      ),
    );
  }
}