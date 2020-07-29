import 'package:bytebank/models/Contato.dart';

class Transferencia {
  final Contato contato;
  final double valor;
  int id;

  Transferencia(this.contato, this.valor, {this.id});

  @override
  String toString() {
    return 'Transferencia: { numeroConta: $contato, valor: $valor }';
  }
}