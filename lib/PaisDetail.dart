// To parse this JSON data, do
//
//     final paisDetail = paisDetailFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PaisDetail paisDetailFromJson(String str) => PaisDetail.fromJson(json.decode(str));

String paisDetailToJson(PaisDetail data) => json.encode(data.toJson());

class PaisDetail {
  PaisDetail({
    required this.data,
  });

  Data data;

  factory PaisDetail.fromJson(Map<String, dynamic> json) => PaisDetail(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.capital,
    required this.code,
    required this.callingCode,
    required this.currencyCodes,
    required this.flagImageUri,
    required this.name,
    required this.numRegions,
    required this.wikiDataId,
  });

  String capital;
  String code;
  String callingCode;
  List<String> currencyCodes;
  String flagImageUri;
  String name;
  int numRegions;
  String wikiDataId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    capital: json["capital"],
    code: json["code"],
    callingCode: json["callingCode"],
    currencyCodes: List<String>.from(json["currencyCodes"].map((x) => x)),
    flagImageUri: json["flagImageUri"],
    name: json["name"],
    numRegions: json["numRegions"],
    wikiDataId: json["wikiDataId"],
  );

  Map<String, dynamic> toJson() => {
    "capital": capital,
    "code": code,
    "callingCode": callingCode,
    "currencyCodes": List<dynamic>.from(currencyCodes.map((x) => x)),
    "flagImageUri": flagImageUri,
    "name": name,
    "numRegions": numRegions,
    "wikiDataId": wikiDataId,
  };
}
