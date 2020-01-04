import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:testspourprojets/outils/recherche_commerce.dart';
import 'package:testspourprojets/outils/alert_connexion.dart';

Coordinates coordsVilleChoisie;

class CoordonneesVilleChoisie {

  List <Address> adresses;
  String message1 = "";
  String message2 = "";


  Future coordonnesFromVilleChoisie() async {
    if (villeChoisie != null && villeChoisie != "") {
      try {
        adresses = await Geocoder.local.findAddressesFromQuery(
            villeChoisie);
        if (adresses.length > 0 || adresses != null) {
          Address first = adresses.first;
          Coordinates coords = first.coordinates;

          coordsVilleChoisie = coords;
        } else {
          print("la ville est vide");
        }
      } on PlatformException catch (e) {
        print("Erreur: $e");
      }
    } else {

      message1 = "Oups";
      message2 = "Y a un problème";

      //AlerteConnexion().alerteConnexion(context, message1, message2);
      print("grosse erreur");
    }
    if (coordsVilleChoisie != null) {
      var truc = coordsVilleChoisie;
      print("les coordonnees de la ville choisie sont $truc");

      latitudeChoisie = coordsVilleChoisie.latitude;
      longitudeChoisie = coordsVilleChoisie.longitude;


    } else {print("les coordonnees de la ville choisie sont nulles"); }

  }



}
