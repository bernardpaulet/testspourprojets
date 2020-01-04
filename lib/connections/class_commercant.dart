import 'package:flutter/material.dart';


class CommercantList {

  final List<Commercant> commercants;

  CommercantList({
    this.commercants,
  });


  factory CommercantList.fromJson(List<dynamic> data) {
    List<Commercant> commercants = new List<Commercant>();
    commercants = data.map((i) => Commercant.fromJson(i)).toList();

    return new CommercantList(
      commercants: commercants
    );
  }



}

class Commercant {

  final String denomination;
  final String rue;
  final String numRue;
  final String codePostal;
  final String ville;
  final String longitude;
  final String latitude;
  final String activite;
  final String distance;
  final String telephone;
  final String gsm;
  final String email;
  final String photoPath;
  double distanceDouble = 0.0;


  Commercant({this.denomination,
    this.rue, this.numRue, this.codePostal, this.ville, this.longitude,
    this.latitude, this.activite, this.distance, this.telephone, this.gsm, this.email,this.photoPath, this.distanceDouble});

  /*
  Commercant.fromJson(Map<String, dynamic> data)
      :
        denomination = data['Denomination'],
        rue = data['Rue'],
        numRue = data['NumRue'],
        codePostal = data['CodePostal'],
        ville = data['Ville'],
        longitude = data['Longitude'],
        latitude = data['Latitude'],
        activite = data['Activite'],
        distance = data['distance']
  ;
*/

    factory Commercant.fromJson(Map<String, dynamic> data) {
      return Commercant(
          denomination : data['Denomination'],
          rue : data['Rue'],
          numRue : data['NumRue'],
          codePostal : data['CodePostal'],
          ville : data['Ville'],
          longitude : data['Longitude'],
          latitude : data['Latitude'],
          activite : data['Activite'],
          distance : data["distance"],
          telephone: data['Telephone'],
          gsm: data['GSM'],
          email: data['Mail'],
          photoPath: data['photo']

      );
    }



}
