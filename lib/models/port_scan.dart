import 'package:meta/meta.dart';

class PortScan {
  final String name;
  final String port;
  final String reason;
  final String state;

  const PortScan({
    @required this.name,
    @required this.port,
    @required this.reason,
    @required this.state,
  });
}