import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:socialfish/utils/ui_data.dart';
import 'package:socialfish/screens/launch_attack/launch_attack_validate.dart';
import 'package:socialfish/services/launch_attack.dart';
import 'package:socialfish/utils/shared_preferences.dart';
import 'package:socialfish/screens/widgets/dialog.dart';
import 'package:socialfish/screens/widgets/progress.dart';

class LaunchAttack extends StatefulWidget {
  @override
  _LaunchAttackState createState() => _LaunchAttackState();
}

class _LaunchAttackState extends State<LaunchAttack> {
  final FocusNode textFieldFocusNode = FocusNode();

  Future<bool> _onWillPop() {
    FocusScope.of(context).requestFocus(new FocusNode());
    return Future.value(true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _focusOnTextField();
  }

  @override
  void dispose() {
    textFieldFocusNode.dispose();
    super.dispose();
  }

  // Create a controller for input fields
  final clone = new TextEditingController();
  final redirection = new TextEditingController();

  bool _autoValidate = false;
  bool _switchCustomHTML = false;
  bool _switchBeEF = false;

  String serverFromSharedPreferences;
  String tokenFromSharedPreferences;

  Map dataPostAttack;

  bool _validateFields() {
    setState(() {
      _autoValidate = true;
    });

    if (_switchCustomHTML){
      if (redirection.text.isEmpty) {
        return false;
      } else return true;
    } else {
      if (clone.text.trim().isEmpty || redirection.text.isEmpty) {
        return false;
      } else  return true;
    }

  }

  @override
  void initState() {
    SharedPreferencesService().getServerFromSharedPreferences().then((server){
      setState(() {
        serverFromSharedPreferences = server;
      });
    }).catchError((e){
      DialogMsg().dialogError(context, UIData.errorLoadSharedPreferences +
          e.toString());
    });

    SharedPreferencesService().getTokenFromSharedPreferences().then((token){
      setState(() {
        tokenFromSharedPreferences = token;
      });
    }).catchError((e){
      DialogMsg().dialogError(context, UIData.errorLoadSharedPreferences +
          e.toString());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Launch Attack',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          children: <Widget>[
            Container(
              child: TextFormField(
                enabled: !_switchCustomHTML,
                focusNode: textFieldFocusNode,
                textCapitalization: TextCapitalization.none,
                style: TextStyle(fontSize: 18.0, color: Colors.black),
                autovalidate: _autoValidate,
                controller: clone,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  suffixIcon: Icon(FontAwesomeIcons.clone),
                  labelText: '* Clone',
                ),
                validator: LaunchAttackValidate.validateClone,
              ),
            ),
            Container(
              child: TextFormField(
                textCapitalization: TextCapitalization.none,
                style: TextStyle(fontSize: 18.0, color: Colors.black),
                autovalidate: _autoValidate,
                controller: redirection,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  suffixIcon: Icon(FontAwesomeIcons.sitemap),
                  labelText: "* Redirection",
                ),
                validator: LaunchAttackValidate.validateRedirection,
              ),
            ),
            Container(
              child: SwitchListTile(
                  value: _switchCustomHTML,
                  activeColor: UIData.blueSwitch,
                  title: Text("Custom HTML"),
                  subtitle: Text("Use a custom HTML page"),
                  onChanged: (bool value) {
                    setState(() {
                      _switchCustomHTML = value;
                      clone.text = "";
                    });
                  }),
            ),
            Container(
              child: SwitchListTile(
                  value: _switchBeEF,
                  activeColor: UIData.blueSwitch,
                  title: Text("Enable BeEF"),
                  subtitle: Text("Inject BeEF-XSS"),
                  onChanged: (bool value) {
                    setState(() {
                      _switchBeEF = value;
                    });
                  }),
            ),
            SizedBox(height: 10.0),
            Text('* Required fields',
                style: Theme.of(context).textTheme.caption),
            SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Hero(
                tag: 'launch_attack',
                child: FloatingActionButton.extended(
                  elevation: 4.0,
                  backgroundColor: Colors.black,
                  icon: const Icon(FontAwesomeIcons.bolt),
                  label: const Text('Launch'),
                  onPressed: () {
                    if (_validateFields()){

                      if(_switchCustomHTML){

                        dataPostAttack = {
                          "key": tokenFromSharedPreferences,
                          "red": redirection.text.trim().toString(),
                          "sta": "custom",
                          "beef": _switchBeEF ? "yes" : "no"
                        };

                      } else {

                        dataPostAttack = {
                          "key": tokenFromSharedPreferences,
                          "url": clone.text.trim().toString(),
                          "red": redirection.text.trim().toString(),
                          "sta": "clone",
                          "beef": _switchBeEF ? "yes" : "no"
                        };

                      }

                      showDialog(context: context, child: Progress.progressLaunching);

                      LaunchAttackService().sendRequestLaunchAttack(
                          serverFromSharedPreferences,
                          dataPostAttack
                      ).then((value){

                        // Decode response
                        Map<String, dynamic> valueParse = jsonDecode(value);

                        if (valueParse['status'] == "ok") {
                          Navigator.pop(context);

                          showSimpleNotification(context,
                              Text("Attack Launched Successfully"),
                              autoDismiss: true,
                              background: Colors.green
                          );

                          Navigator.pop(context);
                        } else {
                          DialogMsg().dialogError(context, UIData.errorFailedLaunchAttack);
                        }

                      }).catchError((e){
                        Navigator.pop(context);
                        DialogMsg().dialogError(context, UIData.errorFailedLaunchAttack + " \n\nLog: " + e.toString());
                      });

                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _focusOnTextField() async {
    await Future.delayed(Duration(milliseconds: 300));
    FocusScope.of(context).requestFocus(textFieldFocusNode);
  }
}
