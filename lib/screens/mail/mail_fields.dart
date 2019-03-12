import 'package:flutter/material.dart';

import 'package:socialfish/screens/mail/mail_validate.dart';

class MailFields extends StatelessWidget {

  final bool autoValidate;
  final TextEditingController subject;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController recipient;
  final TextEditingController body;
  final TextEditingController smtp;
  final TextEditingController port;

  const MailFields({
    Key key,
    this.autoValidate,
    this.subject,
    this.email,
    this.password,
    this.recipient,
    this.body,
    this.smtp,
    this.port,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          Container(
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              autovalidate: autoValidate,
              controller: subject,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  labelText: "* Subject",
                  hintText: "Subject Text"),
              validator: MailValidate.validateSubject,
            ),
          ),

          SizedBox(height: 10.0),

          Container(
            child: TextFormField(
              textCapitalization: TextCapitalization.none,
              autovalidate: autoValidate,
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  labelText: "* Email",
                  hintText: "Enter your Email"),
              validator: MailValidate.validateEmail,
            ),
          ),

          SizedBox(height: 10.0),

          Container(
            child: TextFormField(
              textCapitalization: TextCapitalization.none,
              autovalidate: autoValidate,
              controller: password,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  labelText: "* Password",
                  hintText: "Enter your email Password"),
              validator: MailValidate.validatePassword,
            ),
          ),

          SizedBox(height: 10.0),

          Container(
            child: TextFormField(
              textCapitalization: TextCapitalization.none,
              autovalidate: autoValidate,
              controller: recipient,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  labelText: "* Recipient",
                  hintText: "Enter recipient Email"),
              validator: MailValidate.validateRecipient,
            ),
          ),

          SizedBox(height: 10.0),

          Container(
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              autovalidate: autoValidate,
              controller: body,
              keyboardType: TextInputType.text,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                labelText: "* Body",
                hintText: "Content...",
              ),
              validator: MailValidate.validateBody,
            ),
          ),

          SizedBox(height: 10.0),

          Container(
            child: TextFormField(
              textCapitalization: TextCapitalization.none,
              autovalidate: autoValidate,
              controller: smtp,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                labelText: "* SMTP",
                hintText: "Enter SMTP",
              ),
              validator: MailValidate.validateSMTP,
            ),
          ),

          SizedBox(height: 10.0),

          Container(
            child: TextFormField(
              textCapitalization: TextCapitalization.none,
              autovalidate: autoValidate,
              controller: port,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                labelText: "* Port",
                hintText: "Enter Port",
              ),
              validator: MailValidate.validatePort,
            ),
          ),

          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
