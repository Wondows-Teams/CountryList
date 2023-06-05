import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:countrylist/dataModel.dart';


class PaisDatabase{
  static final PaisDatabase instance = PaisDatabase._init();

  static Database? _database;

  ///Comienza la inicializacion de la DB
  PaisDatabase._init();

  ///Intenta abrir una DB local existente y si no la encuentra, la crea con el nombre paises.db
  Future<Database> get database async{
    if(_database != null ) return _database!;

    _database = await _initDB('paises.db');
    return database!;
  }

  ///Crea una DB con el nombre indicado en la dirección por defecto
  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  ///Inicializa la DB con las tablas indicadas
  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final intType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $paisesFavs(
    ${atributosPais.id} $idType,
    ${atributosPais.ranking} $textType,
    ${atributosPais.code} $intType
    )
    ''');

    await db.execute('''
    CREATE TABLE $paisesVisitados(
      ${atributosPais.id} $idType,
      ${atributosPais.ranking} $textType,
      ${atributosPais.code} $intType
    )
    ''');

    await db.execute('''
    CREATE TABLE $paisesPlan(
    ${atributosPais.id} $idType,
    ${atributosPais.ranking} $textType,
    ${atributosPais.code} $intType
    )
    ''');

    await db.execute('''
    CREATE TABLE $paisesNoVisitados(
    ${atributosPais.id} $idType,
    ${atributosPais.ranking} $textType,
    ${atributosPais.code} $intType
    )
    ''');

    await db.execute('''
    CREATE TABLE $paisesRanking(
    ${atributosPais.id} $idType,
    ${atributosPais.ranking} $textType,
    ${atributosPais.code} $intType
    )
    ''');
  }

  ///Añade un pais a la DB en la tabla indicada
  Future<Pais> create(Pais note, String table) async{
    final db = await instance.database;

    final id = await db.insert(table, note.toJson());
    return note.copy(id: id);
  }

  ///Lee el pais, si existe, que coincida con la tabla y codigo indicados
  Future<Pais> read(String code, String table) async{
    final db = await instance.database;

    final maps = await db.query(
      table,
      columns: atributosPais.values,
      where: '${atributosPais.code} = ?',
      whereArgs: [code],
    );

    if (maps.isNotEmpty){
      return Pais.fromJson(maps.first);
    }else{
      return new Pais(ranking: -1, code: code);
    }
  }

  ///Lee todas las entradas de la tabla indicada
  Future<List<Pais>> readAll(String table) async{
    final db = await instance.database;

    final result = await db.query(table);

    return result.map((json) => Pais.fromJson(json)).toList();
  }

  ///Actualiza la entrada de la DB que tenga el mismo código, reemplazandola
  Future<int> update(Pais pais) async{
    final db = await instance.database;

    return db.update(
      paisesFavs,
      pais.toJson(),
      where: '${atributosPais} = ?',
      whereArgs: [pais.code],
    );
  }

  ///Elimina la entrada de la DB que tenga el código condicado
  Future<int> delete(String code, String table) async{
    final db = await instance.database;

    return await db.delete(
      table,
      where: '${atributosPais.code} = ?',
      whereArgs: [code],
    );
  }

  ///Cierra la DB
  Future close() async{
    final db = await instance.database;
    db.close();
  }
}