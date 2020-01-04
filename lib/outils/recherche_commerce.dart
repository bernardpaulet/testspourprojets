  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:geocoder/geocoder.dart';
  import 'package:testspourprojets/connections/class_commercant.dart';
  import 'package:testspourprojets/outils/coordonnees_ville_choisie.dart';
  import 'package:testspourprojets/outils/localisation_choisie.dart';
  import 'package:testspourprojets/outils/coord_ville_choisie.dart';
  import 'package:testspourprojets/outils/coordonnees_ville_choisie.dart';
  import 'package:testspourprojets/outils/alert_connexion.dart';
  import 'package:testspourprojets/pages/page_commercants.dart';
  import 'package:testspourprojets/pages/page_resultat_recherche_commerce.dart';
  import 'package:testspourprojets/outils/variables_globales.dart';


  String villeChoisie = "";
  Coordinates coordoneesVilleCoisie;
  List<String> listeDesActivitesUniques;
  var latitudeChoisie;
  var longitudeChoisie;
  String activiteChoisie = "";

  class RechercheCommerce extends StatefulWidget {

    _RechercheCommerce createState() => new _RechercheCommerce();

  }


  class _RechercheCommerce extends State<RechercheCommerce> {

    List <Address> adresses;
    String message1 = "";
    String message2 = "";
    Coordinates coordsVilleChoisie;



    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      listeActivites();

      return new GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: new Scaffold(
          body: new Padding (padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
          child: Container (
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(height: 20,),
                  new Text("Sélectionnez une ville", textAlign: TextAlign.center,style: TextStyle(color: Colors.deepPurple,fontSize: 25.0, fontFamily: 'CopperplateBold', fontWeight: FontWeight.w600),),

                  new TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.deepPurple,fontSize: 20.0, fontFamily: 'CopperplateBold', fontWeight: FontWeight.w300),
                    onChanged: (String string) {
                      villeChoisie = string;
                    },
                    onSubmitted: (String string) {
                      setState(() {
                        villeChoisie = string;
                      });

                      coordFromVilleChoisie();

                    },

                  ),

                  new Container(height: 15),
                  new Text("Ville choisie : $villeChoisie", textAlign: TextAlign.center,style: TextStyle(color: Colors.deepPurple,fontSize: 15.0, fontFamily: 'CopperplateBold', fontWeight: FontWeight.w300)),
                  new Text("latitude choisie : $latitudeChoisie - longitude choisie : $longitudeChoisie", textAlign: TextAlign.center,style: TextStyle(color: Colors.deepPurple,fontSize: 15.0, fontFamily: 'CopperplateBold', fontWeight: FontWeight.w300)),
                  new Container(width: 10.0, height: 20.0,),

                  new Container(width: 10.0, height: 20.0,),
                  //new LocalisationChoisie(),
                  new Text("Sélectionnez une activité", textAlign: TextAlign.center,style: TextStyle(color: Colors.deepPurple,fontSize: 25.0, fontFamily: 'CopperplateBold', fontWeight: FontWeight.w600),),
                  new RaisedButton(
                      onPressed: () {
                        activiteChoisie = "Rien pour l'instant";
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context){
                              return StatefulBuilder(
                                builder: (BuildContext context, StateSetter setBottomState){
                                return Container(
                                  height: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child:new CupertinoPicker(
                                        itemExtent: 30,
                                        onSelectedItemChanged: (int index) {
                                          var activite = listeDesActivitesUniques[index];
                                          activiteChoisie = activite;
                                          setBottomState(() {
                                            activiteChoisie;
                                          });
                                          setState(() {
                                            activiteChoisie;
                                          });
                                          print(activite);
                                          print(activiteChoisie);
                                        },
                                        children: List<Widget>.generate(listeDesActivitesUniques.length, (int index){
                                          return  Center(
                                            child: Text(listeDesActivitesUniques[index]),
                                          );
                                        }),

                                      ),

                                    )
                                  ],
                                ),


                              );// fin container
                                });

                            }
                        );

                      },
                      child: Text("Choisir une activité", style: TextStyle(color: Colors.deepPurple,fontSize: 15.0, fontFamily: 'CopperplateBold', fontWeight: FontWeight.w600))
                  ),
                  new Container(height: 5),
                  new Text("Activité choisie : $activiteChoisie", textAlign: TextAlign.center, style: TextStyle(color: Colors.deepPurple,fontSize: 15.0, fontFamily: 'CopperplateBold', fontWeight: FontWeight.w300)),
                  new Container(height: 40),
                  new RaisedButton(
                    color: Colors.deepPurple,
                    onPressed: () {
                      print("Bouton pressé");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => PageResultatRechercheCommerces(),
                          ));
                    },
                      child: Text("Lancez la Recherche", style: TextStyle(color: Colors.white,fontSize: 15.0, fontFamily: 'CopperplateBold', fontWeight: FontWeight.w600))
                  ),
                ],
              )

          ),//fin container
      ),
        ),


      );
    }






  // ***** RECHERCHE COORDONNEES VILLE CHOISIE *****
    Future coordFromVilleChoisie() async {
      if (villeChoisie != null && villeChoisie != "") {
        try {
          adresses = await Geocoder.local.findAddressesFromQuery(
              villeChoisie);
          if (adresses.length > 0 || adresses != null) {
            Address first = adresses.first;
            Coordinates coords = first.coordinates;

            coordsVilleChoisie = coords;
          } else {
            message1 = "Ville non trouvée";
            message2 = "Veuillez vérifier la ville entrée";
            //AlerteConnexion().alerteConnexion(context, message1, message2);
          }
        } on PlatformException catch (e) {
          message1 = "Ville non trouvée";
          message2 = "Veuillez vérifier la ville entrée";
          //AlerteConnexion().alerteConnexion(context, message1, message2);
        }
      } else {

        message1 = "Vous avez entré une ville vide";
        message2 = "Veuillez entrer un nom de ville correct";
        //AlerteConnexion().alerteConnexion(context, message1, message2);
        print("grosse erreur");
      }
      if (coordsVilleChoisie != null) {
        var truc = coordsVilleChoisie;
        print("les coordonnees de la ville choisie sont $truc");

        latitudeChoisie = coordsVilleChoisie.latitude;
        longitudeChoisie = coordsVilleChoisie.longitude;
        setState(() {
          latitudeChoisie;
          longitudeChoisie;
        });


      } else {print("les coordonnees de la ville choisie sont nulles"); }

    }
    // ***** FIN RECHERCHE COORDONNEES VILLE CHOISIE *****

  // ***** CREATION LISTE ACTIVITES *****
    void listeActivites(){
      List<String> listeDesActivites = maListeCommerces.commercants.map((value) => value.activite).toList();
      listeDesActivitesUniques = listeDesActivites.toSet().toList(); // enlève les doubles
      print(listeDesActivitesUniques);
    }
  // ***** FIN CREATION LISTE DES ACTIVITES ***

  }