import 'package:flutter/material.dart';
//import 'dart:convert' show utf8, base64, json;
//import 'package:http/http.dart' as http;
//import 'package:location/location.dart';
//import 'package:testspourprojets/connections/class_user.dart';
//import 'package:testspourprojets/outils/alert_connexion.dart';
import 'package:testspourprojets/pages/page_promotions.dart';
import 'package:testspourprojets/outils/variables_globales.dart';

/*
class AlerteConnexion extends StatefulWidget {

  _AlerteConnexion createState() => new _AlerteConnexion();
  methodeAlerte() => createState().Alerte();

}

class _AlerteConnexion extends State<AlerteConnexion>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("Dans AlerteConnexion");
    return null;
  }

  void Alerte(){
    //build(context);
    print("Dans Alerte");
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext contextAlert) {
        return new AlertDialog(
          title: new Text(message1, textScaleFactor: 1.5,),
          content: new Text(message2),
          contentPadding: EdgeInsets.all(5.0),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  print("Continuer");
                  Navigator.pop(contextAlert);
                },
                child: new Text(
                  "Continuer",
                  style: new TextStyle(color: Colors.deepPurple),))
          ],
        );
      },
    );
  }

}
*/



class AlerteConnexion {

 void alerteConnexion(BuildContext context)  {
   print("brol");

   showDialog(
     context: context,
     barrierDismissible: true,
     builder: (BuildContext contextAlert) {
       return new AlertDialog(
         title: new Text(message1, textScaleFactor: 1.5,),
         content: new Text(message2),
         contentPadding: EdgeInsets.all(5.0),
         actions: <Widget>[
           new FlatButton(
               onPressed: () {
                 print("Continuer");
                 Navigator.pop(contextAlert);
               },
               child: new Text(
                 "Continuer",
                 style: new TextStyle(color: Colors.deepPurple),))
         ],
       );
     },
   );

 }
}



