import 'package:flutter/material.dart';
import 'package:testspourprojets/connections/class_commercant.dart';
import 'package:testspourprojets/connections/class_promo.dart';

int compteurPourTouche;
int compteurPourTouchePromo;
CommercantList maListeCommerces;
PromotionList maListePromos;
var latitude;
var longitude;
var area = 50.0;
String typePost = "";
String message1 = "";
String message2 = "";
List<Commercant> listeCommercesAffiches = List<Commercant>();
List<Promotions> ListePromosAffiches = List<Promotions>();

