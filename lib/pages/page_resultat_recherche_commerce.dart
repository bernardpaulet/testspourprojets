import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:testspourprojets/main.dart';
import 'package:testspourprojets/outils/post_commercant.dart';
import 'package:location/location.dart';
import 'dart:convert' show utf8, base64, json;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:testspourprojets/connections/class_commercant.dart';
import 'package:testspourprojets/outils/ma_localisation.dart';
import 'package:testspourprojets/outils/alert_connexion.dart';
import 'package:testspourprojets/outils/recherche_commerce.dart';
import 'package:testspourprojets/pages/page_detail_commerce.dart';
import 'package:testspourprojets/pages/page_commercants.dart';
import 'package:testspourprojets/pages/page_promotions.dart';
import 'package:testspourprojets/pages/page_search.dart';
import 'package:testspourprojets/outils/variables_globales.dart';


//int compteurPourTouche;
//CommercantList maListeCommerces;


class PageResultatRechercheCommerces extends StatefulWidget {

  _PageResultatRechercheCommerces createState() => new _PageResultatRechercheCommerces();

}



class _PageResultatRechercheCommerces extends State<PageResultatRechercheCommerces> {



  TextEditingController editingController = TextEditingController();
  var latitude;
  var longitude;
  var area = 50.0;
  List<String> rue = [];
  List<String> numero = [];
  List<String> codePostal = [];
  List<String> ville = [];
  List<String> adresse = [];
  List<String> activite = [];
  List<String> distance = [];
  String messageFiltre = "Pas adapté";
  List<Commercant> listeCommercesAffiches = List<Commercant>();
  List<Commercant> dummySearchList = List<Commercant>();
  List<Commercant> dummyListData = List<Commercant>();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    maLocalisation();


    //post(latitude, longitude, area);
  }

  Future maLocalisation() async {
    /*BuildContext context;
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
      setState(() {
        latitude = lat;
        longitude = lon;
      });
      print("$latitude : $longitude");
      post(latitude, longitude, area);
    }*/
    latitude = latitudeChoisie;
    longitude = longitudeChoisie;
    post(latitude, longitude, area);
  }

  void filtreResultatRecherche(String query){
    print(query);
    dummySearchList.addAll(listeCommercesAffiches);
    print(dummySearchList);

    if(query.isNotEmpty){
      dummySearchList.forEach((item){
        if(item.denomination.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      maListeCommerces.commercants.clear();
      maListeCommerces.commercants.addAll(dummyListData);
      setState((){
        maListeCommerces;
      });

      //return;
    } else {
      maListeCommerces.commercants.clear();
      maListeCommerces.commercants.addAll(listeCommercesAffiches);
      setState(() {
        maListeCommerces;
      });
    }
    dummyListData.clear();
    dummySearchList.clear();
  }


  Future<http.Response> post(latitude, longitude,
      area) async {
    var url = "https://www.thegood1s.com/api/professionnel/find.php";
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
      if (responseJson == null) {
        print("Pas de commerçant");
      } else {
        CommercantList commercantList = new CommercantList.fromJson(
            responseJson);
        setState(() {
          maListeCommerces = commercantList;
        });
        listeCommercesAffiches.addAll(maListeCommerces.commercants);
        selectionActivites();

        print('Le résultat du parse est ${commercantList.commercants[2]
            .denomination} ');

        //print("${responseJson.runtimeType}:$responseJson");
        print(commercantList.commercants[0].distance);

        if (commercantList.commercants[0].denomination == null) {
          BuildContext context;
          message1 = "Oups";
          message2 = "Y a un problème";
          //AlerteConnexion().alerteConnexion(context, message1, message2);
        }
      }
    } else {
      BuildContext context;
      message1 = "Problème de connexion";
      message2 = "Veuillez réessayer plus tard";
      //AlerteConnexion().alerteConnexion(context, message1, message2);
      print("Oups");
    }

    print(response.statusCode);
    print("Fini");
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Résultat recharche Commerçants"),
        //leading: new Container(), //cache le bouton back dans la appBar
      ),

      body: new Container(
                  color: Theme.of(context).primaryColor,

                  child: (maListeCommerces == null)? chargementEnCours(): listeRetour(),
                ),
    );
  }



  Widget listeRetour(){
    fonctionConversion();
    triSurDistance();
    BuildContext context;
    return new Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 10.0,
              color: Colors.white,),
            Container(
                margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                child: new Theme(
                  data: new ThemeData(
                    primaryColor: Colors.deepPurple,
                    hintColor: Colors.deepPurple,
                  ),
                  child: new GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: new TextField(
                      onChanged: (value){
                        print("textfield adapté");
                        filtreResultatRecherche(value);
                        triSurDistance();
                      },
                      style: TextStyle(color: Colors.deepPurple,fontSize: 15.0, fontFamily: 'CopperplateBold', fontWeight: FontWeight.w300),
                      controller: editingController,
                      decoration: InputDecoration(
                        labelText: "Recherche",
                        hintText: "Recherche",
                        prefixIcon: Icon(Icons.search),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple, width: 2.0)
                        ),
                      ),
                    ),
                  ),

                )
            ),
            Container(
              height: 5.0,
              color: Colors.white,
            ),
            Container(
              height: 2.0,
              color: Colors.grey,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: maListeCommerces.commercants.length,
                  itemBuilder: (context, i) {
                    return Container (
                      //color: Colors.white,
                      //shape: new RoundedRectangleBorder(side: new BorderSide(color: Colors.deepPurple, width: 5.0), borderRadius: BorderRadius.circular(10.0)),
                      //elevation: 10.0,
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          border: Border(bottom: BorderSide(color: Colors.grey, width: 2.0))
                      ),
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      /*child: ListTile(
                      //leading: CircleAvatar(backgroundImage: NetworkImage(maListeCommerces.commercants[i].),),
                      title: new Text(maListeCommerces.commercants[i].denomination, style: TextStyle(color: Colors.white),),
                      subtitle: new Text(adresse[i], style: TextStyle(color: Colors.white),),
                    )*/
                      child: InkWell(
                        onTap: (){
                          compteurPourTouche = i;
                          print("Touché!!!!!!!! $i");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => PageDetailCommerces(),
                              ));
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(maListeCommerces.commercants[i].denomination, style: TextStyle(color: Colors.white, fontSize: 15.0, fontFamily: 'CopperplateBold', fontWeight: FontWeight.w600)),
                                height: 25.0,
                                width: MediaQuery.of(context).size.width * 1,
                                color: Colors.deepPurple,
                                padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                alignment: Alignment.center,
                              ),
                              Container(height: 5.0,),
                              //Text(maListeCommerces.commercants[i].denomination, style: TextStyle(color: Colors.deepPurple, fontSize: 15.0, fontFamily: 'CopperplateBold', fontWeight: FontWeight.w600)),
                              Text("Distance : " + maListeCommerces.commercants[i].distanceDouble.toString() + " Km", style: TextStyle(color: Colors.black, fontSize: 15.0, fontFamily: 'CopperplateBold'),),
                              Text("Adresse : " + maListeCommerces.commercants[i].rue + " " + maListeCommerces.commercants[i].numRue + ", " + maListeCommerces.commercants[i].codePostal + " " + maListeCommerces .commercants[i].ville, style: TextStyle(color: Colors.black, fontSize: 15.0, fontFamily: 'CopperplateBold'),),
                              Text("Activité : " + maListeCommerces.commercants[i].activite, style: TextStyle(color: Colors.black, fontSize: 15.0, fontFamily: 'CopperplateBold'),),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),

          ],
        )
    );
  }


  Widget chargementEnCours() {

    return new Container(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ),
      alignment: Alignment.center,
      color: Colors.white,
    );

  }

