import 'package:flutter/material.dart';

class PostLogs extends StatefulWidget {
  final String post;

  PostLogs({Key key, @required this.post}) : super(key: key);

  @override
  _PostLogsState createState() => _PostLogsState();
}

class _PostLogsState extends State<PostLogs> {
  
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
      title: Text('POST Logs', style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildBody(){
    return ListView(
      children: <Widget>[
        Text(widget.post)
      ],
    );
  }
}
