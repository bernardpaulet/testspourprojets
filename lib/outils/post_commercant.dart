import 'package:flutter/material.dart';
import 'dart:convert' show utf8, base64, json;
import 'package:http/http.dart' as http;
import 'alert_connexion.dart';
import 'package:testspourprojets/connections/class_user.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:testspourprojets/connections/class_commercant.dart';
import 'package:testspourprojets/pages/page_commercants.dart';
import 'package:testspourprojets/outils/variables_globales.dart';







class PostCommercant extends StatefulWidget{

  _PostCommercant createState() => _PostCommercant();
  methodePost() => createState().post1();
}

class _PostCommercant extends State<PostCommercant> {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

  //CommercantList maListeCommerces;
  //var latitude;
  //var longitude;


  Future<http.Response> post1() async {
    build(context);
    var url = "https://www.thegood1s.com/api/professionnel/find.php";
    var password = "p!h@97H74BwW(u";
    var username = "api_admin";
    var toEncode = utf8.encode("$username:$password");
    var bytes = base64.encode(toEncode);

    String message1 = "";
    String message2 = "";


    var headers = {
      "Authorization": "Basic $bytes",
      "Content-Type": "application/json",
    };

    var requestBody = json.encode(
        { 'lat': latitude, 'long': longitude, "area": area});
    print(headers);
    print(requestBody);

    final http.Response response = await http.post(
      url,
      body: requestBody,
      headers: headers,
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      if (responseJson == null) {
        print("Pas de commerçant");
      } else {
        CommercantList commercantList = new CommercantList.fromJson(
            responseJson);
        maListeCommerces = commercantList;
        /*setState(() {
          maListeCommerces;
        });*/

        //maListeCommerces = commercantList;

        //maListeCommerces = commercantList;
        listeCommercesAffiches.addAll(maListeCommerces.commercants);


        print('Le résultat du parse est ${commercantList.commercants[2]
            .denomination} ');

        //print("${responseJson.runtimeType}:$responseJson");
        print(commercantList.commercants[0].distance);

        if (commercantList.commercants[0].denomination == null) {
          BuildContext context;
          message1 = "Oups";
          message2 = "Y a un problème";
          //AlerteConnexion().alerteConnexion(context, message1, message2);
        }
      }
    } else {
      BuildContext context;
      message1 = "Problème de connexion";
      message2 = "Veuillez réessayer plus tard";
      //AlerteConnexion().alerteConnexion(context, message1, message2);
      print(response.statusCode);
      print("Oups");
    }

    print(response.statusCode);
    print("Fini");
  }

}



