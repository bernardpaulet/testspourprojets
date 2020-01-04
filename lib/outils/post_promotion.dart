import 'package:flutter/material.dart';
import 'dart:convert' show utf8, base64, json;
import 'package:http/http.dart' as http;
import 'alert_connexion.dart';
import 'package:testspourprojets/connections/class_user.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:testspourprojets/connections/class_promo.dart';
import 'package:testspourprojets/pages/page_commercants.dart';
import 'package:testspourprojets/outils/variables_globales.dart';

class PostPromotion extends StatefulWidget{
  methodePromo() => createState().postPromo1();
  _PostPromotion createState() => _PostPromotion();
}

class _PostPromotion extends State<PostPromotion> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //post(context);
    return null;
  }

  Future<http.Response> postPromo1() async {
    var url = "https://www.thegood1s.com/api/promotion/find.php";
    var password = "p!h@97H74BwW(u";
    var username = "api_admin";
    var toEncode = utf8.encode("$username:$password");
    var bytes = base64.encode(toEncode);

    String message1 = "";
    String message2 = "";


    var headers = {
      "Authorization": "Basic $bytes",
      "Content-Type": "application/json",
    };

    var requestBody = json.encode(
        { 'lat': latitude, 'long': longitude, "area": area});
    print(headers);
    print(requestBody);

    final http.Response response = await http.post(
      url,
      body: requestBody,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);
      if (responseJson == null) {
        BuildContext context;

        print("Pas de promo");
        message1 = "Erreur !";
        message2 = "Pas de Promotion";
        // AlerteConnexion();

        //alerteCon(context, message1, message2);


      } else {
        PromotionList promotionList = new PromotionList.fromJson(responseJson);
        /*setState(() {
          maListePromos = promotionList;
        });*/
        maListePromos = promotionList;
        ListePromosAffiches.addAll(maListePromos.promotions);

        print('Le résultat du parse est ${promotionList.promotions[0]
            .denomination} ');

        //print("${responseJson.runtimeType}:$responseJson");
        print(promotionList.promotions[0].distance);

        if (promotionList == null) {
          BuildContext context;
          message1 = "Oups";
          message2 = "Y a un problème";
          //AlerteConnexion().alerteConnexion(context, message1, message2);
          print("le parse est nul");
        }
      }
    } else {
      print("Oups");
      BuildContext context;
      message1 = "Problème de connexion";
      message2 = "Veuillez réessayer plus tard";
      //AlerteConnexion().alerteConnexion(context, message1, message2);

    }
  }
}

