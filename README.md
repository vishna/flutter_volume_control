# volume_control

A flutter plugin to programmatically adjust the device's volume on Android and iOS.

## API Example
``` dart
// Import package
import 'package:volume_control/volume_control.dart';

// Get the current volume, min=0, max=1
double _val = await VolumeControl.volume;

// Set the new volume value, between 0-1
VolumeControl.setVolume(0.4);
```

## Example
``` dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:volume_control/volume_control.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    initVolumeState();
  }

  //init volume_control plugin
  Future<void> initVolumeState() async {
    if (!mounted) return;

    //read the current volume
    _val = await VolumeControl.volume;
    setState(() {
    });
  }

  double _val = 0.5;
  Timer timer;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Slider(value:_val,min:0,max:1,divisions: 100,onChanged:(val){
            _val = val;
            setState(() {});
            if (timer!=null){
              timer.cancel();
            }
            
            //use timer for the smoother sliding 
            timer = Timer(Duration(milliseconds: 200), (){VolumeControl.setVolume(val);});
            
            print("val:${val}");
          })
        )

      ),
    );
  }
}
```