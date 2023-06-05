import 'dart:ffi';

import 'package:countrylist/dataModel.dart';
import 'package:countrylist/database.dart';
import 'package:flutter/material.dart';
import 'package:countrylist/ListaPaises.dart';

import 'PaisAPI.dart';

class PaisProfile extends StatefulWidget {

  late PaisAPI country;

  @override
  State<PaisProfile> createState() => _PaisProfile(country);

  PaisProfile(PaisAPI _country){
    this.country = _country;
  }
}

class _PaisProfile extends State<PaisProfile> {

  late PaisAPI country;

  _PaisProfile(PaisAPI _country) {
    this.country = _country;
  }

  void toAddCountry() {
    OpenCountryOption();
  }

  void addCountry(String table) {
    PaisDatabase bbdd = PaisDatabase.instance;
    bbdd.create(Pais(ranking: -1, code: country.alpha3Code!), table);
    //bbdd.create(country, table);
    Navigator.pop(context);
  }
  void deleteCountry(){
    PaisDatabase bbdd = PaisDatabase.instance;
    bbdd.delete(country.alpha3Code!, paisesVisitados);
    bbdd.delete(country.alpha3Code!, paisesNoVisitados);
    bbdd.delete(country.alpha3Code!, paisesPlan);
    Navigator.pop(context);
  }
  void OpenCountryOption() =>
      showModalBottomSheet(
        context: context,
        builder: ((builder) => pictureCountrySheet()),
      );


  Widget pictureCountrySheet() {
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
                      country.name!,
                      style: TextStyle(
                        fontSize: 20,
                        // agrega un tamaño de fuente de 20 puntos
                        fontWeight: FontWeight.bold,
                        // agrega un estilo de fuente en negrita
                        color: Colors
                            .teal, // agrega un color azul para el texto
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row( //Estrella+Puntuación
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.teal,
                            ),
                            FutureBuilder(
                              future: rating(country.alpha3Code!),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    "Rating: " + snapshot.data!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      // agrega un tamaño de fuente de 18 puntos
                                      fontWeight: FontWeight.bold,
                                      // agrega un estilo de fuente en negrita
                                      color: Colors
                                          .green, // agrega un color verde para el texto
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ],
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(country.flags.png!,
                            fit: BoxFit.cover, scale: 3,),
                        ),
                        Text(
                          country.alpha3Code!,
                        ),
                      ],
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Capital: ' + country.capital!,
                        ),
                        Text(
                          'Población: ' + country.population!.toString(),
                        ),
                      ],
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Continente: ' + country.region!.toString(),
                        ),
                        Text(
                          'Región: ' + country.subregion!,
                        ),
                      ],
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Timezone: ' + country.timezones![0],
                        ),
                        Text(
                          'Area:' + country.area!.toString(),
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

  Future<String> rating(String codigo) async {
    late int rating;
    PaisDatabase bbdd = PaisDatabase.instance;
    await bbdd.read(codigo, "ranking").then(
            (value) {
          rating = value.ranking;
        }
    );
    if (rating == -1) {
      return "No ranked";
    } else {
      return rating.toString() + "/10";
    }
  }
}
