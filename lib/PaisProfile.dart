import 'dart:ffi';

import 'package:countrylist/dataModel.dart';
import 'package:countrylist/database.dart';
import 'package:flutter/material.dart';
import 'package:countrylist/ListaPaises.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sqflite/sqflite.dart';

import 'PaisAPI.dart';


class PaisProfile extends StatefulWidget {

  late PaisAPI country;
  @override
  State<PaisProfile> createState() => _PaisProfile(country);

  PaisProfile(PaisAPI _country) {
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
  void toAddRating(){
    OpenRatingOption();
  }

  void addCountry(String table) {
    PaisDatabase bbdd = PaisDatabase.instance;
    bbdd.create(Pais(ranking: -1, code: country.alpha3Code!), table);

    //bbdd.create(country, table);
    Navigator.pop(context);
  }

  void deleteCountry() {
    PaisDatabase bbdd = PaisDatabase.instance;
    bbdd.delete(country.alpha3Code!, paisesVisitados);
    bbdd.delete(country.alpha3Code!, paisesNoVisitados);
    bbdd.delete(country.alpha3Code!, paisesPlan);
    bbdd.delete(country.alpha3Code!, paisesFavs);
    Navigator.pop(context);
  }

  void updateRating(int newRanking) async{
    PaisDatabase bbdd = PaisDatabase.instance;
    bool exists;
    Pais temp;
    try {
      exists = await bbdd.readRanking(country.alpha3Code!, paisesFavs);
      if (exists){
        temp = await bbdd.read(country.alpha3Code!, paisesFavs);
        bbdd.update(Pais(ranking: newRanking, code: country.alpha3Code!, id: temp.id), paisesFavs);
      }
    } on DatabaseException catch (e){
      print("Ranking no actualizado. Tabla no encontrada");
    }

    try {
      exists = await bbdd.readRanking(country.alpha3Code!, paisesVisitados);
      if (exists){
        temp = await bbdd.read(country.alpha3Code!, paisesVisitados);
        bbdd.update(Pais(ranking: newRanking, code: country.alpha3Code!, id: temp.id), paisesVisitados);
        print("Ejecutado rey");
      }
    } on DatabaseException catch (e){
      print("Ranking no actualizado. Tabla no encontrada");
    }

    try {
      exists = await bbdd.readRanking(country.alpha3Code!, paisesNoVisitados);
      if (exists){
        temp = await bbdd.read(country.alpha3Code!, paisesNoVisitados);
        bbdd.update(Pais(ranking: newRanking, code: country.alpha3Code!, id: temp.id), paisesNoVisitados);
      }
    } on DatabaseException catch (e){
      print("Ranking no actualizado. Tabla no encontrada");
    }

    try {
      exists = await bbdd.readRanking(country.alpha3Code!, paisesPlan);
      if (exists){
        temp = await bbdd.read(country.alpha3Code!, paisesPlan);
        bbdd.update(Pais(ranking: newRanking, code: country.alpha3Code!, id: temp.id), paisesPlan);
      }
    } on DatabaseException catch (e){
      print("Ranking no actualizado. Tabla no encontrada");
    }
  }

  void OpenRatingOption() =>
      showModalBottomSheet(
        context: context,
        builder: ((builder) => ratingOptionSheet()),
      );

  void OpenCountryOption() =>
      showModalBottomSheet(
        context: context,
        builder: ((builder) => pictureCountrySheet()),
      );

  Widget ratingOptionSheet() {
    return FutureBuilder(
      future: ratingDouble(country.alpha3Code!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text("Indicate the rating of this country"),
                  ),
                  Spacer(),
                  RatingBar.builder(
                    initialRating: snapshot.data!,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) =>
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                    onRatingUpdate: (newRating) {
                      updateRating(newRating.toInt());
                    },
                  ),
                  Spacer(),
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context), child: Text("Go Back")),
                ],
              )
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(
            child: CircularProgressIndicator());
      },
    );
  }

  Widget pictureCountrySheet() {
    return Container(
      height: 280,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text("Add country to list:"),
          SizedBox(height: 20,),
          Row(
            children: [
              TextButton.icon(icon: Icon(Icons.star),
                  onPressed: () => addCountry(paisesFavs),
                  label: Text("Favourite")),
            ],
          ),
          Row(
            children: [
              TextButton.icon(icon: Icon(Icons.flag_circle),
                  onPressed: () => addCountry(paisesVisitados),
                  label: Text("Visited")),
            ],
          ),
          Row(
            children: [
              TextButton.icon(icon: Icon(Icons.flag_outlined),
                  onPressed: () => addCountry(paisesNoVisitados),
                  label: Text("Not visiting")),
            ],
          ),
          Row(
            children: [
              TextButton.icon(icon: Icon(Icons.flag_circle_outlined),
                  onPressed: () => addCountry(paisesPlan),
                  label: Text("Plan to visit")),
            ],
          ),
          ElevatedButton(
              onPressed: deleteCountry, child: Text("Delete from lists")),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(

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
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.teal,
                                  ),
                                  FutureBuilder(
                                    future: ratingString(country.alpha3Code!),
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
                                'Continente: ' + country.region!.name.toString(),
                              ),
                              Text(
                                'Región: ' + country.subregion!.toString(),
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
                                'Area: ' + country.area!.toString() + " km",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: ElevatedButton(
                        onPressed: toAddRating, child: Text("Rate this country!")),
                ),
              ],
            )
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: toAddCountry,
        tooltip: 'Add to list',
        child: const Icon(Icons.add_chart),
      ),
    );
  }


  Future<String> ratingString(String codigo) async {
    late int ratingS = -1;
    PaisDatabase bbdd = PaisDatabase.instance;
    bool exists;

    exists = await bbdd.readRanking(codigo, paisesFavs);
    if (exists){
      await bbdd.read(codigo, paisesFavs).then(
              (value) {
            ratingS = value.ranking;
          }
      );
    }

    exists = await bbdd.readRanking(codigo, paisesVisitados);
    if (exists){
      await bbdd.read(codigo, paisesVisitados).then(
              (value) {
            ratingS = value.ranking;
          }
      );
    }

    exists = await bbdd.readRanking(codigo!, paisesNoVisitados);
    if (exists){
      await bbdd.read(codigo, paisesNoVisitados).then(
              (value) {
            ratingS = value.ranking;
          }
      );
    }

    exists = await bbdd.readRanking(codigo, paisesPlan);
    if (exists){
      await bbdd.read(codigo, paisesPlan).then(
              (value) {
            ratingS = value.ranking;
          }
      );
    }

    if (ratingS == -1) {
      return "Not ranked";
    } else if (ratingS >= 5) {
      return "5/5";
    }
    else {
      return ratingS.toString() + "/5";
    }
  }


  Future<double> ratingDouble(String code) async {
    late double ratingD = -1;
    PaisDatabase bbdd = PaisDatabase.instance;
    bool exists;

    exists = await bbdd.readRanking(country.alpha3Code!, paisesFavs);
    if (exists){
      await bbdd.read(code, paisesFavs).then(
              (value) {
            ratingD = value.ranking.toDouble();
          }
      );
    }

    exists = await bbdd.readRanking(country.alpha3Code!, paisesNoVisitados);
    if (exists){
      await bbdd.read(code, paisesVisitados).then(
              (value) {
            ratingD = value.ranking.toDouble();
          }
      );
    }

    exists = await bbdd.readRanking(country.alpha3Code!, paisesVisitados);
    if (exists){
      await bbdd.read(code, paisesNoVisitados).then(
              (value) {
            ratingD = value.ranking.toDouble();
          }
      );
    }

    exists = await bbdd.readRanking(country.alpha3Code!, paisesPlan);
    if (exists){
      await bbdd.read(code, paisesPlan).then(
              (value) {
            ratingD = value.ranking.toDouble();
          }
      );
    }

    if (ratingD == -1) {
      return 0;
    } else if (ratingD >= 5) {
      return 5;
    } else {
      return ratingD;
    }
  }
}

