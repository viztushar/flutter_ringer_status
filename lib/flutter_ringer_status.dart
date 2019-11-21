import 'dart:async';

import 'package:flutter/services.dart';

class FlutterRingerStatus {
  static const MethodChannel _channel =
      const MethodChannel('flutter_ringer_status');

  static Future<String> get ringerstatus async {
    final String version = await _channel.invokeMethod('getRingerstatus');
    return version;
  }

  static Future play() async {
    try {
      await _channel.invokeMethod('play');
    } catch(e){
      print("FlutterRingerStatus Error: " + e.toString());
    }
  }

  static Future stop() async {
    try {
      await _channel.invokeMethod('stop');
    } catch(e){
      print("FlutterRingerStatus Error: " + e.toString());
    }
  }

}
