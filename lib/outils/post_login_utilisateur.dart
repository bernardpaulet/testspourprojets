import 'package:flutter/material.dart';
import 'dart:convert' show utf8, base64, json;
import 'package:http/http.dart' as http;
import 'alert_connexion.dart';
import 'package:testspourprojets/connections/class_user.dart';

class UserLogin {

  Future<http.Response> post(BuildContext context, emailUtilisateur, String motDePasseUtilisateur) async {
    var url = "https://www.thegood1s.com/api/utilisateur/login.php";
    var password = "p!h@97H74BwW(u";
    var username = "api_admin";
    var toEncode = utf8.encode("$username:$password");
    var bytes = base64.encode(toEncode);

    String userNameUser = emailUtilisateur;
    String passwordUser = motDePasseUtilisateur;

    String message1 = "";
    String message2 = "";

    var passwordUserEncoded = base64.encode(utf8.encode(passwordUser));

    var headers = {
      "Authorization": "Basic $bytes",
      "Content-Type": "application/json",
    };
    var requestBody = json.encode(
        { 'user': userNameUser, 'password': passwordUserEncoded});
    print(headers);
    print(requestBody);

    final http.Response response = await http.post(
      url,
      body: requestBody,
      headers: headers,
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      User user = User.fromJson(responseJson);

      print('Le résultat du parse est ${user.numUser} - ${user.nom} - ${user
          .prenom} - ${user.message}');

      print("${responseJson.runtimeType}:$responseJson");
      if (user.message != null) {
        message1 = "Utilisateur ou mot de passe non valide";
        message2 = "Veuillez réessayer";
        //AlerteConnexion().alerteConnexion(context, message1, message2);
      }
    } else {
      message1 = "Problème de connexion";
      message2 = "Veuillez réessayer plus tard";
      //AlerteConnexion().alerteConnexion(context, message1, message2);
      print("Oups");
    }


    print(response.statusCode);
    print("Fini");
  }



}