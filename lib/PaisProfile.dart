import 'package:countrylist/dataModel.dart';
import 'package:countrylist/database.dart';
import 'package:flutter/material.dart';

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
              'AFGHANISTAN',
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
                    const Text('7.5'),
                  ],
                ),
                Icon( //Image flags
                  Icons.rectangle,
                  color: Colors.red,
                  size: 50.0,
                ),
                const Text(
                  'AFG',
                ),
              ],
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Capital: Kabul',
                ),
                const Text(
                  'Población: 40218234',
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Continente: Asia',
                ),
                const Text(
                  'Región: Southern Asia',
                ),
              ],
            ),
            Row(
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
}