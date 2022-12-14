import 'dart:developer';

import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/world/simple_world/src/painter.dart';
import 'package:countrylist/dataModel.dart';
import 'package:countrylist/database.dart';
import 'package:flutter/material.dart';

class MyStats extends StatefulWidget {


  @override
  State<MyStats> createState() => _MyStats();
}

class _MyStats extends State<MyStats>{

    late Future<List<String>> codigos;

    @override
    void initState(){
      codigos = listaCodigos(paisesVisitados);
      super.initState();
    }


    Future<List<String>> listaCodigos(String tabla) async{
    PaisDatabase bbdd = PaisDatabase.instance;
    List<String> codigos = [];
    List<Pais> paises = [];
    paises = await bbdd.readAll(tabla);

    paises.forEach((element) {
      codigos.add(element.code);
    });
    
    return codigos;
  }

    Color checkColor(String countryCode, List<String> codigosAux) {

    //codigos =  listaCodigos(paisesFavs);

    //Busqueda de en la tabla de favoritos
    if (codigosAux.contains(countryCode)){
        return Colors.green;
    }
    return Colors.grey;
  }

  Color checkColorin(String countryCode, int h){
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
            if (countryCode == element.code){
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
            if (countryCode == element.code){
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
            if (countryCode == element.code){
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
            if (countryCode == element.code){
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
    Widget build (BuildContext context){
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
                future: codigos,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data!);
                    return Container(
                      height: 500,
                      width: MediaQuery.of(context).size.width,
                      child: countryMap(snapshot.data!),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(
                      child: CircularProgressIndicator());
                },
              )


            ],
          ),
        ),
      );
    }





  Widget countryMap(List<String> codigosAux){

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: InteractiveViewer(
        maxScale: 75.0,
        child: Center(
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                // Actual widget from the Countries_world_map package.
                child: SimpleWorldMap(
                  countryColors: SimpleWorldCountryColors(
                    aD: checkColor("AND", codigosAux),
                    aE: checkColor("ARE", codigosAux),
                    aF: checkColor("AFG", codigosAux),
                    aG: checkColor("ATG", codigosAux),
                    aI: checkColor("AIA", codigosAux),
                    aL: checkColor("ALB", codigosAux),
                    aM: checkColor("ARM", codigosAux),
                    aN: checkColor("ANT", codigosAux),
                    aO: checkColor("AGO", codigosAux),
                    aQ: checkColor("ATA", codigosAux),
                    aR: checkColor("ARG", codigosAux),
                    aS: checkColor("ASM", codigosAux),
                    aT: checkColor("AUT", codigosAux),
                    aU: checkColor("AUS", codigosAux),
                    aW: checkColor("ABW", codigosAux),
                    aX: checkColor("ALA", codigosAux),
                    aZ: checkColor("AZE", codigosAux),
                    bA: checkColor("BIH", codigosAux),
                    bB: checkColor("BRB", codigosAux),
                    bD: checkColor("BGD", codigosAux),
                    bE: checkColor("BEL", codigosAux),
                    bF: checkColor("BFA", codigosAux),
                    bG: checkColor("BGR", codigosAux),
                    bH: checkColor("BHR", codigosAux),
                    bI: checkColor("BDI", codigosAux),
                    bJ: checkColor("BEN", codigosAux),
                    bL: checkColor("BLM", codigosAux),
                    bM: checkColor("BMU", codigosAux),
                    bN: checkColor("BRN", codigosAux),
                    bO: checkColor("BOL", codigosAux),
                    bQ: checkColor("BES", codigosAux),
                    bR: checkColor("BRA", codigosAux),
                    bS: checkColor("BHS", codigosAux),
                    bT: checkColor("BTN", codigosAux),
                    bV: checkColor("BVT", codigosAux),
                    bW: checkColor("BWA", codigosAux),
                    bY: checkColor("BLR", codigosAux),
                    bZ: checkColor("BLZ", codigosAux),
                    cA: checkColor("CAN", codigosAux),
                    cC: checkColor("CCK", codigosAux),
                    cD: checkColor("COD", codigosAux),
                    cF: checkColor("CAF", codigosAux),
                    cG: checkColor("COG", codigosAux),
                    cH: checkColor("CHE", codigosAux),
                    cI: checkColor("CIV", codigosAux),
                    cK: checkColor("COK", codigosAux),
                    cL: checkColor("CHL", codigosAux),
                    cM: checkColor("CMR", codigosAux),
                    cN: checkColor("CHN", codigosAux),
                    cO: checkColor("COL", codigosAux),
                    cR: checkColor("CRI", codigosAux),
                    cU: checkColor("CUB", codigosAux),
                    cV: checkColor("CPV", codigosAux),
                    cW: checkColor("CUW", codigosAux),
                    cX: checkColor("CXR", codigosAux),
                    cY: checkColor("CYP", codigosAux),
                    cZ: checkColor("CZE", codigosAux),
                    dE: checkColor("DEU", codigosAux),
                    dJ: checkColor("DJI", codigosAux),
                    dK: checkColor("DNK", codigosAux),
                    dM: checkColor("DMA", codigosAux),
                    dO: checkColor("DOM", codigosAux),
                    dZ: checkColor("DZA", codigosAux),
                    eC: checkColor("ECU", codigosAux),
                    eE: checkColor("EST", codigosAux),
                    eG: checkColor("EGY", codigosAux),
                    eH: checkColor("ESH", codigosAux),
                    eR: checkColor("ERI", codigosAux),
                    eS: checkColor("ESP", codigosAux),
                    eT: checkColor("ETH", codigosAux),
                    fI: checkColor("FIN", codigosAux),
                    fJ: checkColor("FJI", codigosAux),
                    fK: checkColor("FLK", codigosAux),
                    fM: checkColor("FSM", codigosAux),
                    fO: checkColor("FRO", codigosAux),
                    fR: checkColor("FRA", codigosAux),
                    gA: checkColor("GAB", codigosAux),
                    gB: checkColor("GBR", codigosAux),
                    gD: checkColor("GRD", codigosAux),
                    gE: checkColor("GEO", codigosAux),
                    gF: checkColor("GUF", codigosAux),
                    gG: checkColor("GGY", codigosAux),
                    gH: checkColor("GHA", codigosAux),
                    gI: checkColor("GIB", codigosAux),
                    gL: checkColor("GRL", codigosAux),
                    gM: checkColor("GMB", codigosAux),
                    gN: checkColor("GIN", codigosAux),
                    gP: checkColor("GLP", codigosAux),
                    gQ: checkColor("GNQ", codigosAux),
                    gR: checkColor("GRC", codigosAux),
                    gS: checkColor("SGS", codigosAux),
                    gT: checkColor("GTM", codigosAux),
                    gU: checkColor("GUM", codigosAux),
                    gW: checkColor("GNB", codigosAux),
                    gY: checkColor("GUY", codigosAux),
                    hK: checkColor("HKG", codigosAux),
                    hM: checkColor("HMD", codigosAux),
                    hN: checkColor("HND", codigosAux),
                    hR: checkColor("HRV", codigosAux),
                    hT: checkColor("HTI", codigosAux),
                    hU: checkColor("HUN", codigosAux),
                    iD: checkColor("IDN", codigosAux),
                    iE: checkColor("IRL", codigosAux),
                    iL: checkColor("ISR", codigosAux),
                    iM: checkColor("IMN", codigosAux),
                    iN: checkColor("IND", codigosAux),
                    iO: checkColor("IOT", codigosAux),
                    iQ: checkColor("IRQ", codigosAux),
                    iR: checkColor("IRN", codigosAux),
                    iS: checkColor("ISL", codigosAux),
                    iT: checkColor("ITA", codigosAux),
                    jE: checkColor("JEY", codigosAux),
                    jM: checkColor("JAM", codigosAux),
                    jO: checkColor("JOR", codigosAux),
                    jP: checkColor("JPN", codigosAux),
                    kE: checkColor("KEN", codigosAux),
                    kG: checkColor("KGZ", codigosAux),
                    kH: checkColor("KHM", codigosAux),
                    kI: checkColor("KIR", codigosAux),
                    kM: checkColor("COM", codigosAux),
                    kN: checkColor("KNA", codigosAux),
                    kP: checkColor("PRK", codigosAux),
                    kR: checkColor("KOR", codigosAux),
                    kW: checkColor("KWT", codigosAux),
                    kY: checkColor("CYM", codigosAux),
                    kZ: checkColor("KAZ", codigosAux),
                    lA: checkColor("LAO", codigosAux),
                    lB: checkColor("LBN", codigosAux),
                    lC: checkColor("LCA", codigosAux),
                    lI: checkColor("LIE", codigosAux),
                    lK: checkColor("LKA", codigosAux),
                    lR: checkColor("LBR", codigosAux),
                    lS: checkColor("LSO", codigosAux),
                    lT: checkColor("LTU", codigosAux),
                    lU: checkColor("LUX", codigosAux),
                    lV: checkColor("LVA", codigosAux),
                    lY: checkColor("LBY", codigosAux),
                    mA: checkColor("MAR", codigosAux),
                    mC: checkColor("MCO", codigosAux),
                    mD: checkColor("MDA", codigosAux),
                    mE: checkColor("MNE", codigosAux),
                    mF: checkColor("MAF", codigosAux),
                    mG: checkColor("MDG", codigosAux),
                    mH: checkColor("MHL", codigosAux),
                    mK: checkColor("MKD", codigosAux),
                    mL: checkColor("MLI", codigosAux),
                    mM: checkColor("MMR", codigosAux),
                    mN: checkColor("MNG", codigosAux),
                    mO: checkColor("MAC", codigosAux),
                    mP: checkColor("MNP", codigosAux),
                    mQ: checkColor("MTQ", codigosAux),
                    mR: checkColor("MRT", codigosAux),
                    mS: checkColor("MSR", codigosAux),
                    mT: checkColor("MLT", codigosAux),
                    mU: checkColor("MUS", codigosAux),
                    mV: checkColor("MDV", codigosAux),
                    mW: checkColor("MWI", codigosAux),
                    mX: checkColor("MEX", codigosAux),
                    mY: checkColor("MYS", codigosAux),
                    mZ: checkColor("MOZ", codigosAux),
                    nA: checkColor("NAM", codigosAux),
                    nC: checkColor("NCL", codigosAux),
                    nE: checkColor("NER", codigosAux),
                    nF: checkColor("NFK", codigosAux),
                    nG: checkColor("NGA", codigosAux),
                    nI: checkColor("NIC", codigosAux),
                    nL: checkColor("NLD", codigosAux),
                    nO: checkColor("NOR", codigosAux),
                    nP: checkColor("NPL", codigosAux),
                    nR: checkColor("NRU", codigosAux),
                    nU: checkColor("NIU", codigosAux),
                    nZ: checkColor("NZL", codigosAux),
                    oM: checkColor("OMN", codigosAux),
                    pA: checkColor("PAN", codigosAux),
                    pE: checkColor("PER", codigosAux),
                    pF: checkColor("PYF", codigosAux),
                    pG: checkColor("PNG", codigosAux),
                    pH: checkColor("PHL", codigosAux),
                    pK: checkColor("PAL", codigosAux),
                    pL: checkColor("POL", codigosAux),
                    pM: checkColor("SPM", codigosAux),
                    pN: checkColor("PCN", codigosAux),
                    pR: checkColor("PRI", codigosAux),
                    pS: checkColor("PSE", codigosAux),
                    pT: checkColor("PRT", codigosAux),
                    pW: checkColor("PLW", codigosAux),
                    pY: checkColor("PRY", codigosAux),
                    qA: checkColor("QAT", codigosAux),
                    rE: checkColor("REU", codigosAux),
                    rO: checkColor("ROU", codigosAux),
                    rS: checkColor("SRB", codigosAux),
                    rU: checkColor("RUS", codigosAux),
                    rW: checkColor("RWA", codigosAux),
                    sA: checkColor("SAU", codigosAux),
                    sB: checkColor("SLB", codigosAux),
                    sC: checkColor("SYC", codigosAux),
                    sD: checkColor("SDN", codigosAux),
                    sE: checkColor("SWE", codigosAux),
                    sG: checkColor("SGP", codigosAux),
                    sH: checkColor("SHN", codigosAux),
                    sI: checkColor("SVN", codigosAux),
                    sJ: checkColor("SJM", codigosAux),
                    sK: checkColor("SVK", codigosAux),
                    sL: checkColor("SLE", codigosAux),
                    sM: checkColor("SMR", codigosAux),
                    sN: checkColor("SEN", codigosAux),
                    sO: checkColor("SOM", codigosAux),
                    sR: checkColor("SUR", codigosAux),
                    sS: checkColor("SSD", codigosAux),
                    sT: checkColor("STP", codigosAux),
                    sV: checkColor("SLV", codigosAux),
                    sX: checkColor("SXM", codigosAux),
                    sY: checkColor("SYR", codigosAux),
                    sZ: checkColor("SWZ", codigosAux),
                    tC: checkColor("TCA", codigosAux),
                    tD: checkColor("TCD", codigosAux),
                    tF: checkColor("ATF", codigosAux),
                    tG: checkColor("TGO", codigosAux),
                    tH: checkColor("THA", codigosAux),
                    tJ: checkColor("TJK", codigosAux),
                    tK: checkColor("TKL", codigosAux),
                    tL: checkColor("TLS", codigosAux),
                    tM: checkColor("TKM", codigosAux),
                    tN: checkColor("TUN", codigosAux),
                    tO: checkColor("TON", codigosAux),
                    tR: checkColor("TUR", codigosAux),
                    tT: checkColor("TTO", codigosAux),
                    tV: checkColor("TUV", codigosAux),
                    tW: checkColor("TWN", codigosAux),
                    tZ: checkColor("TZA", codigosAux),
                    uA: checkColor("UKR", codigosAux),
                    uG: checkColor("UGA", codigosAux),
                    uM: checkColor("UMI", codigosAux),
                    uS: checkColor("USA", codigosAux),
                    uY: checkColor("URY", codigosAux),
                    uZ: checkColor("UZN", codigosAux),
                    vA: checkColor("VAT", codigosAux),
                    vC: checkColor("VCT", codigosAux),
                    vE: checkColor("VEN", codigosAux),
                    vG: checkColor("VGB", codigosAux),
                    vI: checkColor("VIR", codigosAux),
                    vN: checkColor("VNM", codigosAux),
                    vU: checkColor("VUT", codigosAux),
                    wF: checkColor("WLF", codigosAux),
                    wS: checkColor("WSM", codigosAux),
                    xK: checkColor("XKX", codigosAux),
                    yE: checkColor("YEM", codigosAux),
                    yT: checkColor("MYT", codigosAux),
                    zA: checkColor("ZAF", codigosAux),
                    zM: checkColor("ZMB", codigosAux),
                    zW: checkColor("ZWE", codigosAux),
                  ),
                ),
              ),
              // Creates 8% from right side so the map looks more centered.
              Container(width: MediaQuery.of(context).size.width * 0.08),
            ],
          ),
        ),
      ),
    );
  }


}