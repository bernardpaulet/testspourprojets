import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:testspourprojets/outils/post_commercant.dart';
import 'package:location/location.dart';
import 'dart:convert' show utf8, base64, json;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:testspourprojets/connections/class_commercant.dart';
import 'package:testspourprojets/outils/ma_localisation.dart';
import 'package:testspourprojets/outils/alert_connexion.dart';
import 'package:testspourprojets/pages/page_commercants.dart';
import 'package:testspourprojets/outils/variables_globales.dart';




class PageDetailCommerces extends StatefulWidget {

  _PageDetailCommerces createState() => new _PageDetailCommerces();

}



class _PageDetailCommerces extends State<PageDetailCommerces> {

  var latitude;
  var longitude;
  var area = 50.0;
  String rue = " ";
  String numero = " ";
  String codePostal = " ";
  String ville = " ";
  String adresse = " ";
  String activite = " ";
  String phone = " ";
  String telephone = " ";
  String gsm = " ";
  String email = " ";



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var i = compteurPourTouche;
    faitElements();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Détail Commerçant"),
      ),
      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          Container(
            color: Colors.white,
            //shape: new RoundedRectangleBorder(side: new BorderSide(color: Colors.deepPurple, width: 5.0), borderRadius: BorderRadius.circular(10.0)),
            //elevation: 10.0,
            margin: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
            child: Padding(
              padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(maListeCommerces.commercants[i].denomination, style: TextStyle(color: Colors.white, fontSize: 15.0, fontFamily: 'CopperplateBold', fontWeight: FontWeight.w600)),
                  height: 25.0,
                  width: MediaQuery.of(context).size.width * 1,
                  color: Colors.deepPurple,
                  padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  alignment: Alignment.center,
                ),
                Container(height: 5.0,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: new Image.network(maListeCommerces.commercants[i].photoPath, fit: BoxFit.fitWidth,),
                ),
                //Text(maListeCommerces.commercants[i].denomination + "\n", style: TextStyle(color: Colors.deepPurple, fontSize: 20.0, fontFamily: 'CopperplateBold'),),
                Text(adresse + "\n", style: TextStyle(color: Colors.deepPurple, fontSize: 15.0,),),
                Text(activite + "\n", style: TextStyle(color: Colors.deepPurple, fontSize: 15.0,fontFamily: 'CopperplateBold'),),
                Text(telephone + "\n", style: TextStyle(color: Colors.deepPurple, fontSize: 15.0,fontFamily: 'CopperplateBold'),),
                Text(gsm + "\n", style: TextStyle(color: Colors.deepPurple, fontSize: 15.0,fontFamily: 'CopperplateBold'),),
                Text(email + "\n", style: TextStyle(color: Colors.deepPurple, fontSize: 15.0,fontFamily: 'CopperplateBold'),),
              ],
            ),
        ),
          ),
    ],
      ),

      ),
    );
  }



  Widget faitElements(){
    var i = compteurPourTouche;

    if(maListeCommerces.commercants[i].rue != null){
      rue = maListeCommerces.commercants[i].rue;
    } else {
      rue = " ";
    }

    if(maListeCommerces.commercants[i].numRue != null){
      numero = maListeCommerces.commercants[i].numRue;
    } else {
      numero = " ";
    }

    if(maListeCommerces.commercants[i].codePostal != null){
      codePostal = maListeCommerces.commercants[i].codePostal;
    } else {
      codePostal = " ";
    }

    if(maListeCommerces.commercants[i].ville != null){
      ville = maListeCommerces.commercants[i].ville;
    } else {
      ville = " ";
    }

    if(maListeCommerces.commercants[i].activite != null){
      activite = maListeCommerces.commercants[i].activite;
    } else {
      activite = " ";
    }

    if(maListeCommerces.commercants[i].telephone != null){
      telephone = maListeCommerces.commercants[i].telephone;
    } else {
      telephone = " ";
    }

    if(maListeCommerces.commercants[i].gsm != null){
      gsm = maListeCommerces.commercants[i].gsm;
    } else {
      gsm = " ";
    }

    if(maListeCommerces.commercants[i].email != null){
      email = maListeCommerces.commercants[i].email;
    } else {
      email = " ";
    }

    adresse = "Adresse : " + rue + " " + numero + ", " + codePostal + " " + ville;
    phone = "Téléphone : " + telephone + " / GSM : " + gsm;

  }
}



