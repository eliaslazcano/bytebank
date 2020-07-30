import 'dart:convert';
import 'package:bytebank/http/interceptor.dart';
import 'package:bytebank/models/Contato.dart';
import 'package:bytebank/models/Transferencia.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart';

class Webclient {
  //URL base para as requisições
  static const String host = "http://192.168.15.101:8080";

  Future<List<Transferencia>> obterTransferencias() async {
    final Client client = HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
    final Response response = await client.get('$host/transactions');

    //Adapta o JSON para um List<Transferencia>.
    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transferencia> transferencias = List();
    for (Map<String, dynamic> transferenciaJson in decodedJson) {
      final Map<String, dynamic> contatoJson = transferenciaJson['contact'];
      final Contato contato = Contato(contatoJson['name'], null, contatoJson['accountNumber']);
      final Transferencia transferencia = Transferencia(contato, transferenciaJson['value']);
      transferencias.add(transferencia);
    }
    return transferencias;
  }
}