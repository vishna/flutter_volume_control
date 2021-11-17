import 'dart:async';
import 'package:flutter/services.dart';

//A flutter plugin to programmatically adjust the device's volume on Android and iOS.
class VolumeControl {
  //A MethodChannel to communicate with native code
  static const MethodChannel _channel = const MethodChannel('volume_control');

  //set a new volume value between 0-1
  static setVolume(double vol) async {
    _channel.invokeMethod('setVolume', {"vol": vol});
  }

  //get the current volume from system
  static Future<double> get volume async {
    final double vol = await _channel.invokeMethod('getVolume');
    return vol;
  }
}
