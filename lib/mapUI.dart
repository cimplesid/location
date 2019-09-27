import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'main1.dart';

var onc = true;
var l;
var lg;

class Mapp extends StatefulWidget {
  //final response;
  //final once;
  //Mapp({this.response,this.once});
  @override
  State<Mapp> createState() => MapPageState();
}

class MapPageState extends State<Mapp> {
  static const platform = const MethodChannel('flutter.native/helper');
  // final response;
  // var once;
  MapPageState();

  bool mapToogle = false;

  var currentLocation;

  sendData(al, alg) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MyHomePage(al, alg);
    }));
    //MyHomePage(al,alg);
  }

  void initState() {
    super.initState();
    Geolocator().getCurrentPosition().then((currLoc) {
      setState(() {
        currentLocation = currLoc;
        mapToogle = true;
      });
    });
    type = MapType.hybrid;
    markers = Set.from([]);
    print("Current location is $currentLocation");
    print("bool val is $onc");
    //print("bool val of once is $once");
    //print("Response is $response");
  }

  String response;

  Future<void> initPlatformState(al, alg) async {
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
    });
    return response;
  }

  Completer<GoogleMapController> _controller = Completer();
  MapType type;
  //   CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(currentLocation.latitude, currentLocation.longitude),
  //   zoom: 14.4746,
  // );
  Set<Marker> markers;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Google Maps',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 80.0,
                width: double.infinity,
                child: mapToogle
                    ? GoogleMap(
                        markers: markers,
                        mapType: type,
                        onTap: (position) {
                          l = position.latitude;
                          lg = position.longitude;
                          // print(position);
                          // Marker mk1 = Marker(
                          //   markerId: MarkerId('1'),
                          //   position: position,
                          // );
                          // setState(() {
                          //   markers.add(mk1);
                          // });
                          // sendData(l, lg);
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return MyHomePage(l, lg);
                          // }));
                          initPlatformState(l, lg).then((onValue) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("LatLng from onTap"),
                                  content: Text("$response"),
                                  actions: [
                                    FlatButton(
                                      child: Text("OK"),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(currentLocation.latitude,
                              currentLocation.longitude),
                          zoom: 15.0,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      )
                    : Center(child: Text("Loading please weight...")),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "btn0",
                      onPressed: () {
                        setState(() {
                          type = type == MapType.normal
                              ? MapType.hybrid
                              : MapType.normal;
                        });
                      },
                      child: Icon(Icons.map),
                    ),
                    FloatingActionButton(
                      heroTag: "btn1",
                      child: Icon(Icons.zoom_in),
                      onPressed: () async {
                        (await _controller.future)
                            .animateCamera(CameraUpdate.zoomIn());
                      },
                    ),
                    FloatingActionButton(
                      heroTag: "btn2",
                      child: Icon(Icons.zoom_out),
                      onPressed: () async {
                        (await _controller.future)
                            .animateCamera(CameraUpdate.zoomOut());
                      },
                    ),
                    FloatingActionButton.extended(
                      heroTag: "btn3",
                      icon: Icon(Icons.location_on),
                      label: Text("My position"),
                      onPressed: () {
                        if (markers.length < 1) print("no marker added");
                        print(markers.first.position);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

// class AlertMessage extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {

//     return AlertMessageState();
//   }
// }

// class AlertMessageState extends State<AlertMessage>{
//   @override
//   Widget build(BuildContext context) {
//     return null;
//   }
//   red(response){
//       print("RESPONSE FORM ANOTHER CLASS $response");
//     }

// }
