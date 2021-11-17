import 'package:flutter/material.dart';
import 'dart:async';
import 'package:volume_control/volume_control.dart';


//start entry
void main() => runApp(MyApp());

//usage example
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

//usage example
class _MyAppState extends State<MyApp> {

  @override
  //init the plugin
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
  Timer? timer;
  @override
  //build a slider for example
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
              timer?.cancel();
            }
            
            //use timer for the smoother sliding 
            timer = Timer(Duration(milliseconds: 200), (){VolumeControl.setVolume(val);});
            
            print("val:$val");
          })
        )

      ),
    );
  }
}
