import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show utf8, base64, json;
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:testspourprojets/connections/class_user.dart';
import 'package:testspourprojets/outils/alert_connexion.dart';
import 'package:testspourprojets/outils/post_login_utilisateur.dart';
import 'package:testspourprojets/outils/recherche_commerce.dart';

var latitude;
var longitude;
//User profilUtilisateur;
String emailUtilisateur = "";
String motDePasseUtilisateur = "";


class PageSearch extends StatefulWidget {

  _PageSearch createState() => new _PageSearch();

}


class _PageSearch extends State<PageSearch> {

  final Map<int, Widget> texteSegmentedWidget = const <int, Widget> {
    0: Text("Commerçants"),
    1: Text("Promotions")
  };

  final Map<int, Widget> contenuSegmentedWidget =  <int, Widget> {
    0: RechercheCommerce(),
    1: Center(
      child: Text("Recherche Promotion"),
    )
  };

  int sharedValue = 0;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return new GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Recherche"),
          leading: new Container(), //cache le bouton back dans la appBar
        ),
        body: new Container (
          child: new Column(
            children: <Widget>[
              new Container(
                height: 20,
              ),
              new Padding(
                padding: EdgeInsets.fromLTRB(2.0, 1.0, 2.0, 1.0),
              child: CupertinoSegmentedControl(
                children: texteSegmentedWidget,

                onValueChanged: (int val) {
                  setState(() {
                    sharedValue = val;
                  });
                },
                groupValue: sharedValue,
              ),),

              new Expanded(child: contenuSegmentedWidget[sharedValue]),
            ],
          ),

        ),
      ),
    );
  }

}


