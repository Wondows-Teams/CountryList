// To parse this JSON data, do
//
//     final pais = paisFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Pais> paisFromJson(String str) => List<Pais>.from(json.decode(str).map((x) => Pais.fromJson(x)));

class Pais {
  Pais({
    required this.name,
    required this.topLevelDomain,
    required this.alpha2Code,
    required this.alpha3Code,
    required this.callingCodes,
    required this.capital,
    required this.altSpellings,
    required this.subregion,
    required this.region,
    required this.population,
    required this.latlng,
    required this.demonym,
    required this.area,
    required this.timezones,
    required this.borders,
    required this.nativeName,
    required this.numericCode,
    required this.flags,
    required this.currencies,
    required this.languages,
    required this.translations,
    required this.flag,
    required this.regionalBlocs,
    required this.cioc,
    required this.independent,
    required this.gini,
  });

  String name;
  List<String>? topLevelDomain;
  String? alpha2Code;
  String? alpha3Code;
  List<String>? callingCodes;
  String? capital;
  List<String>? altSpellings;
  String? subregion;
  Region? region;
  int? population;
  List<double>? latlng;
  String? demonym;
  double? area;
  List<String>? timezones;
  List<String>? borders;
  String? nativeName;
  String? numericCode;
  Flags flags;
  List<Currency>? currencies;
  List<Language>? languages;
  Translations? translations;
  String flag;
  List<RegionalBloc>? regionalBlocs;
  String? cioc;
  bool? independent;
  double? gini;

  factory Pais.fromJson(Map<String, dynamic> json) => Pais(
    name: json["name"],
    topLevelDomain: List<String>.from(json["topLevelDomain"].map((x) => x)),
    alpha2Code: json["alpha2Code"],
    alpha3Code: json["alpha3Code"],
    callingCodes: List<String>.from(json["callingCodes"].map((x) => x)),
    capital: json["capital"] == null ? null : json["capital"],
    altSpellings: json["altSpellings"] == null ? null : List<String>.from(json["altSpellings"].map((x) => x)),
    subregion: json["subregion"],
    region: regionValues.map[json["region"]],
    population: json["population"],
    latlng: json["latlng"] == null ? null : List<double>.from(json["latlng"].map((x) => x.toDouble())),
    demonym: json["demonym"],
    area: json["area"] == null ? null : json["area"].toDouble(),
    timezones: List<String>.from(json["timezones"].map((x) => x)),
    borders: json["borders"] == null ? null : List<String>.from(json["borders"].map((x) => x)),
    nativeName: json["nativeName"],
    numericCode: json["numericCode"],
    flags: Flags.fromJson(json["flags"]),
    currencies: json["currencies"] == null ? null : List<Currency>.from(json["currencies"].map((x) => Currency.fromJson(x))),
    languages: List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
    translations: Translations.fromJson(json["translations"]),
    flag: json["flag"],
    regionalBlocs: json["regionalBlocs"] == null ? null : List<RegionalBloc>.from(json["regionalBlocs"].map((x) => RegionalBloc.fromJson(x))),
    cioc: json["cioc"] == null ? null : json["cioc"],
    independent: json["independent"],
    gini: json["gini"] == null ? null : json["gini"].toDouble(),
  );
}

class Currency {
  Currency({
    required this.code,
    required this.name,
    required this.symbol,
  });

  String? code;
  String? name;
  String? symbol;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    code: json["code"],
    name: json["name"],
    symbol: json["symbol"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
    "symbol": symbol,
  };
}

class Flags {
  Flags({
    required this.svg,
    required this.png,
  });

  String? svg;
  String? png;

  factory Flags.fromJson(Map<String, dynamic> json) => Flags(
    svg: json["svg"],
    png: json["png"],
  );

  Map<String, dynamic> toJson() => {
    "svg": svg,
    "png": png,
  };
}

class Language {
  Language({
    required this.iso6391,
    required this.iso6392,
    required this.name,
    required this.nativeName,
  });

  String? iso6391;
  String? iso6392;
  String? name;
  String? nativeName;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    iso6391: json["iso639_1"] == null ? null : json["iso639_1"],
    iso6392: json["iso639_2"],
    name: json["name"],
    nativeName: json["nativeName"] == null ? null : json["nativeName"],
  );

  Map<String, dynamic> toJson() => {
    "iso639_1": iso6391 == null ? null : iso6391,
    "iso639_2": iso6392,
    "name": name,
    "nativeName": nativeName == null ? null : nativeName,
  };
}

