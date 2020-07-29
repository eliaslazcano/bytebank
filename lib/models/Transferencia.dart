import 'package:bytebank/models/Contato.dart';

class Transferencia {
  final Contato contato;
  final double valor;

  Transferencia(this.contato, this.valor);

  @override
  String toString() {
    return 'Transferencia: { numeroConta: $contato, valor: $valor }';
  }
}