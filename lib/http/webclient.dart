import 'dart:convert';
import 'package:bytebank/http/interceptor.dart';
import 'package:bytebank/models/Contato.dart';
import 'package:bytebank/models/Transferencia.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart';

class Webclient {
  //URL base para as requisições
  static const String baseUrl = "http://192.168.15.101:8080";
  final Client client = HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);

  Future<List<Transferencia>> obterTransferencias() async {
    final Response response = await client
        .get('$baseUrl/transactions')
        .timeout(Duration(seconds: 60));

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

  Future<Transferencia> salvarTransferencia(Transferencia transferencia) async {
    //Map<String, dynamic> => Mapa (igual array) de chave String e valor dynamic (tipagem variavel)
    final Map<String, dynamic> transferenciaMap = {
      'value': transferencia.valor,
      'contact': {
        'name': transferencia.contato.nome,
        'accountNumber': transferencia.contato.conta
      }
    };
    final String tranferenciaJson = jsonEncode(transferenciaMap);

    final Response response = await client
        .post('$baseUrl/transactions',
            headers: {
              //O uso de {chave: dado} será auto-convertido para um Map<String>
              'Content-type': 'application/json',
              'password': '1000',
            },
            body: tranferenciaJson)
        .timeout(Duration(seconds: 60));

    //Trata a resposta
    Map<String, dynamic> json = jsonDecode(response.body);
    final Map<String, dynamic> contatoJson = json['contact'];
    return Transferencia(
      Contato(contatoJson['name'], null, contatoJson['accountNumber']),
      0
    );
  }
}
