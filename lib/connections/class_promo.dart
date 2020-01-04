import 'package:flutter/material.dart';

class PromotionList {

  final List<Promotions> promotions;

  PromotionList({
   this.promotions,
});


  factory PromotionList.fromJson(List<dynamic> data) {
    List<Promotions> promotions = new List<Promotions>();
    promotions = data.map((i) => Promotions.fromJson(i)).toList();

    return new PromotionList(
      promotions: promotions
    );
  }


}

class Promotions {

  final String denomination;
  final String rue;
  final String numRue;
  final String codePostal;
  final String ville;
  final String latitude;
  final String longitude;
  final String distance;
  final String telephone;
  final String gsm;
  final String email;
  double distanceDouble = 0.0;
  final String debutPromo;
  final String finPromo;
  final String nomPromo;
  final String description;

  Promotions({
    this.denomination, this.rue, this.numRue, this.codePostal, this.ville, this.latitude, this.longitude, this.distance,
    this.telephone, this.gsm, this.email, this.distanceDouble, this.debutPromo, this.finPromo, this.nomPromo, this.description
});

  factory Promotions.fromJson(Map<String, dynamic> data){
    return Promotions(
      denomination: data["Denomination"],
      rue: data["Rue"],
      numRue: data["NumRue"],
      codePostal: data["CodePostal"],
      ville: data["Ville"],
      latitude: data["Latitude"],
      longitude: data["Longitude"],
      distance: data["distance"],
      telephone: data["Telephone"],
      gsm: data["GSM"],
      email: data["Mail"],
      debutPromo: data["DebutPromo"],
      finPromo: data["FinPromo"],
      nomPromo: data["NomPromo"],
      description: data["Description"]
    );
  }
}