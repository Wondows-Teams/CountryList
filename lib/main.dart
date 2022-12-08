import 'dart:convert';

import 'package:countrylist/Pais.dart';
import 'package:countrylist/PaisDetail.dart';
import 'package:countrylist/PaisHttpService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListaPaises(),
    );
  }
}

class ListaPaises extends StatefulWidget {
  State<ListaPaises> createState() => _listaPaises();
}

class _listaPaises extends State<ListaPaises>{
  //late ScrollController controller = ScrollController();
  late Future<List<Pais>> paises;
  //int numPag = 0;

  @override
  void initState() {
    super.initState();
    //controller.addListener((){
      //if(controller.position.pixels == controller.position.maxScrollExtent){
        //_fetchPaises(numPag);
      //
    //});
    // Realiza una llamada a la API al inicializar el componente
    _fetchPaises();
  }

  _fetchPaises() async {
    Future<List<Pais>> PaisList = PaisHttpService().getPaises();
    // Actualizamos la lista de películas en el estado del componente
    setState(() {
      paises = PaisList;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Holw ewns"),
        ),
        body: FutureBuilder(
              future: paises,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return listViewPaises(snapshot.data);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                  return Center(
                    child: CircularProgressIndicator());
              },
            )
    );
  }

  ListView listViewPaises(List<Pais>? paises){


        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: paises!.length,

        itemBuilder: (context, index) {
          return Card(
            elevation: 5, // agrega una sombra debajo de la tarjeta
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // redondea los bordes de la tarjeta
            ),
            child: Column(
              children: [
                // agrega una imagen que ocupa toda la anchura de la tarjeta
                Image.network(paises![index].flag),
                // agrega un contenedor para mostrar el nombre del país
                Container(
                  padding: EdgeInsets.all(10), // agrega padding al contenedor
                  child: Text(
                    paises![index].name,
                    style: TextStyle(
                      fontSize: 20, // agrega un tamaño de fuente de 20 puntos
                      fontWeight: FontWeight.bold, // agrega un estilo de fuente en negrita
                      color: Colors.blue, // agrega un color azul para el texto
                    ),
                  ),
                ),
                // agrega un contenedor para mostrar la puntuación del país
                Container(
                  padding: EdgeInsets.all(10), // agrega padding al contenedor
                  child: Text(
                    "10",
                    style: TextStyle(
                      fontSize: 18, // agrega un tamaño de fuente de 18 puntos
                      fontWeight: FontWeight.bold, // agrega un estilo de fuente en negrita
                      color: Colors.green, // agrega un color verde para el texto
                    ),
                  ),
                ),
              ],
            ),
          );
          },
        ); // Listview
  }
}
