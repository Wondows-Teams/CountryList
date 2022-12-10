///Aqui se definen los strings con los nombres para las tablas de la DB
final String paisesFavs = 'favs';
final String paisesVisitados = 'visited';
final String paisesPlan = 'planned';
final String paisesNoVisitados = 'notVisited';
final String paisesRanking = 'ranking';


///Guarda el string con el nombre de los atributos que usará SQLite en las columnas
class atributosPais{
  static final List<String> values = [
    id, ranking, code
  ];

  static final String id = '_id';
  static final String ranking = 'ranking';
  static final String code = 'code';
}

///Clase pais, guarda int id, string code (ej: ES, UK, US) y el int ranking
class Pais{
  final int? id;
  final int ranking;
  final String code;

  const Pais({
    this.id,
    required this.ranking,
    required this.code,
  });

  ///Convierte el mapa guardado por la DB a un objeto Pais
  static Pais fromJson(Map<String, Object?> json) => Pais(
    id: json[atributosPais.id] as int?,
    ranking: int.parse(json[atributosPais.ranking].toString()),
    code: json[atributosPais.code] as String,
  );

  ///Convierte el objeto Pais a un mapa que puede ser leido por la DB
  Map<String, Object?> toJson() =>{
    atributosPais.id: id,
    atributosPais.ranking: ranking,
    atributosPais.code: code,
  };

  ///Hace una copia del objeto Pais desde el que se llama
  Pais copy({
    int? id,
    int? ranking,
    String? code,
  }) =>
      Pais(
        id: id ?? this.id,
        ranking: ranking ?? this.ranking,
        code: code ?? this.code,
      );
}