import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:testspourprojets/outils/post_commercant.dart';
import 'package:location/location.dart';
import 'dart:convert' show utf8, base64, json;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:testspourprojets/outils/ma_localisation.dart';
import 'package:testspourprojets/outils/alert_connexion.dart';
import 'package:testspourprojets/pages/page_detail_commerce.dart';
import 'package:testspourprojets/connections/class_promo.dart';
import 'package:testspourprojets/pages/page_detail_promo.dart';
import 'package:testspourprojets/outils/variables_globales.dart';




class PagePromos extends StatefulWidget {

  _PagePromos createState() => new _PagePromos();

}



class _PagePromos extends State<PagePromos> {

  TextEditingController editingController = TextEditingController();
  //var latitude;
  //var longitude;
 // var area = 50.0;

  List<Promotions> dummySearchList = List<Promotions>();
  List<Promotions> dummyListData = List<Promotions>();
  /*
  List<String> rue = [];
  List<String> numero = [];
  List<String> codePostal = [];
  List<String> ville = [];
  List<String> adresse = [];
  List<String> activite = [];
  List<String> distance = [];
  */

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    typePost = "promotion";
    maLocalisation();
    //MaLocalisation;
  }


  void filtreResultatRecherche(String query){
    print(query);
    dummySearchList.addAll(ListePromosAffiches);
    print(dummySearchList);

    if(query.isNotEmpty){
      dummySearchList.forEach((item){
        if(item.denomination.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      maListePromos.promotions.clear();
      maListePromos.promotions.addAll(dummyListData);
      setState((){
        maListePromos;
      });

      //return;
    } else {
      maListePromos.promotions.clear();
      maListePromos.promotions.addAll(ListePromosAffiches);
      setState(() {
        maListePromos;
      });
    }
    dummyListData.clear();
    dummySearchList.clear();
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //maLocalisation();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Promotions"),
        leading: new Container(), //cache le bouton back dans la appBar
      ),
      body: new Container(
        color: Theme.of(context).primaryColor,

        child: (maListePromos == null)? chargementEnCours(): listeRetour(),
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
                  itemCount: maListePromos.promotions.length,
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
                          compteurPourTouchePromo = i;
                          print("Touché!!!!!!!! $i");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => PageDetailPromo(),
                              ));
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(height: 5.0,),
                                    Text(maListePromos.promotions[i].denomination, style: TextStyle(color: Colors.white, fontSize: 15.0, fontFamily: 'CopperplateBold', fontWeight: FontWeight.w600),),
                                    Container(height: 5.0,),
                                    Text(maListePromos.promotions[i].nomPromo, style: TextStyle(color: Colors.white, fontSize: 15.0, fontFamily: 'CopperplateBold', fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                height: 45.0,
                                width: MediaQuery.of(context).size.width * 1,
                                color: Colors.deepPurple,
                                padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                alignment: Alignment.center,
                              ),
                              Container(height: 5.0,),
                              //Text(maListePromos.promotions[i].nomPromo, style: TextStyle(color: Colors.deepPurple, fontSize: 20.0, fontFamily: 'CopperplateBold'),),
                              Text("Promotion : " + maListePromos.promotions[i].description, style: TextStyle(color: Colors.deepPurple, fontSize: 15.0, fontFamily: 'CopperplateBold'),),
                              Text("Du : " + maListePromos.promotions[i].debutPromo + " au " + maListePromos.promotions[i].finPromo, style: TextStyle(color: Colors.deepPurple, fontSize: 15.0, fontFamily: 'CopperplateBold'),),
                              Text(""),
                              //Text(maListePromos.promotions[i].denomination, style: TextStyle(color: Colors.deepPurple, fontSize: 15.0, fontFamily: 'CopperplateBold'),),
                              Text("Distance : " + maListePromos.promotions[i].distanceDouble.toString() + " Km", style: TextStyle(color: Colors.deepPurple, fontSize: 15.0, fontFamily: 'CopperplateBold'),),
                              Text("Adresse : " + maListePromos.promotions[i].rue + " " + maListePromos.promotions[i].numRue + ", " + maListePromos.promotions[i].codePostal + " " + maListePromos.promotions[i].ville, style: TextStyle(color: Colors.deepPurple, fontSize: 15.0, fontFamily: 'CopperplateBold'),),
                              //Text("Activité : " + maListePromos.promotions[i].activite, style: TextStyle(color: Colors.white, fontSize: 15.0, fontFamily: 'Copperplate'),),
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

  Future maLocalisation() async {
    //BuildContext context;
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
      postPromo(latitude, longitude, area);
    }
  }

  Future<http.Response> postPromo(latitude, longitude, area) async {
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
        AlerteConnexion();

        //alerteCon(context, message1, message2);


      } else {
        PromotionList promotionList = new PromotionList.fromJson(responseJson);
        setState(() {
          maListePromos = promotionList;
        });
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

    print(response.statusCode);
    print("Fini");
  }



} //fin Class

void triSurDistance(){
  /*
  maListeCommerces.commercants.sort((a,b){
    return a.distance.compareTo(b.distance);
  });*/
  if(maListePromos.promotions.length !=1) {
    return maListePromos.promotions.sort((a, b) =>
        a.distanceDouble.compareTo(b.distanceDouble));
  } else {
    return null;
  }
}

void fonctionConversion(){
  var compteur = maListePromos.promotions.length;
  var intermediaire;
  for(var i=0; i < compteur; i++){
    double distanceConvertie = 0.0;
    distanceConvertie = double.tryParse(maListePromos.promotions[i].distance);
    intermediaire = distanceConvertie/1000;
    print(intermediaire);
    distanceConvertie = double.parse(intermediaire.toStringAsFixed(2));
    maListePromos.promotions[i].distanceDouble = distanceConvertie;
  }
}

void alerteCon( BuildContext context, message1, message2)  {
  print("brol");

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return new StatefulBuilder(builder: (context, StateSetter setState){
        return AlertDialog(
          title: new Text(message1, textScaleFactor: 1.5,),
          content: new Text(message2),
          contentPadding: EdgeInsets.all(5.0),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  print("Continuer");
                  Navigator.pop(context);
                },
                child: new Text(
                  "Continuer",
                  style: new TextStyle(color: Colors.deepPurple),))
          ],
        );//fin AlertDialog
      });

    },
  );

}

/*


 */

/*


 */