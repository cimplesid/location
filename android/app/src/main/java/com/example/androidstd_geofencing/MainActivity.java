package com.example.androidstd_geofencing;

import android.os.Bundle;

import java.util.HashMap;
import java.util.HashSet;

import com.google.android.gms.location.LocationServices;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  //private GeofencingClient geofencingClient;
  private static final String CHANNEL = "flutter.native/helper";
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        if (call.method.equals("geofence")) {
          final double a = call.argument("t");
          final double b = call.argument("r");
          result.success(geofence(a,b));
        }
      }
    });
  }

  private String geofence(double a,double b) {

    //String geofencingClient = LocationServices.getGeofencingClient(this).toString();
    // double[] arr = new double[2];
    // arr[0] = a;
    // arr[1] = b;

    return "Latitude is"+String.valueOf(a)+"Longtitude is"+String.valueOf(b);
  }



}



