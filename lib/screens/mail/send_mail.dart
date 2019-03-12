import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:socialfish/utils/ui_data.dart';
import 'package:socialfish/screens/mail/mail_fields.dart';
import 'package:socialfish/screens/mail/mail_validate.dart';
import 'package:socialfish/screens/widgets/progress.dart';
import 'package:socialfish/utils/shared_preferences.dart';
import 'package:socialfish/screens/widgets/dialog.dart';
import 'package:socialfish/services/send_mail.dart';

class SendMail extends StatefulWidget {
  @override
  _SendMailState createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {

  // Create a controller for input fields
  final subject = new TextEditingController();
  final email = new TextEditingController();
  final password = new TextEditingController();
  final recipient = new TextEditingController();
  final body = new TextEditingController();
  final smtp = new TextEditingController();
  final port = new TextEditingController();

  // Validate
  bool _autoValidate = false;

  bool _validateFields() {
    setState(() {
      _autoValidate = true;
    });

    if (MailValidate.validateSubject(subject.text) == null &&
        MailValidate.validateEmail(email.text) == null &&
        MailValidate.validatePassword(password.text) == null &&
        MailValidate.validateRecipient(recipient.text) == null &&
        MailValidate.validateBody(body.text) == null &&
        MailValidate.validateSMTP(smtp.text) == null &&
        MailValidate.validatePort(port.text) == null
    ) {
      return true;
    }
    return false;
  }

  String serverFromSharedPreferences;
  String tokenFromSharedPreferences;

  Map dataSendMail;

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

    SharedPreferencesService().getEmailFromSharedPreferences().then((value){
      email.text = value;
    }).catchError((e){
      DialogMsg().dialogError(context, UIData.errorLoadSharedPreferences +
          e.toString());
    });

    SharedPreferencesService().getSMTPFromSharedPreferences().then((value){
      smtp.text = value;
    }).catchError((e){
      DialogMsg().dialogError(context, UIData.errorLoadSharedPreferences +
          e.toString());
    });

    SharedPreferencesService().getPortFromSharedPreferences().then((value){
      port.text = value;
    }).catchError((e){
      DialogMsg().dialogError(context, UIData.errorLoadSharedPreferences +
          e.toString());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(247, 247, 247, 1.0),
        appBar: _buildAppbar(),
        body: _buildBody()
    );
  }

  Widget _buildAppbar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        color: Colors.black,
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(Icons.arrow_back, color: Colors.black),
      ),
      title: Text('Send Mail', style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildBody() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      children: <Widget>[
        MailFields(
          autoValidate: _autoValidate,
          body: body,
          email: email,
          password: password,
          port: port,
          recipient: recipient,
          smtp: smtp,
          subject: subject,
        ),

        Text('* Required fields', style: Theme.of(context).textTheme.caption),

        _buildButtonSendMail()
      ],
    );
  }

  Widget _buildButtonSendMail() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: FloatingActionButton.extended(
        elevation: 4.0,
        backgroundColor: UIData.blueSendMail,
        icon: const Icon(Icons.send),
        label: const Text('Send'),
        onPressed: () {
          if(_validateFields()){

            String portContent;

            if (port.text.isEmpty) {
              portContent = "";
            } else {
              portContent = port.text.toString();
            }

            dataSendMail = {
              "key": tokenFromSharedPreferences,
              "subject" : subject.text.toString(),
              "email" : email.text.toLowerCase(),
              "password" : password.text.toString(),
              "recipient" : recipient.text.toLowerCase(),
              "body" : body.text.toString(),
              "smtp" : smtp.text.toLowerCase(),
              "port" : portContent
            };

            showDialog(context: context, child: Progress.progressSending);

            SendMailService().createRequestSendMail(
                serverFromSharedPreferences,
                dataSendMail
            ).then((value){
              Navigator.pop(context);

              Map<String, dynamic> valueParse = jsonDecode(value);

              if (valueParse['status'] == "ok") {

                showSimpleNotification(context,
                    Text("Request Successfully Sent"),
                    autoDismiss: true,
                    background: UIData.blueSendMail
                );

                SharedPreferencesService().setEmailSharedPreferences(email.text.toString());
                SharedPreferencesService().setSMTPSharedPreferences(smtp.text.toString());
                SharedPreferencesService().setPortSharedPreferences(port.text.toString());

                Navigator.pop(context);

              } else if (valueParse['status'] == "bad"){
                DialogMsg().dialogError(context, UIData.errorFailedSendMail + " \n\nLog: " + valueParse['error']);
              }

            }).catchError((error){
              DialogMsg().dialogError(context, UIData.errorFailedSendMail + " \n\nLog: " + error.toString());
            });

          }
        },
      ),
    );
  }
}
