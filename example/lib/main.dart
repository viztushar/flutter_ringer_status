import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_ringer_status/flutter_ringer_status.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _ringerstatus = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String ringerstatus;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      ringerstatus = await FlutterRingerStatus.ringerstatus;
    } on PlatformException {
      ringerstatus = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _ringerstatus = ringerstatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('flutter ringer status'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Running on: $_ringerstatus\n'),
              FlatButton(
                onPressed: () {
                  FlutterRingerStatus.play();
                },
                child: Text("Play"),
              ),
              FlatButton(
                onPressed: () {
                  FlutterRingerStatus.stop();
                },
                child: Text("stop"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
