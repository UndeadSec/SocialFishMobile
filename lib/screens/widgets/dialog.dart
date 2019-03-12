import 'package:flutter/material.dart';

class DialogMsg {

  // dialog error
  Future<Null> dialogError(BuildContext buildContext, String msg) async {
    return showDialog<Null>(
      context: buildContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
            title: new Text("Error"),
            content: new Text(msg),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }
               ),
            ]
        );
      },
    );
  }
}
