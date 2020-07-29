import 'package:bytebank/models/Transferencia.dart';
import 'package:bytebank/database/app_database.dart';
import 'package:sqflite/sqflite.dart';

class TransferenciaDao {
  //Nome da tabela
  static const String _tableName = "transferencias";
  //Nome das colunas
  static const String _id = 'id';
  static const String _valor = 'valor';
  static const String _contato = 'contato_id';
  //Script de criação
  static const String tableSql = "CREATE TABLE $_tableName ("
      "$_id INTEGER PRIMARY KEY AUTOINCREMENT, "
      "$_valor DOUBLE NOT NULL, "
      "$_contato INTEGER NOT NULL)";

  //Helpers
  Map<String, dynamic> _toMap(Transferencia transferencia) {
    final Map<String, dynamic> map = Map();
    map[_valor] = transferencia.valor;
    map[_contato] = transferencia.contato;
    if (transferencia.id != null) map[_id] = transferencia.id;
    return map;
  }
  List<Transferencia> _toList(List<Map<String, dynamic>> maps) {
    final List<Transferencia> transferencias = List();
    for(Map<String, dynamic> map in maps) {
      final Transferencia transferencia = Transferencia(map[_contato], map[_valor], id: map[_id]);
      transferencias.add(transferencia);
    }
    return transferencias;
  }

  //Adiciona uma transferencia no banco.
  Future<Transferencia> salvar(Transferencia transferencia) async {
    final Database db = await abrirBanco();
    Map<String, dynamic> map = _toMap(transferencia);
    transferencia.id = await db.insert(_tableName, map);
    return transferencia;
  }
  //Atualiza uma transferencia no banco.
  Future<int> atualizar(Transferencia transferencia) async {
    final db = await abrirBanco();
    Map<String, dynamic> map = _toMap(transferencia);
    map[_id] = transferencia.id;
    return await db.update(
        _tableName,
        map,
        where: '$_id = ?',
        whereArgs: [transferencia.id]
    );
  }
  //Obtem todos as transferencias do banco.
  Future<List<Transferencia>> listarTodos() async {
    final Database db = await abrirBanco();
    final maps = await db.query(_tableName);
    List<Transferencia> transferencias = _toList(maps);
    return transferencias;
  }
  //Obtem uma transferencia do banco.
  Future<Transferencia> obter(int id) async {
    final db = await abrirBanco();
    List<Map> maps = await db.query(
        _tableName,
        columns: [_id, _valor, _contato],
        where: '$_id = ?',
        whereArgs: [id]
    );
    if(maps.length > 0) {
      final map = maps.first;
      return Transferencia(map[_contato], map[_valor], id: map[_id]);
    }
    return null;
  }

}