import 'package:bytebank/models/Contato.dart';
import 'package:bytebank/database/app_database.dart';
import 'package:sqflite/sqflite.dart';

class ContatoDao {
  //Adiciona um contato no banco.
  Future<Contato> salvar(Contato contato) async {
    final Database db = await abrirBanco();
    final Map<String, dynamic> map = Map();
    map['nome'] = contato.nome;
    map['conta'] = contato.conta;
    contato.id = await db.insert('contatos', map);
    return contato;
  }
  //Atualiza um contato no banco.
  Future<Contato> atualizar(Contato contato) async {
    final db = await abrirBanco();
    final Map<String, dynamic> map = Map();
    map['nome'] = contato.nome;
    map['conta'] = contato.conta;
    map['id'] = contato.id;
    return await db.update(
      'contatos',
      map,
      where: 'id = ?',
      whereArgs: [contato.id]
    );
  }
  //Obtem todos os contatos do banco.
  Future<List<Contato>> listarTodos() async {
    final Database db = await abrirBanco();
    final maps = await db.query('contatos');
    final List<Contato> contatos = List();
    for(Map<String, dynamic> map in maps) {
      final Contato contato = Contato(map['nome'], map['conta'], id: map['id']);
      contatos.add(contato);
    }
    return contatos;
  }
  //Obtem um contato do banco.
  Future<Contato> obter(int id) async {
    final db = await abrirBanco();
    List<Map> maps = await db.query(
      'contatos',
      columns: ['id', 'nome', 'conta'],
      where: 'id = ?',
      whereArgs: [id]
    );
    if(maps.length > 0) {
      final map = maps.first;
      return Contato(map['nome'], map['conta'], id: map['id']);
    }
    return null;
  }

}