import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:testspourprojets/outils/recherche_commerce.dart';

class LocalisationChoisie extends StatefulWidget {

  _LocalisationChoisie createState() => new _LocalisationChoisie();

}



class _LocalisationChoisie extends State<LocalisationChoisie>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container();
  }

  var latitude;
  var longitude;
  var area = 50.0;

  Future maLocalisation() async {
    BuildContext context;
    var location = new Location();
    LocationData position;

    if (villeChoisie != "") { //villeChoisie n'est pas vide et donc on prend la nouvelle position
      List<Address> coord = await Geocoder.local.findAddressesFromQuery(villeChoisie);
      if (coord != null) {
        latitude = coord.first.coordinates.latitude;
        longitude = coord.first.coordinates.longitude;
      } else {
        print("Ville non reconnue");
      }
    } else { //villeChoisie est vide et donc on prend la position de l'utilisateur
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
      }
    }

    print("$latitude : $longitude");

  }
}