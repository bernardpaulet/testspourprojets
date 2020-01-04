import 'package:flutter/material.dart';
import 'package:testspourprojets/main.dart';
import 'package:testspourprojets/pages/page_commercants.dart';
import 'package:testspourprojets/pages/page_promotions.dart';
import 'package:testspourprojets/pages/page_search.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage>{

  int _currentIndex = 0;
  final List<Widget> _children = [
    PageCommerces(),
    PagePromos(),
    PageSearch(),
  ];



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      /*appBar: AppBar(
        title: Text(titreApp),
      ),*/
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text("Commerçants")
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.notifications),
            title: new Text("Promos")
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            title: new Text("Recherche")
          )
        ]
      ),
    );
  }

  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

}