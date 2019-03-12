import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:android_intent/android_intent.dart';

import 'package:socialfish/screens/widgets/dialog.dart';
import 'package:socialfish/utils/ui_data.dart';

class TraceIP extends StatefulWidget {

  final String ip;
  final String country;
  final String city;
  final String postal;
  final String state;
  final double latitude;
  final double longitude;

  TraceIP({
    Key key,
    @required this.ip,
    @required this.country,
    @required this.city,
    @required this.postal,
    @required this.state,
    @required this.longitude,
    @required this.latitude
  }) : super(key: key);

  @override
  _TraceIPState createState() => _TraceIPState();
}

class _TraceIPState extends State<TraceIP> {

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
      title: Text('Trace IP (' + widget.ip + ')', style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildBody(){
    return ListView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      children: <Widget>[
        ListTile(
          leading: Icon(FontAwesomeIcons.globeAmericas),
          title: Text("Country"),
          subtitle: Text(widget.country),
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.solidFlag),
          title: Text("State"),
          subtitle: Text(widget.state),
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.mapMarker),
          title: Text("City"),
          subtitle: Text(widget.city),
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.solidEnvelope),
          title: Text("Postal"),
          subtitle: Text(widget.postal),
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.globe),
          title: Text("Latitude"),
          subtitle: Text(widget.latitude.toString()),
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.globe),
          title: Text("Longitude"),
          subtitle: Text(widget.longitude.toString()),
        ),
        Container(
          padding: const EdgeInsets.all(20.0),
          child: FloatingActionButton.extended(
            elevation: 4.0,
            backgroundColor: Colors.green,
            icon: const Icon(FontAwesomeIcons.mapMarkedAlt),
            label: const Text('View on Google Maps'),
            onPressed: () async {
                AndroidIntent intent = AndroidIntent(
                  action: 'action_view',
                  data: 'geo:${widget.latitude},${widget.longitude}?z=zoom',
                  package: "com.google.android.apps.maps",
                );

                await intent.launch().catchError((e){
                  DialogMsg().dialogError(context,
                      UIData.errorFailedToOpenGoogleMapsAndroid
                          + " \n\nLog: " + e.toString());
                });
            },
          ),
        ),
      ],
    );
  }
}