/*
  Widget faitAdresse(){
    var compteur = maListeCommerces.commercants.length;
    print("Compteur : $compteur");

    for (var i=0; i < compteur; i++){

      if(maListeCommerces.commercants[i].rue != null){
        rue.add(maListeCommerces.commercants[i].rue);
      } else {
        rue.add(" ");
      }

      if(maListeCommerces.commercants[i].numRue != null){
        numero.add(maListeCommerces.commercants[i].numRue);
      } else {
        numero.add(" ");
      }

      if(maListeCommerces.commercants[i].codePostal != null){
        codePostal.add(maListeCommerces.commercants[i].codePostal);
      } else {
        codePostal.add(" ");
      }

      if(maListeCommerces.commercants[i].ville != null){
        ville.add(maListeCommerces.commercants[i].ville);
      } else {
        ville.add(" ");
      }

      if(maListeCommerces.commercants[i].activite != null){
        activite.add(maListeCommerces.commercants[i].activite);
      } else {
        activite.add(" ");
      }

      if(maListeCommerces.commercants[i].distance != null){
        distance.add(maListeCommerces.commercants[i].distance);
      } else {
        distance.add(" ");
      }

      if(maListeCommerces.commercants[i].distance == null){
        //maListeCommerces.commercants[i].distance.;
      }

      adresse.add("Adresse : " + rue[i] + " " + numero[i] + ", " + codePostal[i] + " " + ville[i] + "\n" + activite[i]);

    }
  }
  */
}



void triSurDistance(){
  /*
  maListeCommerces.commercants.sort((a,b){
    return a.distance.compareTo(b.distance);
  });*/
  return maListeCommerces.commercants.sort((a, b) => a.distanceDouble.compareTo(b.distanceDouble));
}

void fonctionConversion(){
  var compteur = maListeCommerces.commercants.length;
  var intermediaire;
  for(var i=0; i < compteur; i++){
    double distanceConvertie = 0.0;
    distanceConvertie = double.tryParse(maListeCommerces.commercants[i].distance);
    intermediaire = distanceConvertie/1000;
    print(intermediaire);
    distanceConvertie = double.parse(intermediaire.toStringAsFixed(2));
    maListeCommerces.commercants[i].distanceDouble = distanceConvertie;
  }
}

void selectionActivites(){
  List<Commercant> listeCommercesActivite = List<Commercant>();
  if(activiteChoisie == ""){
    print("pas d'activité choisie");
  } else {
    //ENCORE A FAIRE
    maListeCommerces.commercants.forEach((item){
      if(item.activite.toLowerCase().contains(activiteChoisie.toLowerCase())) {
        listeCommercesActivite.add(item);
      }
    });
    maListeCommerces.commercants.clear();
    maListeCommerces.commercants.addAll(listeCommercesActivite);
  }
}





