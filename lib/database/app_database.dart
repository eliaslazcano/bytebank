import 'package:bytebank/database/dao/contato_dao.dart';
import 'package:bytebank/database/dao/transferencia_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//Obtem uma instancia (conexão) com o banco. Caso o banco não exista, ele será criado.
Future<Database> abrirBanco() async {
  final String dbDiretorio = await getDatabasesPath();
  final String dbCaminho = join(dbDiretorio, 'bytebank.db'); //Unifica strings
  Database banco = await openDatabase(
    dbCaminho,
    version: 1,
    onCreate: (Database db, int version) async {
      //Ao criar o banco, criamos as tabelas
      await db.execute(ContatoDao.tableSql);
      await db.execute(TransferenciaDao.tableSql);
    },
    onDowngrade: onDatabaseDowngradeDelete //Apaga o banco se a versão é menor que a anterior.
  );
  return banco;
  //  await banco.close(); //Fecha a conexão
}
