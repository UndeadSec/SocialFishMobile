import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:socialfish/screens/successful_attacks/table_columns.dart';
import 'package:socialfish/screens/successful_attacks/post_logs.dart';
import 'package:socialfish/screens/successful_attacks/port_scan.dart';
import 'package:socialfish/screens/successful_attacks/trace_ip.dart';
import 'package:socialfish/services/attacks_list.dart';
import 'package:socialfish/models/attacks.dart';
import 'package:socialfish/services/trace.dart';
import 'package:socialfish/services/port_scan.dart';
import 'package:socialfish/utils/ui_data.dart';
import 'package:socialfish/screens/widgets/progress.dart';
import 'package:socialfish/screens/widgets/dialog.dart';

class AttacksList extends StatefulWidget {
  final String server;
  final String token;

  AttacksList({Key key, @required this.server, @required this.token}) : super(key: key);

  @override
  _AttacksListState createState() => _AttacksListState();
}

class _AttacksListState extends State<AttacksList> {

  List<Attacks> attacksList = new List();
  List<dynamic> dataList = new List();

  loadDataFromModelAttackList(List<dynamic> data) {
    attacksList.clear();

    data.forEach((data){
      attacksList.add(Attacks(
          id: data['id'].toString(),
          browser: data['browser'],
          browserVersion: data['version'],
          date: data['date'],
          ip: data['ip'],
          os: data['os'],
          post: data['post'],
          url: data['url']
      ));
    });

    dataList = data;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(247, 247, 247, 1.0),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text('Successful Attacks',
            style: TextStyle(color: Colors.black)),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: AttacksListService()
            .fetchAttacksList(widget.server, widget.token),
        builder: (context, snapshot) {

          if (snapshot.hasData) {

            if (snapshot.data.length == null || snapshot.data.length == 0) {
              return Center(
                child: Text(
                  "There's no attacks logs.",
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              );
            }

            snapshot.data.forEach((data){
              loadDataFromModelAttackList(snapshot.data);
            });

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: width * 3.7,
                child: ListView(
                  children: <Widget>[
                    buildDataTable(),
                  ],
                ),
              ),
            );

          } else if (snapshot.hasError) {
            return new Container(
              padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.exclamationTriangle, size: 48.0, color: Colors.red),
                    SizedBox(height: 20.0),
                    Text("Error to fetch statistics. Log: ${snapshot.error}", style: TextStyle(color: Colors.red),),
                  ],
                )
            );
          }
          return new Container(
            alignment: AlignmentDirectional.center,
            child: new CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget buildDataTable() => DataTable(
    sortAscending: false,
    sortColumnIndex: 0,
    columns: attacksColumns.map(
          (String column) => DataColumn(
            label: Text(column),
      onSort: null,
      ),
    ).toList(),
    rows: attacksList.map((Attacks attack) => DataRow(
      cells: [
        DataCell(
          Chip(label: Text('${attack.url}'),
          backgroundColor: Colors.blueGrey.shade50,
            shape: RoundedRectangleBorder(),
          )
        ),
        DataCell(Text('${attack.ip}'),),
        DataCell(Text('${attack.browser}' + ' ${attack.browserVersion}')),
        DataCell(Text('${attack.os}')),
        DataCell(Text('${attack.date}')),

        DataCell(FlatButton.icon(onPressed: (){
          showDialog(context: context, child: Progress.progressLoading);

        PortScanService()
            .fetchPortScan(widget.server, widget.token, "${attack.ip}")
            .then((value){
            Navigator.pop(context); // Close dialog progress loading

            if (value == null){
              DialogMsg().dialogError(context, UIData.errorFailedToLoadPortScanInformation);
            } else {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => PortScan(
                portScanList: value,
                ip: "${attack.ip}",
              )));
            }
          }).catchError((error){
            Navigator.pop(context);
            DialogMsg().dialogError(context, UIData.errorFailedToLoadPortScanInformation);
          });
        }, icon: Icon(FontAwesomeIcons.bullseye), label: Text("Scan"))),

        DataCell(FlatButton.icon(onPressed: (){
          showDialog(context: context, child: Progress.progressLoading);

          TraceService().fetchTraceData(widget.server + UIData.apiGetTrace + widget.token + "/${attack.ip}").then((value){
            Navigator.pop(context);

            Navigator.of(context).push(MaterialPageRoute(builder: (_) => TraceIP(
              ip: attack.ip,
              country: value.countryName,
              city: value.city,
              postal: value.postal,
              state: value.state,
              latitude: value.latitude,
              longitude: value.longitude,
            )));

          }).catchError((error){
            Navigator.pop(context);
            DialogMsg().dialogError(context, UIData.errorFailedToLoadTraceInformation);
          });

        }, icon: Icon(FontAwesomeIcons.eye), label: Text("Trace"))),

        DataCell(FlatButton.icon(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => PostLogs(post: '${attack.post}',)));
        }, icon: Icon(FontAwesomeIcons.search), label: Text("View")),),
      ],
    )).toList(),
  );
}
