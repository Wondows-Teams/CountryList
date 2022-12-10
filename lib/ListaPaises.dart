import 'package:countrylist/PaisAPI.dart';
import 'package:countrylist/PaisHttpService.dart';
import 'package:flutter/material.dart';

class ListaPaisesPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListaPaises(["ESP", "BR", "AFG"], false),
    );
  }
}

class ListaPaises extends StatefulWidget {
  late final List<String> codPaisesFiltro;
  late final bool filtroActivo;
  ListaPaises(List<String> list, bool activo){
    codPaisesFiltro = list;
    filtroActivo = activo;
  }
  State<ListaPaises> createState() => _listaPaises();
}

class _listaPaises extends State<ListaPaises>{
  late Future<List<PaisAPI>> paises;
  String busqueda = "";

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
    return Scaffold(
        appBar: AppBar(
          title: Text("Holw ewns"),
        ),
        body: Column(
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
                        return listViewPaises(snapshot.data, widget.codPaisesFiltro, widget.filtroActivo);
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
              return Text("No se han encontrado países que cumplan los requisitos");
            },
          );
        }

        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: auxList.length,

        itemBuilder: (context, index) {
          return Card(
            elevation: 5, // agrega una sombra debajo de la tarjeta
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // redondea los bordes de la tarjeta
            ),
            child: Column(
              children: [
                // agrega una imagen que ocupa toda la anchura de la tarjeta
                Image.network(auxList[index].flags.png!, height: 100,width: 100,),
                // agrega un contenedor para mostrar el nombre del país
                Container(
                  padding: EdgeInsets.all(10), // agrega padding al contenedor
                  child: Text(
                    auxList[index].name,
                    style: TextStyle(
                      fontSize: 20, // agrega un tamaño de fuente de 20 puntos
                      fontWeight: FontWeight.bold, // agrega un estilo de fuente en negrita
                      color: Colors.blue, // agrega un color azul para el texto
                    ),
                  ),
                ),
                // agrega un contenedor para mostrar la puntuación del país
                Text("Poblacion: " + auxList[index].population.toString()),
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
