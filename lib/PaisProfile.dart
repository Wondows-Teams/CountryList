import 'dart:ffi';

import 'package:countrylist/dataModel.dart';
import 'package:countrylist/database.dart';
import 'package:flutter/material.dart';

import 'PaisAPI.dart';

class PaisProfile extends StatefulWidget {

  late PaisAPI country;

  @override
  State<PaisProfile> createState() => _PaisProfile(country);

  PaisProfile(PaisAPI _country){
    this.country = _country;
  }
}

class _PaisProfile extends State<PaisProfile>{

  late PaisAPI country;
  _PaisProfile(PaisAPI _country){
    this.country = _country;
  }

  void toAddCountry(){
    OpenCountryOption();
  }

  void addCountry(String table){
    PaisDatabase bbdd = PaisDatabase.instance;
    bbdd.create(Pais(ranking: -1, code: country.alpha3Code!), table);
  }

  void OpenCountryOption() =>
      showModalBottomSheet(
        context: context,
        builder: ((builder) => pictureCountrySheet()),
      );


  Widget pictureCountrySheet(){
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text("Choose an option"),
          SizedBox(height: 20,),
          Row(
            children: [
              Icon(Icons.camera_alt),
              TextButton(onPressed: () => addCountry(paisesVisitados) , child: Text("Visited")),
            ],
          ),
          Row(
            children: [
              Icon(Icons.article),
              TextButton(onPressed: () => addCountry(paisesNoVisitados) , child: Text("Not visiting")),
            ],
          ),
          Row(
            children: [
              Icon(Icons.article),
              TextButton(onPressed: () => addCountry(paisesPlan) , child: Text("Plan to visit")),
            ],
          ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              country.name!,
              style: Theme.of(context).textTheme.headlineMedium,
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.blue,
                    ),
                     FutureBuilder(
                      future: rating(country.alpha3Code!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            "Rating: " + snapshot.data!,
                            style: TextStyle(
                              fontSize: 18, // agrega un tamaño de fuente de 18 puntos
                              fontWeight: FontWeight.bold, // agrega un estilo de fuente en negrita
                              color: Colors.green, // agrega un color verde para el texto
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
                  child:  Image.network(country.flags.png!, fit: BoxFit.cover, scale: 3,),
                ),
                Text(
                  country.alpha3Code!,
                ),
              ],
            ),


            Row(
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

            Row(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 Text(
                  'Timezone: ' + country.timezones![0],
                ),
                 Text(
                  'Area: 652230.0' + country.area!.toString(),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toAddCountry,
        tooltip: 'Increment',
        child: const Icon(Icons.add_chart),
      ),
    );
  }

  Future<String> rating(String codigo) async{
    late int rating;
    PaisDatabase bbdd = PaisDatabase.instance;
    await bbdd.read(codigo, "ranking").then(
            (value) {
          rating = value.ranking;
        }
    );
    if(rating == -1){
      return "No ranked";
    }else{
      return rating.toString() + "/10";
    }
  }
}