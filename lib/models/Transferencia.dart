import 'package:bytebank/models/Contato.dart';

class Transferencia {
  //Propriedades
  final Contato contato;
  final double valor;
  int id;

  //Construtor
  Transferencia(this.contato, this.valor, {this.id});

  //Construtor alternativo
  Transferencia.fromJson(Map<String, dynamic> json) :
    valor = json['value'],
    contato = Contato.fromJson(json['contact']);

  //Função local
  Map<String, dynamic> toJson() => {
    'value': valor,
    'contact': contato.toJson()
  };

  @override
  String toString() {
    return 'Transferencia: { numeroConta: $contato, valor: $valor }';
  }
}