// To parse this JSON data, do
//
//     final pais = paisFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'PaisDetail.dart';

List<Pais> paisFromJson(String str) => List<Pais>.from(json.decode(str)["data"].map((x) => Pais.fromJson(x)));

String paisToJson(List<Pais> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pais {
  Pais({
    required this.code,
    required this.currencyCodes,
    required this.name,
    required this.wikiDataId,
  });

  String code;
  List<String> currencyCodes;
  String name;
  String wikiDataId;
  late Future<PaisDetail> detalles;

  factory Pais.fromJson(Map<String, dynamic> json) => Pais(
    code: json["code"],
    currencyCodes: List<String>.from(json["currencyCodes"].map((x) => x)),
    name: json["name"],
    wikiDataId: json["wikiDataId"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "currencyCodes": List<dynamic>.from(currencyCodes.map((x) => x)),
    "name": name,
    "wikiDataId": wikiDataId,
  };
}
