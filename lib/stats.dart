import 'dart:developer';

import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:countrylist/dataModel.dart';
import 'package:countrylist/database.dart';
import 'package:flutter/material.dart';

class MyStats extends StatefulWidget {


  @override
  State<MyStats> createState() => _MyStats();
}

class _MyStats extends State<MyStats> {

  late Future<List<String>> codigosVisitados;
  late Future<List<String>> codigosFavs;
  late Future<List<String>> codigosPlan;
  late Future<List<String>> codigosNoVisitados;
  late Future<List<String>> codigosRanking;

  @override
  void initState() {
    codigosVisitados = listaCodigos(paisesVisitados);
    codigosFavs = listaCodigos(paisesFavs);
    codigosPlan = listaCodigos(paisesPlan);
    codigosNoVisitados = listaCodigos(paisesNoVisitados);
    codigosRanking = listaCodigos(paisesRanking);
    super.initState();
  }


  Future<List<String>> listaCodigos(String tabla) async {
    PaisDatabase bbdd = PaisDatabase.instance;
    List<String> codigos = [];
    List<Pais> paises = [];
    paises = await bbdd.readAll(tabla);

    paises.forEach((element) {
      codigos.add(element.code);
    });

    return codigos;
  }

  Color checkColor(String countryCode, List<String> codigosFavsAux,
      List<String> codigosNoVisitadosAux, List<String> codigosPlanAux,
      List<String> codigosRankingAux, List<String> codigosVisitadosAux) {
    //codigos =  listaCodigos(paisesFavs);

    //Busqueda de en la tabla de favoritos
    if (codigosFavsAux.contains(countryCode)) {
      return Colors.amber;
    }
    if (codigosNoVisitadosAux.contains(countryCode)) {
      return Colors.red;
    }
    if (codigosPlanAux.contains(countryCode)) {
      return Colors.lightBlueAccent;
    }
    if (codigosRankingAux.contains(countryCode)) {
      return Colors.purple;
    }
    if (codigosVisitadosAux.contains(countryCode)) {
      return Colors.green;
    }
    return Colors.grey;
  }

