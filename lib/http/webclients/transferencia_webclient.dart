import 'dart:convert';
import 'package:bytebank/http/interceptors/logging_interceptor.dart';
import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/Contato.dart';
import 'package:bytebank/models/Transferencia.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class TransferenciaWebClient {
  final Client client = HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);

  List<Transferencia> _toTransferencia(Response response) {
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
  Map<String, dynamic> _toMap(Transferencia transferencia) {
    final Map<String, dynamic> transferenciaMap = {
      'value': transferencia.valor,
      'contact': {
        'name': transferencia.contato.nome,
        'accountNumber': transferencia.contato.conta
      }
    };
    return transferenciaMap;
  }

  Future<List<Transferencia>> obterTransferencias() async {
    final Response response = await client
        .get('${Webclient.baseUrl}/transactions')
        .timeout(Duration(seconds: 60));

    List<Transferencia> transferencias = _toTransferencia(response);
    return transferencias;
  }
  Future<Transferencia> salvarTransferencia(Transferencia transferencia) async {
    //Map<String, dynamic> => Mapa (igual array) de chave String e valor dynamic (tipagem variavel)
    Map<String, dynamic> transferenciaMap = _toMap(transferencia);
    final String tranferenciaJson = jsonEncode(transferenciaMap);

    final Response response = await client
        .post('${Webclient.baseUrl}/transactions',
        headers: {
          //O uso de {chave: dado} é entendido pelo Dart como um Map<String>
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