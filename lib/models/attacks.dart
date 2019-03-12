import 'package:meta/meta.dart';

class Attacks {
  final String id;
  final String browser;
  final String browserVersion;
  final String date;
  final String ip;
  final String os;
  final String post;
  final String url;

  const Attacks({
    @required this.id,
    @required this.browser,
    @required this.browserVersion,
    @required this.date,
    @required this.ip,
    @required this.os,
    @required this.post,
    @required this.url
  });
}