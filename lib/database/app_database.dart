import 'package:bytebank/models/Contato.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//Obtem uma instancia (conexão) com o banco. Caso o banco não exista, ele será criado.
Future<Database> criarBanco() async {
  final String dbDiretorio = await getDatabasesPath();
  final String dbCaminho = join(dbDiretorio, 'bytebank.db'); //Unifica strings
  Database banco = await openDatabase(
    dbCaminho,
    version: 1,
    onCreate: (Database db, int version) async {
      //Ao criar o banco, criamos as tabelas
      await db.execute("CREATE TABLE contatos (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL, conta INTEGER NOT NULL)");
    },
    onDowngrade: onDatabaseDowngradeDelete //Apaga o banco se a versão é menor que a anterior.
  );
  return banco;
  //  await banco.close(); //Fecha a conexão
}

//Adiciona um contato no banco.
Future<Contato> salvarContato(Contato contato) async {
  //Salva um contato no banco, retorna o contato com ID preenchido.
  final db = await criarBanco();
  final Map<String, dynamic> contatoMap = Map();
  contatoMap['nome'] = contato.nome;
  contatoMap['conta'] = contato.conta;
  contato.id = await db.insert('contatos', contatoMap);
  return contato;
}

//Atualiza um contato no banco.
Future<int> atualizarContato(Contato contato) async {
  final db = await criarBanco();
  final Map<String, dynamic> contatoMap = Map();
  contatoMap['nome'] = contato.nome;
  contatoMap['conta'] = contato.conta;
  contatoMap['id'] = contato.id;
  return await db.update(
    'contatos',
    contatoMap,
    where: 'id = ?',
    whereArgs: [contato.id]
  );
}

//Obtem todos os contatos do banco.
Future<List<Contato>> listarContatos() async {
  final db = await criarBanco();
  final maps = await db.query('contatos');
  final List<Contato> contatos = List();
  for(Map<String, dynamic> map in maps) {
    final Contato contato = Contato(map['nome'], map['conta'], id: map['id']);
    contatos.add(contato);
  }
  await Future.delayed(Duration(seconds: 5)); //Tempo de atraso para simular bancos enormes.
  return contatos;
}

//Obtem um contato do banco.
Future<Contato> obterContato(int id) async {
  final db = await criarBanco();
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