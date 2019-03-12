import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:socialfish/utils/ui_data.dart';

class AboutTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle = themeData.textTheme.body2;
    final TextStyle linkStyle = themeData.textTheme.body2.copyWith(color: themeData.accentColor);

    return AboutDialog(
      applicationIcon: Image.asset('assets/images/logo.png', width: 60.0,),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  style: aboutTextStyle,
                  text: 'This app is an open-source project to remote control SocialFish.',
                ),
                TextSpan(
                  style: aboutTextStyle,
                  text: '\n\nTo see the source code for this app, please visit the ',
                ),
                _LinkTextSpan(
                  style: linkStyle,
                  url: 'https://github.com/UndeadSec/SocialFishMobile',
                  text: 'SocialFIsh Mobile Github repo',
                ),
                TextSpan(
                  style: aboutTextStyle,
                  text: '.',
                ),
                TextSpan(
                  style: aboutTextStyle,
                  text: "\n\nCopyright © " + UIData.yearCopyright + " UndeadSec.",
                ),
              ],
            ),
          ),
        ),
      ],
      applicationName: UIData.appName,
      applicationVersion: UIData.appVersion,
    );
  }
}

class _LinkTextSpan extends TextSpan {

  // References
  // https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/gallery/about.dart

  _LinkTextSpan({ TextStyle style, String url, String text }) : super(
      style: style,
      text: text ?? url,
      recognizer: TapGestureRecognizer()..onTap = () {
        launch(url, forceSafariVC: false);
      }
  );
}