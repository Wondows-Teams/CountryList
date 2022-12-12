import 'package:countrylist/dataModel.dart';
import 'package:countrylist/database.dart';
import 'package:flutter/material.dart';

import 'package:countrylist/ListaPaises.dart';

class PaisProfile extends StatefulWidget {

  @override
  State<PaisProfile> createState() => _PaisProfile();

}

class _PaisProfile extends State<PaisProfile>{

  Pais country = Pais(ranking: 0, code: "AFG");

  void toAddCountry(){
    OpenCountryOption();
  }

  void addCountry(String table){
    PaisDatabase bbdd = PaisDatabase.instance;
    bbdd.create(country, table);
    Navigator.pop(context);
  }
  void deleteCountry(){
    PaisDatabase bbdd = PaisDatabase.instance;
    bbdd.delete(country.code, paisesVisitados);
    bbdd.delete(country.code, paisesNoVisitados);
    bbdd.delete(country.code, paisesPlan);
    Navigator.pop(context);
  }
  void OpenCountryOption() =>
      showModalBottomSheet(
        context: context,
        builder: ((builder) => pictureCountrySheet()),
      );


  Widget pictureCountrySheet(){
    return Container(
      height: 230,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text("Add country to list:"),
          SizedBox(height: 20,),
          Row(
            children: [
              TextButton.icon(icon: Icon(Icons.flag_circle),onPressed: () => addCountry(paisesVisitados) , label: Text("Visited")),
            ],
          ),
          Row(
            children: [
              TextButton.icon(icon: Icon(Icons.flag_outlined),onPressed: () => addCountry(paisesNoVisitados) , label: Text("Not visiting")),
            ],
          ),
          Row(
            children: [
              TextButton.icon(icon: Icon(Icons.flag_circle_outlined),onPressed: () => addCountry(paisesPlan) , label: Text("Plan to visit")),
            ],
          ),
          ElevatedButton(onPressed: deleteCountry, child: Text("Delete from lists")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Country Profile"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            //color: Colors.teal.shade900,
          ),

          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),

            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.teal.shade100,
                    width: 20,
                  ),
                  color: Colors.teal.shade100,
                  borderRadius: BorderRadius.circular(15)
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(padding: EdgeInsets.all(5),
                    child: Text(
                      'AFGHANISTAN',
                      style: TextStyle(
                        fontSize: 20, // agrega un tamaño de fuente de 20 puntos
                        fontWeight: FontWeight.bold, // agrega un estilo de fuente en negrita
                        color: Colors.teal, // agrega un color azul para el texto
                      ),
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(//Estrella+Puntuación
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.teal,
                            ),
                            const Text('7.5'),
                          ],
                        ),
                        Icon( //Image FLAG
                          Icons.rectangle,
                          color: Colors.redAccent,
                          size: 50.0,
                        ),
                        const Text(
                          'AFG',
                        ),
                      ],
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(5),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Capital: Kabul',
                        ),
                        const Text(
                          'Population: 40218234',
                        ),
                      ],
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(5),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Continent: Asia',
                        ),
                        const Text(
                          'Subregion: Southern Asia',
                        ),
                      ],
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Timezone: UTC+04:30',
                        ),
                        const Text(
                          'Area: 652230.0',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toAddCountry,
        tooltip: 'Add to list',
        child: const Icon(Icons.add_chart),
      ),
    );
  }
}