import 'package:bytebank/models/Contato.dart';
import 'package:bytebank/database/app_database.dart';
import 'package:sqflite/sqflite.dart';

class ContatoDao {
  //Nome da tabela
  static const String _tableName = "contatos";
  //Nome das colunas
  static const String _id = 'id';
  static const String _nome = 'nome';
  static const String _agencia = 'agencia';
  static const String _conta = 'conta';
  //Script de criação
  static const String tableSql = "CREATE TABLE $_tableName ("
      "$_id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "$_agencia INTEGER,"
      "$_nome TEXT NOT NULL,"
      "$_conta INTEGER NOT NULL)";

  //Helpers
  Map<String, dynamic> _toMap(Contato contato) {
    final Map<String, dynamic> map = Map();
    map[_nome] = contato.nome;
    map[_agencia] = contato.agencia;
    map[_conta] = contato.conta;
    if (contato.id != null) map[_id] = contato.id;
    return map;
  }
  List<Contato> _toList(List<Map<String, dynamic>> maps) {
    final List<Contato> contatos = List();
    for(Map<String, dynamic> map in maps) {
      final Contato contato = Contato(map[_nome], map[_agencia], map[_conta], id: map[_id]);
      contatos.add(contato);
    }
    return contatos;
  }

  //Adiciona um contato no banco.
  Future<Contato> salvar(Contato contato) async {
    final Database db = await abrirBanco();
    Map<String, dynamic> map = _toMap(contato);
    contato.id = await db.insert(_tableName, map);
    return contato;
  }
  //Atualiza um contato no banco.
  Future<int> atualizar(Contato contato) async {
    final db = await abrirBanco();
    Map<String, dynamic> map = _toMap(contato);
    map[_id] = contato.id;
    return await db.update(
      _tableName,
      map,
      where: '$_id = ?',
      whereArgs: [contato.id]
    );
  }
  //Obtem todos os contatos do banco.
  Future<List<Contato>> listarTodos() async {
    final Database db = await abrirBanco();
    final maps = await db.query(_tableName);
    List<Contato> contatos = _toList(maps);
    return contatos;
  }
  //Obtem um contato do banco.
  Future<Contato> obter(int id) async {
    final db = await abrirBanco();
    List<Map> maps = await db.query(
      _tableName,
      columns: [_id, _nome, _conta],
      where: '$_id = ?',
      whereArgs: [id]
    );
    if(maps.length > 0) {
      final map = maps.first;
      return Contato(map[_nome], map[_agencia], map[_conta], id: map[_id]);
    }
    return null;
  }

}