enum Region { ASIA, EUROPE, AFRICA, OCEANIA, AMERICAS, POLAR, ANTARCTIC_OCEAN, ANTARCTIC }

final regionValues = EnumValues({
  "Africa": Region.AFRICA,
  "Americas": Region.AMERICAS,
  "Antarctic": Region.ANTARCTIC,
  "Antarctic Ocean": Region.ANTARCTIC_OCEAN,
  "Asia": Region.ASIA,
  "Europe": Region.EUROPE,
  "Oceania": Region.OCEANIA,
  "Polar": Region.POLAR
});

class RegionalBloc {
  RegionalBloc({
    required this.acronym,
    required this.name,
    required this.otherNames,
    required this.otherAcronyms,
  });

  Acronym? acronym;
  Name? name;
  List<OtherName>? otherNames;
  List<OtherAcronym>? otherAcronyms;

  factory RegionalBloc.fromJson(Map<String, dynamic> json) => RegionalBloc(
    acronym: acronymValues.map[json["acronym"]],
    name: nameValues.map[json["name"]],
    otherNames: json["otherNames"] == null ? null : List<OtherName>.from(json["otherNames"].map((x) => otherNameValues.map[x])),
    otherAcronyms: json["otherAcronyms"] == null ? null : List<OtherAcronym>.from(json["otherAcronyms"].map((x) => otherAcronymValues.map[x])),
  );
}

enum Acronym { SAARC, EU, CEFTA, AU, AL, CARICOM, USAN, EEU, CAIS, ASEAN, NAFTA, PA, EFTA }

final acronymValues = EnumValues({
  "AL": Acronym.AL,
  "ASEAN": Acronym.ASEAN,
  "AU": Acronym.AU,
  "CAIS": Acronym.CAIS,
  "CARICOM": Acronym.CARICOM,
  "CEFTA": Acronym.CEFTA,
  "EEU": Acronym.EEU,
  "EFTA": Acronym.EFTA,
  "EU": Acronym.EU,
  "NAFTA": Acronym.NAFTA,
  "PA": Acronym.PA,
  "SAARC": Acronym.SAARC,
  "USAN": Acronym.USAN
});

enum Name { SOUTH_ASIAN_ASSOCIATION_FOR_REGIONAL_COOPERATION, EUROPEAN_UNION, CENTRAL_EUROPEAN_FREE_TRADE_AGREEMENT, AFRICAN_UNION, ARAB_LEAGUE, CARIBBEAN_COMMUNITY, UNION_OF_SOUTH_AMERICAN_NATIONS, EURASIAN_ECONOMIC_UNION, CENTRAL_AMERICAN_INTEGRATION_SYSTEM, ASSOCIATION_OF_SOUTHEAST_ASIAN_NATIONS, NORTH_AMERICAN_FREE_TRADE_AGREEMENT, PACIFIC_ALLIANCE, EUROPEAN_FREE_TRADE_ASSOCIATION }

final nameValues = EnumValues({
  "African Union": Name.AFRICAN_UNION,
  "Arab League": Name.ARAB_LEAGUE,
  "Association of Southeast Asian Nations": Name.ASSOCIATION_OF_SOUTHEAST_ASIAN_NATIONS,
  "Caribbean Community": Name.CARIBBEAN_COMMUNITY,
  "Central American Integration System": Name.CENTRAL_AMERICAN_INTEGRATION_SYSTEM,
  "Central European Free Trade Agreement": Name.CENTRAL_EUROPEAN_FREE_TRADE_AGREEMENT,
  "Eurasian Economic Union": Name.EURASIAN_ECONOMIC_UNION,
  "European Free Trade Association": Name.EUROPEAN_FREE_TRADE_ASSOCIATION,
  "European Union": Name.EUROPEAN_UNION,
  "North American Free Trade Agreement": Name.NORTH_AMERICAN_FREE_TRADE_AGREEMENT,
  "Pacific Alliance": Name.PACIFIC_ALLIANCE,
  "South Asian Association for Regional Cooperation": Name.SOUTH_ASIAN_ASSOCIATION_FOR_REGIONAL_COOPERATION,
  "Union of South American Nations": Name.UNION_OF_SOUTH_AMERICAN_NATIONS
});

enum OtherAcronym { UNASUR, UNASUL, UZAN, EAEU, SICA }

