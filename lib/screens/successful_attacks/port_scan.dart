import 'package:flutter/material.dart';

class PortScan extends StatefulWidget {
  final List<dynamic> portScanList;
  final String ip;

  PortScan({Key key, @required this.portScanList, @required this.ip}) : super(key: key);

  @override
  _PortScanState createState() => _PortScanState();
}

class _PortScanState extends State<PortScan> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppbar(),
        body: _buildBody()
    );
  }

  Widget _buildAppbar(){
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        color: Colors.black,
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(Icons.close, color: Colors.black),
      ),
      title: Text('Port Scan (' + widget.ip + ')',
          style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildBody(){
    if (widget.portScanList.toString() == "[]") {
      return Center(
        child: Text("There's no opened ports.",
            style: TextStyle(fontSize: 16.0)),
      );
    } else {
      return ListView.builder (
          itemCount: widget.portScanList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Text(widget.portScanList[index]['Port'],
                style: TextStyle(color: Colors.blueAccent),),
              title: Text(widget.portScanList[index]['Name']),
              subtitle: Text(widget.portScanList[index]['Reason']),
              trailing: Text(widget.portScanList[index]['State']),
            );
          }
      );
    }
  }
}
