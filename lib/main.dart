

import 'package:flutter/material.dart';

import 'mapUI.dart';
//import 'package:flutter_geofencing/flutter_geofencing.dart';
// import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
// import 'package:flutter_map/flutter_map.dart';
//import 'package:flutter_geofencing/flutter_geofencing.dart';

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Mapp(),
    );
  }
}


