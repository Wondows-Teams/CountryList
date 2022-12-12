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

  List<String> listaCodigos(String tabla) {
    PaisDatabase bbdd = PaisDatabase.instance;
    List<String> codigos = [];
    List<Pais> paises = [];
    bbdd.readAll(tabla).then(
            (value) {
          paises = value;
          paises.forEach((element) {
            codigos.add(element.code);
          });
        }
    );
    return codigos;
  }
  Color checkColor(String countryCode){

    List<String> codigos = [];


    codigos = listaCodigos(paisesFavs);
    //Busqueda de en la tabla de favoritos
    if (codigos.contains(countryCode)){
        return Colors.yellow;
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
  Widget countryMap(){

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
                    aD: checkColor("AND"),
                    aE: checkColor("ARE"),
                    aF: checkColor("AFG"),
                    aG: checkColor("ATG"),
                    aI: checkColor("AIA"),
                    aL: checkColor("ALB"),
                    aM: checkColor("ARM"),
                    aN: checkColor("ANT"),
                    aO: checkColor("AGO"),
                    aQ: checkColor("ATA"),
                    aR: checkColor("ARG"),
                    aS: checkColor("ASM"),
                    aT: checkColor("AUT"),
                    aU: checkColor("AUS"),
                    aW: checkColor("ABW"),
                    aX: checkColor("ALA"),
                    aZ: checkColor("AZE"),
                    bA: checkColor("BIH"),
                    bB: checkColor("BRB"),
                    bD: checkColor("BGD"),
                    bE: checkColor("BEL"),
                    bF: checkColor("BFA"),
                    bG: checkColor("BGR"),
                    bH: checkColor("BHR"),
                    bI: checkColor("BDI"),
                    bJ: checkColor("BEN"),
                    bL: checkColor("BLM"),
                    bM: checkColor("BMU"),
                    bN: checkColor("BRN"),
                    bO: checkColor("BOL"),
                    bQ: checkColor("BES"),
                    bR: checkColor("BRA"),
                    bS: checkColor("BHS"),
                    bT: checkColor("BTN"),
                    bV: checkColor("BVT"),
                    bW: checkColor("BWA"),
                    bY: checkColor("BLR"),
                    bZ: checkColor("BLZ"),
                    cA: checkColor("CAN"),
                    cC: checkColor("CCK"),
                    cD: checkColor("COD"),
                    cF: checkColor("CAF"),
                    cG: checkColor("COG"),
                    cH: checkColor("CHE"),
                    cI: checkColor("CIV"),
                    cK: checkColor("COK"),
                    cL: checkColor("CHL"),
                    cM: checkColor("CMR"),
                    cN: checkColor("CHN"),
                    cO: checkColor("COL"),
                    cR: checkColor("CRI"),
                    cU: checkColor("CUB"),
                    cV: checkColor("CPV"),
                    cW: checkColor("CUW"),
                    cX: checkColor("CXR"),
                    cY: checkColor("CYP"),
                    cZ: checkColor("CZE"),
                    dE: checkColor("DEU"),
                    dJ: checkColor("DJI"),
                    dK: checkColor("DNK"),
                    dM: checkColor("DMA"),
                    dO: checkColor("DOM"),
                    dZ: checkColor("DZA"),
                    eC: checkColor("ECU"),
                    eE: checkColor("EST"),
                    eG: checkColor("EGY"),
                    eH: checkColor("ESH"),
                    eR: checkColor("ERI"),
                    eS: checkColor("ESP"),
                    eT: checkColor("ETH"),
                    fI: checkColor("FIN"),
                    fJ: checkColor("FJI"),
                    fK: checkColor("FLK"),
                    fM: checkColor("FSM"),
                    fO: checkColor("FRO"),
                    fR: checkColor("FRA"),
                    gA: checkColor("GAB"),
                    gB: checkColor("GBR"),
                    gD: checkColor("GRD"),
                    gE: checkColor("GEO"),
                    gF: checkColor("GUF"),
                    gG: checkColor("GGY"),
                    gH: checkColor("GHA"),
                    gI: checkColor("GIB"),
                    gL: checkColor("GRL"),
                    gM: checkColor("GMB"),
                    gN: checkColor("GIN"),
                    gP: checkColor("GLP"),
                    gQ: checkColor("GNQ"),
                    gR: checkColor("GRC"),
                    gS: checkColor("SGS"),
                    gT: checkColor("GTM"),
                    gU: checkColor("GUM"),
                    gW: checkColor("GNB"),
                    gY: checkColor("GUY"),
                    hK: checkColor("HKG"),
                    hM: checkColor("HMD"),
                    hN: checkColor("HND"),
                    hR: checkColor("HRV"),
                    hT: checkColor("HTI"),
                    hU: checkColor("HUN"),
                    iD: checkColor("IDN"),
                    iE: checkColor("IRL"),
                    iL: checkColor("ISR"),
                    iM: checkColor("IMN"),
                    iN: checkColor("IND"),
                    iO: checkColor("IOT"),
                    iQ: checkColor("IRQ"),
                    iR: checkColor("IRN"),
                    iS: checkColor("ISL"),
                    iT: checkColor("ITA"),
                    jE: checkColor("JEY"),
                    jM: checkColor("JAM"),
                    jO: checkColor("JOR"),
                    jP: checkColor("JPN"),
                    kE: checkColor("KEN"),
                    kG: checkColor("KGZ"),
                    kH: checkColor("KHM"),
                    kI: checkColor("KIR"),
                    kM: checkColor("COM"),
                    kN: checkColor("KNA"),
                    kP: checkColor("PRK"),
                    kR: checkColor("KOR"),
                    kW: checkColor("KWT"),
                    kY: checkColor("CYM"),
                    kZ: checkColor("KAZ"),
                    lA: checkColor("LAO"),
                    lB: checkColor("LBN"),
                    lC: checkColor("LCA"),
                    lI: checkColor("LIE"),
                    lK: checkColor("LKA"),
                    lR: checkColor("LBR"),
                    lS: checkColor("LSO"),
                    lT: checkColor("LTU"),
                    lU: checkColor("LUX"),
                    lV: checkColor("LVA"),
                    lY: checkColor("LBY"),
                    mA: checkColor("MAR"),
                    mC: checkColor("MCO"),
                    mD: checkColor("MDA"),
                    mE: checkColor("MNE"),
                    mF: checkColor("MAF"),
                    mG: checkColor("MDG"),
                    mH: checkColor("MHL"),
                    mK: checkColor("MKD"),
                    mL: checkColor("MLI"),
                    mM: checkColor("MMR"),
                    mN: checkColor("MNG"),
                    mO: checkColor("MAC"),
                    mP: checkColor("MNP"),
                    mQ: checkColor("MTQ"),
                    mR: checkColor("MRT"),
                    mS: checkColor("MSR"),
                    mT: checkColor("MLT"),
                    mU: checkColor("MUS"),
                    mV: checkColor("MDV"),
                    mW: checkColor("MWI"),
                    mX: checkColor("MEX"),
                    mY: checkColor("MYS"),
                    mZ: checkColor("MOZ"),
                    nA: checkColor("NAM"),
                    nC: checkColor("NCL"),
                    nE: checkColor("NER"),
                    nF: checkColor("NFK"),
                    nG: checkColor("NGA"),
                    nI: checkColor("NIC"),
                    nL: checkColor("NLD"),
                    nO: checkColor("NOR"),
                    nP: checkColor("NPL"),
                    nR: checkColor("NRU"),
                    nU: checkColor("NIU"),
                    nZ: checkColor("NZL"),
                    oM: checkColor("OMN"),
                    pA: checkColor("PAN"),
                    pE: checkColor("PER"),
                    pF: checkColor("PYF"),
                    pG: checkColor("PNG"),
                    pH: checkColor("PHL"),
                    pK: checkColor("PAL"),
                    pL: checkColor("POL"),
                    pM: checkColor("SPM"),
                    pN: checkColor("PCN"),
                    pR: checkColor("PRI"),
                    pS: checkColor("PSE"),
                    pT: checkColor("PRT"),
                    pW: checkColor("PLW"),
                    pY: checkColor("PRY"),
                    qA: checkColor("QAT"),
                    rE: checkColor("REU"),
                    rO: checkColor("ROU"),
                    rS: checkColor("SRB"),
                    rU: checkColor("RUS"),
                    rW: checkColor("RWA"),
                    sA: checkColor("SAU"),
                    sB: checkColor("SLB"),
                    sC: checkColor("SYC"),
                    sD: checkColor("SDN"),
                    sE: checkColor("SWE"),
                    sG: checkColor("SGP"),
                    sH: checkColor("SHN"),
                    sI: checkColor("SVN"),
                    sJ: checkColor("SJM"),
                    sK: checkColor("SVK"),
                    sL: checkColor("SLE"),
                    sM: checkColor("SMR"),
                    sN: checkColor("SEN"),
                    sO: checkColor("SOM"),
                    sR: checkColor("SUR"),
                    sS: checkColor("SSD"),
                    sT: checkColor("STP"),
                    sV: checkColor("SLV"),
                    sX: checkColor("SXM"),
                    sY: checkColor("SYR"),
                    sZ: checkColor("SWZ"),
                    tC: checkColor("TCA"),
                    tD: checkColor("TCD"),
                    tF: checkColor("ATF"),
                    tG: checkColor("TGO"),
                    tH: checkColor("THA"),
                    tJ: checkColor("TJK"),
                    tK: checkColor("TKL"),
                    tL: checkColor("TLS"),
                    tM: checkColor("TKM"),
                    tN: checkColor("TUN"),
                    tO: checkColor("TON"),
                    tR: checkColor("TUR"),
                    tT: checkColor("TTO"),
                    tV: checkColor("TUV"),
                    tW: checkColor("TWN"),
                    tZ: checkColor("TZA"),
                    uA: checkColor("UKR"),
                    uG: checkColor("UGA"),
                    uM: checkColor("UMI"),
                    uS: checkColor("USA"),
                    uY: checkColor("URY"),
                    uZ: checkColor("UZN"),
                    vA: checkColor("VAT"),
                    vC: checkColor("VCT"),
                    vE: checkColor("VEN"),
                    vG: checkColor("VGB"),
                    vI: checkColor("VIR"),
                    vN: checkColor("VNM"),
                    vU: checkColor("VUT"),
                    wF: checkColor("WLF"),
                    wS: checkColor("WSM"),
                    xK: checkColor("XKX"),
                    yE: checkColor("YEM"),
                    yT: checkColor("MYT"),
                    zA: checkColor("ZAF"),
                    zM: checkColor("ZMB"),
                    zW: checkColor("ZWE"),
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
            const Text(
              'Total kilometres:',
            ),
            Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              child: countryMap(),
            ),
          ],
        ),
      ),
    );
  }
}