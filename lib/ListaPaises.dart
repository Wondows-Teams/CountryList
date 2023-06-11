import 'package:countrylist/PaisAPI.dart';
import 'package:countrylist/PaisHttpService.dart';
import 'package:countrylist/PaisProfile.dart';
import 'package:countrylist/dataModel.dart';
import 'package:flutter/material.dart';
import 'database.dart';

class ListaPaisesPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: ListaPaises([], false),
    );
  }
}

class ListaPaises extends StatefulWidget {
  late List<String> codPaisesFiltro;
  late bool filtroActivo;
  ListaPaises(List<String> list, bool activo){
    codPaisesFiltro = list;
    filtroActivo = activo;
  }
  State<ListaPaises> createState() => _listaPaises();
}

class _listaPaises extends State<ListaPaises>{
  late Future<List<PaisAPI>> paises;
  String busqueda = "";
  PaisDatabase bbdd = PaisDatabase.instance;

  @override
  void initState() {
    super.initState();
    _fetchPaises();
  }

  _fetchPaises() async {
    Future<List<PaisAPI>> PaisList = PaisHttpService().getPaises();
    // Actualizamos la lista de películas en el estado del componente
    setState(() {
      paises = PaisList;
    });
  }
  
  actualizarBusqueda(String b){
    setState(() {
      busqueda = b;
    });
  }

  Widget build(BuildContext context) {
    _fetchPaises();
    return Column(
      children: [
        TextField(
          onSubmitted: (value) {
            actualizarBusqueda(value);
          },
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
          ),),
        Expanded(
            child: FutureBuilder(
              future: paises,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return listViewPaises(snapshot.data, widget.codPaisesFiltro,
                      widget.filtroActivo);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Center(
                    child: CircularProgressIndicator());
              },
            )
        ),

      ],
    );
  }
  ListView listViewPaises(List<PaisAPI>? paises, List<String> _codPaisesFiltro, bool _filtroActivo){
    List<PaisAPI> auxList = paises!;

    //aplicamos el filtro de países de la lista si está activo
    if(_filtroActivo){
      auxList = auxList.where((element) => _codPaisesFiltro.contains(element.alpha3Code!)).toList();
    }

    //aplicamos el filtro del campo de busqueda
     auxList = auxList.where((element) => element.name.toUpperCase().startsWith(busqueda.toUpperCase())).toList();
        if(auxList.length <= 0){
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              return Text("");
            },
          );
        }

        return ListView.builder(

          padding: EdgeInsets.all(4), // agrega padding al contenedor
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: auxList.length,
          itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PaisProfile(auxList[index]!))),
              child: Padding(padding: EdgeInsets.all(5),
            child: Card(
              elevation: 5, // agrega una sombra debajo de la tarjeta
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // redondea los bordes de la tarjeta
              ),
              child:
              Container(
                  decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child:
                  Row(
                    children: [
                      SizedBox(width: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child:  Image.network(auxList[index].flags.png!, fit: BoxFit.cover, scale: 3,),
                      ),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          // agrega un contenedor para mostrar el nombre del país
                          Container(
                            padding: EdgeInsets.all(10), // agrega padding al contenedor
                            child: Text(
                              auxList[index].name,
                              style: TextStyle(
                                fontSize: 20, // agrega un tamaño de fuente de 20 puntos
                                fontWeight: FontWeight.bold, // agrega un estilo de fuente en negrita
                                color: Colors.teal, // agrega un color azul para el texto
                              ),
                            ),
                          ),
                          Text("Capital: " + siNullVacio(auxList[index].capital),
                            style: TextStyle(
                              fontSize: 10, // agrega un tamaño de fuente de 20 puntos
                              fontWeight: FontWeight.bold, // agrega un estilo de fuente en negrita
                              color: Colors.black, // agrega un color azul para el texto
                            ),),
                          Text("Population: " + auxList[index].population.toString(),
                            style: TextStyle(
                              fontSize: 10, // agrega un tamaño de fuente de 20 puntos
                              fontWeight: FontWeight.bold, // agrega un estilo de fuente en negrita
                              color: Colors.black, // agrega un color azul para el texto
                            ),),
                          // agrega un contenedor para mostrar la puntuación del país
                          Container(
                              padding: EdgeInsets.all(10), // agrega padding al contenedor
                              child: FutureBuilder(
                                future: rating(auxList[index].alpha3Code!),
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
                              )
                          ),
                        ],
                      ),
                      ),],
                  )
              ),
            ),)
          );
          },
        ); // Listview
  }

  Future<String> rating(String codigo) async{
    late int rating = -1;
    PaisDatabase bbdd = PaisDatabase.instance;
    bool exists;

    exists = await bbdd.readRanking(codigo, paisesFavs);
    if (exists){
      await bbdd.read(codigo, paisesFavs).then(
              (value) {
            rating = value.ranking;
          }
      );
    }

    exists = await bbdd.readRanking(codigo, paisesVisitados);
    if (exists){
      await bbdd.read(codigo, paisesVisitados).then(
              (value) {
            rating = value.ranking;
          }
      );
    }

    exists = await bbdd.readRanking(codigo, paisesNoVisitados);
    if (exists){
      await bbdd.read(codigo, paisesNoVisitados).then(
              (value) {
            rating = value.ranking;
          }
      );
    }

    exists = await bbdd.readRanking(codigo, paisesPlan);
    if (exists){
      await bbdd.read(codigo, paisesPlan).then(
              (value) {
            rating = value.ranking;
          }
      );
    }

    if (rating == -1) {
      return "Not ranked";
    } else if (rating >= 5) {
      return "5/5";
    }
    else {
      return rating.toString() + "/5";
    }
  }

  String siNullVacio(String? s){
    if(s == null){
      return "Not exist";
    }else{
      return s;
    }
  }

}
