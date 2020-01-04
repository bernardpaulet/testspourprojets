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
import 'package:testspourprojets/pages/page_promotions.dart';
import 'package:testspourprojets/outils/variables_globales.dart';




class PageDetailPromo extends StatefulWidget {

  _PageDetailPromo createState() => new _PageDetailPromo();

}



class _PageDetailPromo extends State<PageDetailPromo> {

  var latitude;
  var longitude;
  var area = 50.0;
  String rue = " ";
  String numero = " ";
  String codePostal = " ";
  String ville = " ";
  String adresse = " ";
  //String activite = " ";
  String phone = " ";
  String telephone = " ";
  String gsm = " ";
  String email = " ";



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var i = compteurPourTouchePromo;
    faitElements();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Détail Promotion"),
      ),
      body: new Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,

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
                    child: Column(
                    children: <Widget>[
                      Container(height: 5.0,),
                      Text(maListePromos.promotions[i].denomination, style: TextStyle(color: Colors.white, fontSize: 15.0, fontFamily: 'CopperplateBold', fontWeight: FontWeight.w600),),
                      Container(height: 5.0,),
                     Text(maListePromos.promotions[i].nomPromo, style: TextStyle(color: Colors.white, fontSize: 15.0, fontFamily: 'CopperplateBold', fontWeight: FontWeight.w600)),
                      ],
                    ),
                    //Text(maListeCommerces.commercants[i].denomination, style: TextStyle(color: Colors.white, fontSize: 15.0, fontFamily: 'CopperplateBold', fontWeight: FontWeight.w600)),
                    height: 45.0,
                    width: MediaQuery.of(context).size.width * 1,
                    color: Colors.deepPurple,
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    alignment: Alignment.center,
                  ),
                  Container(height: 5.0,),
                  //Text(maListePromos.promotions[i].nomPromo, style: TextStyle(color: Colors.deepPurple, fontSize: 20.0, fontFamily: 'CopperplateBold'),),
                  Text("Description : " + maListePromos.promotions[i].description, style: TextStyle(color: Colors.deepPurple, fontSize: 15.0, fontFamily: 'CopperplateBold'),),
                  Text("Du : " + maListePromos.promotions[i].debutPromo + " au " + maListePromos.promotions[i].finPromo, style: TextStyle(color: Colors.deepPurple, fontSize: 15.0, fontFamily: 'CopperplateBold'),),
                  Text(""),
                  //Text(maListePromos.promotions[i].denomination + "\n", style: TextStyle(color: Colors.deepPurple, fontSize: 15.0, fontFamily: 'CopperplateBold'),),
                  Text(adresse + "\n", style: TextStyle(color: Colors.deepPurple, fontSize: 15.0, fontFamily: 'CopperplateBold'),),
                  //Text(activite + "\n", style: TextStyle(color: Colors.white, fontSize: 15.0, fontFamily: 'Copperplate'),),
                  Text(telephone + "\n", style: TextStyle(color: Colors.deepPurple, fontSize: 15.0, fontFamily: 'CopperplateBold'),),
                  Text(gsm + "\n", style: TextStyle(color: Colors.deepPurple, fontSize: 15.0, fontFamily: 'CopperplateBold'),),
                  Text(email + "\n", style: TextStyle(color: Colors.deepPurple, fontSize: 15.0, fontFamily: 'CopperplateBold'),),
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
    var i = compteurPourTouchePromo;

    if(maListePromos.promotions[i].rue != null){
      rue = maListePromos.promotions[i].rue;
    } else {
      rue = " ";
    }

    if(maListePromos.promotions[i].numRue != null){
      numero = maListePromos.promotions[i].numRue;
    } else {
      numero = " ";
    }

    if(maListePromos.promotions[i].codePostal != null){
      codePostal = maListePromos.promotions[i].codePostal;
    } else {
      codePostal = " ";
    }

    if(maListePromos.promotions[i].ville != null){
      ville = maListePromos.promotions[i].ville;
    } else {
      ville = " ";
    }

    /*
    if(maListeCommerces.commercants[i].activite != null){
      activite = maListeCommerces.commercants[i].activite;
    } else {
      activite = " ";
    }
    */

    if(maListePromos.promotions[i].telephone != null){
      telephone = maListePromos.promotions[i].telephone;
    } else {
      telephone = " ";
    }

    if(maListePromos.promotions[i].gsm != null){
      gsm = maListePromos.promotions[i].gsm;
    } else {
      gsm = " ";
    }

    if(maListePromos.promotions[i].email != null){
      email = maListePromos.promotions[i].email;
    } else {
      email = " ";
    }

    adresse = "Adresse : " + rue + " " + numero + ", " + codePostal + " " + ville;
    phone = "Téléphone : " + telephone + " / GSM : " + gsm;

  }
}



