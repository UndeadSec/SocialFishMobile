import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:socialfish/utils/ui_data.dart';
import 'package:socialfish/services/statistic.dart';
import 'package:socialfish/screens/launch_attack/launch_attack.dart';
import 'package:socialfish/screens/successful_attacks/attacks_list.dart';
import 'package:socialfish/screens/mail/send_mail.dart';
import 'package:socialfish/screens/widgets/about.dart';
import 'package:socialfish/screens/login/login.dart';

// Dashboard based on https://github.com/Ivaskuu/dashboard

class Dashboard extends StatefulWidget {
  final String server;
  final String token;

  Dashboard({Key key, @required this.server, @required this.token})
      : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void getStatistics(bool showErrorMessage, bool showSuccessfulMessage) {
    StatisticService()
        .fetchStatistic(widget.server + UIData.apiCheckStatistic + widget.token)
        .then((value) {
      setState(() {
        clicksValue = value.clicks;
        visitorsNotPickedUpValue = value.countNotPickedUp;
        capturedCredentialsValue = value.countCreds;
        attacksLaunchedValue = value.attacks;
        if (showSuccessfulMessage) {
          showSimpleNotification(context,
            Text("Refreshed Successfully"),
            autoDismiss: true,
            background: Colors.green,
          );
        }
      });
    }).catchError((err) {
      if (showErrorMessage) {
        showSimpleNotification(context,
            Text("Error to fetch statistics. Log: " + err.toString()),
            autoDismiss: true,
            background: Colors.redAccent,
        );
      }
    });
  }

  _launchURL() async {
    String url = widget.server.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  int clicksValue = 0;
  int visitorsNotPickedUpValue = 0;
  int capturedCredentialsValue = 0;
  int attacksLaunchedValue = 0;

  // Control Scroll Button
  ScrollController scrollController;

  // Button add
  bool _hideButtonAdd = false;

  @override
  void initState() {
    getStatistics(false, false);

    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _hideButtonAdd = true;
        });
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _hideButtonAdd = false;
        });
      }
    });

    // todo - start timer to run function to fetch statistics
    const oneSec = const Duration(seconds: 10);
    new Timer.periodic(oneSec, (Timer t) => getStatistics(false, false));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    void dialogAbout(BuildContext context) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => AboutTile()
      );
    }

    void runMenuSelection(String item) {
      print(item);
      if (item == "URL") {
        _launchURL();
      }else if (item == "Refresh") {
        getStatistics(true, true);
      } else if (item == "Logout"){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else if (item == "About"){
        dialogAbout(context);
      }
    }

    return Scaffold(
      floatingActionButton: _hideButtonAdd
          ? null
          : FloatingActionButton.extended(
              elevation: 10.0,
              icon: Icon(FontAwesomeIcons.bolt),
              label: Text("Launch"),
              heroTag: 'launch_attack',
              tooltip: "Launch Attack",
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MyCustomRoute(builder: (context) => LaunchAttack()),
                );
              },
            ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(UIData.appBarTitle,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 24.0,
            )),
          leading: PopupMenuButton<String>(
            tooltip: "Menu",
              icon: Icon(const IconData(0xe802, fontFamily: 'fontello'), size: 18.0, color: Colors.black87),
              padding: EdgeInsets.zero,
              onSelected: runMenuSelection,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                    value: "URL",
                    child: ListTile(
                        leading: Icon(FontAwesomeIcons.externalLinkSquareAlt),
                        title: Text("Attack URL")
                    )
                ),
                PopupMenuItem<String>(
                    value: "Refresh",
                    child: ListTile(
                        leading: Icon(FontAwesomeIcons.syncAlt),
                        title: Text("Refresh")
                    )
                ),
                PopupMenuItem<String>(
                    value: "Logout",
                    child: ListTile(
                        leading: Icon(FontAwesomeIcons.signInAlt),
                        title: Text("Logout")
                    )
                ),
                const PopupMenuDivider(),
                PopupMenuItem<String>(
                    value: "About",
                    child: ListTile(
                        leading: Icon(FontAwesomeIcons.infoCircle),
                        title: Text("About")
                    )
                )
              ]
          ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: GestureDetector(
                    child: Text(
                      widget.server.toString(),
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0),
                    ),
                    onTap: _launchURL,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: StaggeredGridView.count(
        controller: scrollController,
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Material(
                        color: Color.fromRGBO(0, 193, 111, 1.0),
                        shape: CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(Icons.mouse,
                              color: Colors.white, size: 30.0),
                        )),
                    Padding(padding: EdgeInsets.only(bottom: 16.0)),
                    Text(clicksValue.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 24.0)),
                    Text('Clicks', style: TextStyle(color: Colors.black45)),
                  ]),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Material(
                        color: Color.fromRGBO(255, 124, 0, 1.0),
                        shape: CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(FontAwesomeIcons.frownOpen,
                              color: Colors.white, size: 30.0),
                        )),
                    Padding(padding: EdgeInsets.only(bottom: 16.0)),
                    Text(visitorsNotPickedUpValue.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 24.0)),
                    Text('Visitors Not Picked.',
                        style:
                            TextStyle(color: Colors.black45, fontSize: 13.0)),
                  ]),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Material(
                        color: Color.fromRGBO(0, 174, 235, 1.0),
                        shape: CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(FontAwesomeIcons.calendar,
                              color: Colors.white, size: 30.0),
                        )),
                    Padding(padding: EdgeInsets.only(bottom: 16.0)),
                    Text(capturedCredentialsValue.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 24.0)),
                    Text('Captured Cred.',
                        style:
                            TextStyle(color: Colors.black45, fontSize: 13.0)),
                  ]),
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AttacksList(
                      server: widget.server,
                      token: widget.token,
                    ))),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Material(
                        color: Color.fromRGBO(255, 0, 70, 1.0),
                        shape: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(FontAwesomeIcons.fire,
                              color: Colors.white, size: 30.0),
                        )),
                    Padding(padding: EdgeInsets.only(bottom: 16.0)),
                    Text(attacksLaunchedValue.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 24.0)),
                    Text('Attacks', style: TextStyle(color: Colors.black45)),
                  ]),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Successful Attacks',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0))
                      ],
                    ),
                    Material(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(24.0),
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.format_list_bulleted,
                              color: Colors.white, size: 30.0),
                        )))
                  ]),
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AttacksList(
                      server: widget.server,
                      token: widget.token,
                    ))),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Send Mail',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0))
                      ],
                    ),
                    Material(
                        color: UIData.blueSendMail,
                        borderRadius: BorderRadius.circular(24.0),
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child:
                              Icon(Icons.mail, color: Colors.white, size: 30.0),
                        )))
                  ]),
            ),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => SendMail())),
          )
        ],
        staggeredTiles: [
          StaggeredTile.extent(1, 180.0),
          StaggeredTile.extent(1, 180.0),
          StaggeredTile.extent(1, 180.0),
          StaggeredTile.extent(1, 180.0),
          StaggeredTile.extent(2, 110.0),
          StaggeredTile.extent(2, 110.0),
        ],
      ),
    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 12.0,
        borderRadius: BorderRadius.circular(8.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            onTap: onTap != null
                ? () => onTap()
                : () {
                    getStatistics(true, false);
                  },
            child: child
        )
    );
  }

}

class MyCustomRoute<T> extends CupertinoPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  bool get fullscreenDialog => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 350);
}

class MyCustomRouteBack<T> extends CupertinoPageRoute<T> {
  MyCustomRouteBack({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 350);
}