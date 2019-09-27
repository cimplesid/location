import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'main.dart';
import 'mapUI.dart';
//void main() => runApp(new MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       home: new HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MyHomePage();
//   }

// }

String response;

class MyHomePage extends StatefulWidget {
  final al;
  final alg;
  //final mapContext;
  MyHomePage(this.al, this.alg);
  @override
  MyHomePageState createState() => new MyHomePageState(this.al, this.alg);
}

class MyHomePageState extends State<MyHomePage> {
  var al;
  var alg;
  //var mapContext;
  MyHomePageState(this.al, this.alg);
  static const platform = const MethodChannel('flutter.native/helper');

  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      final String result =
          await platform.invokeMethod('geofence', <String, dynamic>{
        't': al,
        'r': alg,
      });
      response = result;
    } on PlatformException catch (e) {
      response = "Exception $e";
    }

    setState(() {
      response = response;
      debugPrint("Response is" + response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 50,
          width: 50,
          child: Text("$response"),
        )
      ],
    );
    //AlertMessageState().red(response);
  }
}

// alertBox(context) {
//    showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Text("response is $response"),
//         );
//       });
// }