  Color checkColorin(String countryCode, int h) {
    PaisDatabase bbdd = PaisDatabase.instance;
    List<Pais> paises = [];
    bool foundFavsColor = false;
    bool foundVisitedColor = false;
    bool foundNotVisitColor = false;
    bool foundPlanVisitColor = false;

    //Búsqueda lista visitados
    bbdd.readAll(paisesVisitados).then(
            (value) {
          paises = value;
          paises.forEach((element) {
            if (countryCode == element.code) {
              foundVisitedColor = true;
            };
          });
        }
    );


    if (foundVisitedColor == true) {
      return Colors.greenAccent;
    }

    //Busqueda en la lista de planear visitar
    bbdd.readAll(paisesPlan).then(
            (value) {
          paises = value;
          paises.forEach((element) {
            if (countryCode == element.code) {
              foundPlanVisitColor = true;
            };
          });
        }
    );

    if (foundPlanVisitColor == true) {
      return Colors.blueAccent;
    }


    //Busqueda lista no visitados
    bbdd.readAll(paisesNoVisitados).then(
            (value) {
          paises = value;
          paises.forEach((element) {
            if (countryCode == element.code) {
              foundNotVisitColor = true;
            };
          });
        }
    );

    if (foundNotVisitColor == true) {
      return Colors.redAccent;
    }

    //Busqueda de en la tabla de favoritos
    bbdd.readAll(paisesFavs).then(
            (value) {
          paises = value;
          paises.forEach((element) {
            if (countryCode == element.code) {
              foundFavsColor = true;
            };
          });
        }
    );

    if (foundFavsColor == true) {
      return Colors.amberAccent;
    }

    //Si no está en ninguno...
    return Colors.white30;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Stats"),
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: codigosFavs,
              builder: (context, snapshot1) {
                if (snapshot1.hasData) {
                  return FutureBuilder(
                    future: codigosNoVisitados,
                    builder: (context, snapshot2) {
                      if (snapshot2.hasData) {
                        return FutureBuilder(
                          future: codigosPlan,
                          builder: (context, snapshot3) {
                            if (snapshot3.hasData) {
                              return FutureBuilder(
                                future: codigosRanking,
                                builder: (context, snapshot4) {
                                  if (snapshot4.hasData) {
                                    return FutureBuilder(
                                      future: codigosVisitados,
                                      builder: (context, snapshot5) {
                                        if (snapshot5.hasData) {
                                          return Container(
                                            height: 500,
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            child: countryMap(snapshot1.data!,
                                                snapshot2.data!,
                                                snapshot3.data!,
                                                snapshot4.data!,
                                                snapshot5.data!),
                                          );
                                        } else if (snapshot5.hasError) {
                                          return Text("${snapshot5.error}");
                                        }
                                        return Center(
                                            child: CircularProgressIndicator());
                                      },
                                    );
                                  } else if (snapshot4.hasError) {
                                    return Text("${snapshot4.error}");
                                  }
                                  return Center(
                                      child: CircularProgressIndicator());
                                },
                              );
                            } else if (snapshot3.hasError) {
                              return Text("${snapshot3.error}");
                            }
                            return Center(
                                child: CircularProgressIndicator());
                          },
                        );
                      } else if (snapshot2.hasError) {
                        return Text("${snapshot2.error}");
                      }
                      return Center(
                          child: CircularProgressIndicator());
                    },
                  );
                } else if (snapshot1.hasError) {
                  return Text("${snapshot1.error}");
                }
                return Center(
                    child: CircularProgressIndicator());
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Visited countries: " ,),  Icon(Icons.rectangle, color: Colors.green, size: 20.0),],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Not visiting countries: "),  Icon(Icons.rectangle, color: Colors.red, size: 20.0),],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Favourite countries: "),  Icon(Icons.rectangle, color: Colors.amber, size: 20.0),],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Plan to visit countries: "),  Icon(Icons.rectangle, color: Colors.lightBlueAccent, size: 20.0),],
            ),
          ],
        ),
      ),
    );
  }


  Widget countryMap(List<String> codigosFavsAux,
      List<String> codigosNoVisitadosAux, List<String> codigosPlanAux,
      List<String> codigosRankingAux, List<String> codigosVisitadosAux) {
    return SizedBox(
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: InteractiveViewer(
        maxScale: 75.0,
        child: Center(
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.92,
                // Actual widget from the Countries_world_map package.
                child: SimpleMap(
                  instructions: SMapWorld.instructions,
                  colors: SMapWorldColors(
                    aD: checkColor("AND", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    aE: checkColor("ARE", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    aF: checkColor("AFG", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    aG: checkColor("ATG", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    aI: checkColor("AIA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    aL: checkColor("ALB", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    aM: checkColor("ARM", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    aN: checkColor("ANT", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    aO: checkColor("AGO", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    aQ: checkColor("ATA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    aR: checkColor("ARG", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    aS: checkColor("ASM", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    aT: checkColor("AUT", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    aU: checkColor("AUS", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    aW: checkColor("ABW", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    aX: checkColor("ALA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    aZ: checkColor("AZE", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    bA: checkColor("BIH", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    bB: checkColor("BRB", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    bD: checkColor("BGD", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    bE: checkColor("BEL", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    bF: checkColor("BFA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    bG: checkColor("BGR", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    bH: checkColor("BHR", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    bI: checkColor("BDI", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    bJ: checkColor("BEN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    bL: checkColor("BLM", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    bM: checkColor("BMU", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    bN: checkColor("BRN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    bO: checkColor("BOL", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    bQ: checkColor("BES", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    bR: checkColor("BRA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    bS: checkColor("BHS", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    bT: checkColor("BTN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    bV: checkColor("BVT", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    bW: checkColor("BWA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    bY: checkColor("BLR", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    bZ: checkColor("BLZ", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    cA: checkColor("CAN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    cC: checkColor("CCK", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    cD: checkColor("COD", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    cF: checkColor("CAF", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    cG: checkColor("COG", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    cH: checkColor("CHE", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    cI: checkColor("CIV", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    cK: checkColor("COK", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    cL: checkColor("CHL", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    cM: checkColor("CMR", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    cN: checkColor("CHN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    cO: checkColor("COL", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    cR: checkColor("CRI", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    cU: checkColor("CUB", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    cV: checkColor("CPV", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    cW: checkColor("CUW", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    cX: checkColor("CXR", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    cY: checkColor("CYP", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    cZ: checkColor("CZE", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    dE: checkColor("DEU", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    dJ: checkColor("DJI", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    dK: checkColor("DNK", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    dM: checkColor("DMA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    dO: checkColor("DOM", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    dZ: checkColor("DZA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    eC: checkColor("ECU", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    eE: checkColor("EST", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    eG: checkColor("EGY", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    eH: checkColor("ESH", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    eR: checkColor("ERI", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    eS: checkColor("ESP", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    eT: checkColor("ETH", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    fI: checkColor("FIN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    fJ: checkColor("FJI", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    fK: checkColor("FLK", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    fM: checkColor("FSM", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    fO: checkColor("FRO", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    fR: checkColor("FRA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    gA: checkColor("GAB", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    gB: checkColor("GBR", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    gD: checkColor("GRD", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    gE: checkColor("GEO", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    gF: checkColor("GUF", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    gG: checkColor("GGY", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    gH: checkColor("GHA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    gI: checkColor("GIB", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    gL: checkColor("GRL", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    gM: checkColor("GMB", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    gN: checkColor("GIN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    gP: checkColor("GLP", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    gQ: checkColor("GNQ", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    gR: checkColor("GRC", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    gS: checkColor("SGS", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    gT: checkColor("GTM", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    gU: checkColor("GUM", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    gW: checkColor("GNB", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    gY: checkColor("GUY", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    hK: checkColor("HKG", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    hM: checkColor("HMD", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    hN: checkColor("HND", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    hR: checkColor("HRV", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    hT: checkColor("HTI", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    hU: checkColor("HUN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    iD: checkColor("IDN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    iE: checkColor("IRL", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    iL: checkColor("ISR", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    iM: checkColor("IMN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    iN: checkColor("IND", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    iO: checkColor("IOT", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    iQ: checkColor("IRQ", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    iR: checkColor("IRN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    iS: checkColor("ISL", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    iT: checkColor("ITA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    jE: checkColor("JEY", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    jM: checkColor("JAM", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    jO: checkColor("JOR", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    jP: checkColor("JPN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    kE: checkColor("KEN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    kG: checkColor("KGZ", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    kH: checkColor("KHM", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    kI: checkColor("KIR", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    kM: checkColor("COM", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    kN: checkColor("KNA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    kP: checkColor("PRK", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    kR: checkColor("KOR", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    kW: checkColor("KWT", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    kY: checkColor("CYM", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    kZ: checkColor("KAZ", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    lA: checkColor("LAO", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    lB: checkColor("LBN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    lC: checkColor("LCA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    lI: checkColor("LIE", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    lK: checkColor("LKA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    lR: checkColor("LBR", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    lS: checkColor("LSO", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    lT: checkColor("LTU", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    lU: checkColor("LUX", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    lV: checkColor("LVA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    lY: checkColor("LBY", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mA: checkColor("MAR", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mC: checkColor("MCO", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mD: checkColor("MDA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mE: checkColor("MNE", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mF: checkColor("MAF", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mG: checkColor("MDG", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mH: checkColor("MHL", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mK: checkColor("MKD", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mL: checkColor("MLI", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mM: checkColor("MMR", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mN: checkColor("MNG", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mO: checkColor("MAC", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mP: checkColor("MNP", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mQ: checkColor("MTQ", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mR: checkColor("MRT", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mS: checkColor("MSR", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mT: checkColor("MLT", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mU: checkColor("MUS", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mV: checkColor("MDV", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mW: checkColor("MWI", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mX: checkColor("MEX", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mY: checkColor("MYS", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    mZ: checkColor("MOZ", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    nA: checkColor("NAM", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    nC: checkColor("NCL", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    nE: checkColor("NER", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    nF: checkColor("NFK", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    nG: checkColor("NGA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    nI: checkColor("NIC", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    nL: checkColor("NLD", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    nO: checkColor("NOR", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    nP: checkColor("NPL", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    nR: checkColor("NRU", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    nU: checkColor("NIU", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    nZ: checkColor("NZL", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    oM: checkColor("OMN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    pA: checkColor("PAN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    pE: checkColor("PER", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    pF: checkColor("PYF", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    pG: checkColor("PNG", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    pH: checkColor("PHL", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    pK: checkColor("PAL", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    pL: checkColor("POL", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    pM: checkColor("SPM", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    pN: checkColor("PCN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    pR: checkColor("PRI", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    pS: checkColor("PSE", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    pT: checkColor("PRT", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    pW: checkColor("PLW", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    pY: checkColor("PRY", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    qA: checkColor("QAT", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    rE: checkColor("REU", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    rO: checkColor("ROU", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    rS: checkColor("SRB", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    rU: checkColor("RUS", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    rW: checkColor("RWA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    sA: checkColor("SAU", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    sB: checkColor("SLB", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    sC: checkColor("SYC", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    sD: checkColor("SDN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    sE: checkColor("SWE", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    sG: checkColor("SGP", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    sH: checkColor("SHN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    sI: checkColor("SVN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    sJ: checkColor("SJM", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    sK: checkColor("SVK", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    sL: checkColor("SLE", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    sM: checkColor("SMR", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    sN: checkColor("SEN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    sO: checkColor("SOM", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    sR: checkColor("SUR", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    sS: checkColor("SSD", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    sT: checkColor("STP", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    sV: checkColor("SLV", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    sX: checkColor("SXM", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    sY: checkColor("SYR", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    sZ: checkColor("SWZ", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    tC: checkColor("TCA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    tD: checkColor("TCD", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    tF: checkColor("ATF", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    tG: checkColor("TGO", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    tH: checkColor("THA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    tJ: checkColor("TJK", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    tK: checkColor("TKL", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    tL: checkColor("TLS", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    tM: checkColor("TKM", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    tN: checkColor("TUN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    tO: checkColor("TON", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    tR: checkColor("TUR", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    tT: checkColor("TTO", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    tV: checkColor("TUV", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    tW: checkColor("TWN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    tZ: checkColor("TZA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    uA: checkColor("UKR", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    uG: checkColor("UGA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    uM: checkColor("UMI", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    uS: checkColor("USA", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    uY: checkColor("URY", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    uZ: checkColor("UZN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    vA: checkColor("VAT", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    vC: checkColor("VCT", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    vE: checkColor("VEN", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    vG: checkColor("VGB", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    vI: checkColor("VIR", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    vN: checkColor("VNM", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    vU: checkColor("VUT", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    wF: checkColor("WLF", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    wS: checkColor("WSM", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    xK: checkColor("XKX", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    yE: checkColor("YEM", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    yT: checkColor("MYT", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    zA: checkColor("ZAF", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    zM: checkColor("ZMB", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                    zW: checkColor("ZWE", codigosFavsAux, codigosNoVisitadosAux,
                        codigosPlanAux, codigosRankingAux, codigosVisitadosAux),
                  ).toMap(),
                ),
              ),
              // Creates 8% from right side so the map looks more centered.
              Container(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.08),
            ],
          ),
        ),
      ),
    );
  }
}