final otherAcronymValues = EnumValues({
  "EAEU": OtherAcronym.EAEU,
  "SICA": OtherAcronym.SICA,
  "UNASUL": OtherAcronym.UNASUL,
  "UNASUR": OtherAcronym.UNASUR,
  "UZAN": OtherAcronym.UZAN
});

enum OtherName { EMPTY, UNION_AFRICAINE, UNIO_AFRICANA, UNIN_AFRICANA, UMOJA_WA_AFRIKA, OTHER_NAME, JMI_AT_AD_DUWAL_AL_ARABYAH, LEAGUE_OF_ARAB_STATES, COMUNIDAD_DEL_CARIBE, COMMUNAUT_CARIBENNE, CARIBISCHE_GEMEENSCHAP, UNIN_DE_NACIONES_SURAMERICANAS, UNIO_DE_NAES_SUL_AMERICANAS, UNIE_VAN_ZUID_AMERIKAANSE_NATIES, SOUTH_AMERICAN_UNION, SISTEMA_DE_LA_INTEGRACIN_CENTROAMERICANA, TRATADO_DE_LIBRE_COMERCIO_DE_AMRICA_DEL_NORTE, ACCORD_DE_LIBRE_CHANGE_NORD_AMRICAIN, ALIANZA_DEL_PACFICO }

final otherNameValues = EnumValues({
  "Accord de Libre-échange Nord-Américain": OtherName.ACCORD_DE_LIBRE_CHANGE_NORD_AMRICAIN,
  "Alianza del Pacífico": OtherName.ALIANZA_DEL_PACFICO,
  "Caribische Gemeenschap": OtherName.CARIBISCHE_GEMEENSCHAP,
  "Communauté Caribéenne": OtherName.COMMUNAUT_CARIBENNE,
  "Comunidad del Caribe": OtherName.COMUNIDAD_DEL_CARIBE,
  "الاتحاد الأفريقي": OtherName.EMPTY,
  "Jāmiʻat ad-Duwal al-ʻArabīyah": OtherName.JMI_AT_AD_DUWAL_AL_ARABYAH,
  "League of Arab States": OtherName.LEAGUE_OF_ARAB_STATES,
  "جامعة الدول العربية": OtherName.OTHER_NAME,
  "Sistema de la Integración Centroamericana,": OtherName.SISTEMA_DE_LA_INTEGRACIN_CENTROAMERICANA,
  "South American Union": OtherName.SOUTH_AMERICAN_UNION,
  "Tratado de Libre Comercio de América del Norte": OtherName.TRATADO_DE_LIBRE_COMERCIO_DE_AMRICA_DEL_NORTE,
  "Umoja wa Afrika": OtherName.UMOJA_WA_AFRIKA,
  "Unie van Zuid-Amerikaanse Naties": OtherName.UNIE_VAN_ZUID_AMERIKAANSE_NATIES,
  "Unión Africana": OtherName.UNIN_AFRICANA,
  "Unión de Naciones Suramericanas": OtherName.UNIN_DE_NACIONES_SURAMERICANAS,
  "Union africaine": OtherName.UNION_AFRICAINE,
  "União Africana": OtherName.UNIO_AFRICANA,
  "União de Nações Sul-Americanas": OtherName.UNIO_DE_NAES_SUL_AMERICANAS
});

class Translations {
  Translations({
    required this.br,
    required this.pt,
    required this.nl,
    required this.hr,
    required this.fa,
    required this.de,
    required this.es,
    required this.fr,
    required this.ja,
    required this.it,
    required this.hu,
  });

  String br;
  String pt;
  String nl;
  String hr;
  String? fa;
  String de;
  String es;
  String fr;
  String ja;
  String it;
  String hu;

  factory Translations.fromJson(Map<String, dynamic> json) => Translations(
    br: json["br"],
    pt: json["pt"],
    nl: json["nl"],
    hr: json["hr"],
    fa: json["fa"] == null ? null : json["fa"],
    de: json["de"],
    es: json["es"],
    fr: json["fr"],
    ja: json["ja"],
    it: json["it"],
    hu: json["hu"],
  );

  Map<String, dynamic> toJson() => {
    "br": br,
    "pt": pt,
    "nl": nl,
    "hr": hr,
    "fa": fa == null ? null : fa,
    "de": de,
    "es": es,
    "fr": fr,
    "ja": ja,
    "it": it,
    "hu": hu,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
