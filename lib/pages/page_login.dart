import 'package:flutter/material.dart';
import 'dart:convert' show utf8, base64, json;
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:testspourprojets/connections/class_user.dart';
import 'package:testspourprojets/outils/alert_connexion.dart';
import 'package:testspourprojets/outils/post_login_utilisateur.dart';
import 'package:testspourprojets/outils/variables_globales.dart';

//var latitude;
//var longitude;
//User profilUtilisateur;
String emailUtilisateur = "";
String motDePasseUtilisateur = "";


class PageLogin extends StatefulWidget {

  _OnSeLogge createState() => new _OnSeLogge();

}


class _OnSeLogge extends State<PageLogin> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return new GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: new Scaffold(
        body: new Center (
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new TextField(
                  onChanged: (String string) {
                    emailUtilisateur = string;
                  },
                  onSubmitted: (String string) {
                    emailUtilisateur = string;
                  },
                  decoration: new InputDecoration(
                      labelText: "Entrez votre email"
                  ),
                ),
                new Text(emailUtilisateur),
                new Container(width: 10.0, height: 20.0,),
                new TextField(
                  onChanged: (String string) {
                    motDePasseUtilisateur = string;
                  },
                  onSubmitted: (String string) {
                    motDePasseUtilisateur = string;
                  },
                  decoration: new InputDecoration(
                      labelText: "Entrez votre mot de passe"
                  ),
                ),
                new Container(width: 10.0, height: 20.0,),
                new RaisedButton(
                  onPressed: () {
                    //post();
                    UserLogin().post(context, emailUtilisateur, motDePasseUtilisateur);
                  },
                  elevation: 4.0,
                  color: Theme
                      .of(context)
                      .primaryColor,
                  textColor: Colors.white,
                  child: Text("Envoyer"),
                )
              ],
            )

        ),
      ),
    );
  }

}


