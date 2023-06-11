
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';

import 'ListaPaises.dart';
import 'dataModel.dart';
import 'database.dart';

class MyCountryList extends StatefulWidget {


  @override
  State<MyCountryList> createState() => _MyCountryList();
}

class _MyCountryList extends State<MyCountryList>{

  void toEditScreen(){

  }

  @override
  Widget build (BuildContext context){
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Your Country List"),
            leading: BackButton(
              onPressed: () => Navigator.pop(context),
            ),
            bottom: TabBar(
              tabs: [
                Tab(text: "Visited",),
                Tab(text: "Not visiting",),
                Tab(text: "Plan to visit",),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: toEditScreen,
            child: Icon(Icons.edit_note),
          ),

          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: TabBarView(
              children: [
                VisitedCountry(),
                NotVisitingCountry(),
                PlanToVisitCountry(),
              ],
            ),
          ),
        ),
    );
  }
}

class VisitedCountry extends StatelessWidget {

  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Visited countries:',
          style: TextStyle(
            fontSize: 30, // agrega un tamaño de fuente de 20 puntos
            fontWeight: FontWeight.bold, // agrega un estilo de fuente en negrita
            color: Colors.teal, // agrega un color azul para el texto

          ),
        ),
        Expanded(
          child: ListaPaises(listaCodigos("visited"), true),
        ),
      ],
    );
  }
}

class NotVisitingCountry extends StatelessWidget {

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Countries not going to visit:',
          style: TextStyle(
            fontSize: 30, // agrega un tamaño de fuente de 20 puntos
            fontWeight: FontWeight.bold, // agrega un estilo de fuente en negrita
            color: Colors.teal, // agrega un color azul para el texto

          ),
        ),
        Expanded(
          child: ListaPaises(listaCodigos("notVisited"), true),
        ),
      ],
    );
  }
}

class PlanToVisitCountry extends StatelessWidget {

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Countries planing to visit:',
          style: TextStyle(
            fontSize: 30, // agrega un tamaño de fuente de 20 puntos
            fontWeight: FontWeight.bold, // agrega un estilo de fuente en negrita
            color: Colors.teal, // agrega un color azul para el texto

          ),
        ),
        Expanded(
          child: ListaPaises(listaCodigos("planned"), true),
        ),
      ],
    );
  }
}
List<String> listaCodigos(String tabla){
  PaisDatabase bbdd = PaisDatabase.instance;
  List<String> codigos = [];
  List<Pais> paises = [];
  bbdd.readAll(tabla).then(
          (value) {
        paises = value;
        paises.forEach((element) {
          codigos.add(element.code);
        });
      }
  );
  return codigos;
}
