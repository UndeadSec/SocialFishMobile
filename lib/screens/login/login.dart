import 'package:flutter/material.dart';

import 'package:socialfish/screens/widgets/progress.dart';
import 'package:socialfish/services/auth.dart';
import 'package:socialfish/utils/ui_data.dart';
import 'package:socialfish/screens/login/login_fields.dart';
import 'package:socialfish/screens/widgets/dialog.dart';
import 'package:socialfish/screens/dashboard/dashboard.dart';
import 'package:socialfish/utils/shared_preferences.dart';
import 'package:socialfish/screens/login/login_validate.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: _buildStack()
    );
  }

  @override
  void initState() {
    super.initState();

    SharedPreferencesService().getServerFromSharedPreferences().then((value){
      server.text = value;
    }).catchError((e){
      DialogMsg().dialogError(context, UIData.errorLoadSharedPreferences +
          e.toString());
    });

    SharedPreferencesService().getTokenFromSharedPreferences().then((value){
      token.text = value;
    }).catchError((e){
      DialogMsg().dialogError(context, UIData.errorLoadSharedPreferences +
          e.toString());
    });
  }

  // Input fields controllers
  final server = TextEditingController();
  final token = TextEditingController();

  // Validate methods
  bool _autoValidate = false;

  bool _checkValidator() {
    setState(() {
      _autoValidate = true;
    });

    if (LoginValidate.validateServer(server.text) == null &&
        LoginValidate.validateToken(token.text) == null) {
      return true;
    }
    return false;
  }

  Widget _buildStack() {
    return Stack(fit: StackFit.expand, children: <Widget>[
      Image(
        image: AssetImage("assets/images/background.jpeg"),
        fit: BoxFit.cover,
        colorBlendMode: BlendMode.darken,
        color: Colors.black87,
      ),
      Theme(
        data: ThemeData(
          brightness: Brightness.dark,
          accentColor: UIData.blueLogin,
        ),
        child: Center(
          child: _buildBody(),
        ),
      ),
    ]);
  }

  Widget _buildBody() {
    return DropdownButtonHideUnderline(
      child: SafeArea(
        top: false,
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
          children: <Widget>[loginBody()],
        ),
      ),
    );
  }

  Widget loginBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
//        loginHeader(),
        SizedBox(height: 60.0),
        loginFields()
      ],
    );
  }

  Widget loginHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset("assets/images/logo.png", height: 240.0),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          height: 5.0,
        ),
      ],
    );
  }

  Widget _buildButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.all(16.0),
        child: Text("CONNECT", style: TextStyle(color: Colors.white),
        ),
        color: UIData.blueLogin,
        onPressed: () {
          if (_checkValidator()) {
            showDialog(context: context, child: Progress.progressLoading);

            AuthService().fetchAuth(server.text + UIData.apiCheckAuth + token.text).then((value) {
              Navigator.pop(context);

              if (value.status == "ok") {

                SharedPreferencesService().setServerSharedPreferences(server.text.toString());
                SharedPreferencesService().setTokenSharedPreferences(token.text.toString());

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Dashboard(server: server.text.toString(), token: token.text.toString(),),
                  ),
                );

              } else {
                DialogMsg().dialogError(context, UIData.errorMsgLogin);
              }

            }).catchError((e) {
              Navigator.pop(context);
              DialogMsg().dialogError(context, UIData.errorMsgLogin + " \n\nLog: " + e.toString());
            });
          } else {
            // Field don't be valid
          }
        },
      ),
    );
  }

  Widget loginFields() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          LoginFields(
            autoValidate: _autoValidate,
            server: server,
            token: token,
          ),
          SizedBox(height: 30.0),
          _buildButton(),
          SizedBox(height: 35.0),
          Text("Copyright © " + UIData.yearCopyright + " UndeadSec.", style: TextStyle(color: Colors.white70)),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
