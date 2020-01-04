import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert' show utf8, base64, json;
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:testspourprojets/pages/page_login.dart';
import 'package:testspourprojets/outils/post_commercant.dart';
import 'package:testspourprojets/pages/page_commercants.dart';
import 'package:testspourprojets/outils/ma_localisation.dart';
import 'package:testspourprojets/pages/page_promotions.dart';
import 'package:testspourprojets/outils/home.dart';
import 'package:testspourprojets/outils/variables_globales.dart';

bool profilVide;
String key;
//var latitude;
//var longitude;
String titreApp = "The Good 1's";

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: titreApp,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(),
    );
  }
}



    // This trailing comma makes auto-formatting nicer for build methods.






Future<http.Response> post() async {

  var url = "https://www.thegood1s.com/api/utilisateur/login.php";
  var password = "p!h@97H74BwW(u";
  var username = "api_admin";
  var toEncode = utf8.encode("$username:$password");
  var bytes = base64.encode(toEncode);
  String userNameUser = "bernardpaulet@gmail.com";
  String passwordUser = "Trucbrol00";
  var passwordUserEncoded = base64.encode(utf8.encode(passwordUser));
//var passwordUserEncoded = base64.encode(passwordUser);
  var headers = {
    "Authorization": "Basic $bytes",
    "Content-Type": "application/json",
  };
  var requestBody = json.encode({ 'user': userNameUser, 'password': passwordUserEncoded});
  print(headers);
  print(requestBody);

  final http.Response response = await http.post(
    url,
    body: requestBody,
    headers: headers,
  );
  if(response.statusCode == 200){
    var responseJson = json.decode(response.body);
    //print(Utf8Codec().decode(response.bodyBytes));
    print("${responseJson.runtimeType}:$responseJson");
    //print("Body: " + responseJson);
    }

  print(bytes);
  print(response.statusCode);
  print("Fini");
}

Future<http.Response> postPro() async {

  var url = "https://www.thegood1s.com/api/professionnel/find.php";
  var password = "p!h@97H74BwW(u";
  var username = "api_admin";
  var toEncode = utf8.encode("$username:$password");
  var bytes = base64.encode(toEncode);


  var headers = {
    "Authorization": "Basic $bytes",
    "Content-Type": "application/json",
  };
  print(headers);


  var location = new Location();
  LocationData position;
  try {
    position = await location.getLocation();
  } on PlatformException catch (e) {
    print("Erreur: $e");
  }
  if (position != null) {
    final lat = position.latitude;
    final lon = position.longitude;
    latitude = lat;
    longitude = lon;
    print("$latitude : $longitude");
  }

  var requestBody = json.encode({ 'lat': latitude, 'long': longitude, "area":10.0});
  //var requestBody = json.encode({});
  print(requestBody);

  final http.Response response = await http.post(
    url,
    body: requestBody,
    headers: headers,
  );
  if(response.statusCode == 200){
    var responseJson = json.decode(response.body);
    print("${responseJson.runtimeType}:$responseJson");

    }

  print(response.statusCode);
  print("Fini");
}


Future<http.Response> promos() async {

  var url = "https://www.thegood1s.com/api/promotion/find.php";
  var password = "p!h@97H74BwW(u";
  var username = "api_admin";
  var toEncode = utf8.encode("$username:$password");
  var bytes = base64.encode(toEncode);


  var headers = {
    "Authorization": "Basic $bytes",
    "Content-Type": "application/json",
  };
  print(headers);

  var location = new Location();
  LocationData position;
  try {
    position = await location.getLocation();
  } on PlatformException catch (e) {
    print("Erreur: $e");
  }
  if (position != null) {
    final lat = position.latitude;
    final lon = position.longitude;
    latitude = lat;
    longitude = lon;
    print("$latitude : $longitude");
  }

  var requestBody = json.encode({ 'lat': latitude, 'long': longitude, "area":50.0});

  final http.Response response = await http.post(
    url,
    body: requestBody,
    headers: headers,
  );
  if(response.statusCode == 200){
    var responseJson = json.decode(response.body);
    print("${responseJson.runtimeType}:$responseJson");

        }

  print(response.statusCode);
  print("Fini");
}

void obtenir() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool boolEnregistre = await sharedPreferences.getBool(key);
  profilVide = boolEnregistre;
}



