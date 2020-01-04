import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:testspourprojets/outils/post_commercant.dart';
import 'package:testspourprojets/outils/post_promotion.dart';
import 'package:flutter/services.dart';
import 'package:testspourprojets/outils/variables_globales.dart' as prefix0;
import 'package:testspourprojets/pages/page_commercants.dart';
import 'package:testspourprojets/outils/variables_globales.dart';
import 'package:testspourprojets/outils/post_commercant.dart';
/*

 */

  Future maLocalisation1() async {
    BuildContext context;
    var location = new Location();
    LocationData position;
    print("Dans localisation");
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
      if (typePost == "commercant") {
        PostCommercant().methodePost();
        //PostCommercant();
        print("On a lancé le post Commerçant");
        // PostCommercant().post(context, latitude, longitude, area);
      } else if (typePost == "promotion"){
        PostPromotion().methodePromo();

      }
    }
  }



/*
class MaLocalisation {

  var latitude;
  var longitude;
  var area = 50.0;

  Future maLocalisation() async {
    BuildContext context;
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
      PostCommercant().post(context, latitude, longitude, area);

    }
  }

}

 */