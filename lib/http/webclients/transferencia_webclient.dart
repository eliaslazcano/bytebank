import 'dart:convert';
import 'package:bytebank/http/interceptors/logging_interceptor.dart';
import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/Contato.dart';
import 'package:bytebank/models/Transferencia.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class TransferenciaWebClient {
  final Client client = HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);

//  List<Transferencia> _toTransferencias(Response response) {
//    //Adapta o JSON para um List<Transferencia>.
//    final List<dynamic> decodedJson = jsonDecode(response.body);
//    return decodedJson.map((json) => Transferencia.fromJson(json)).toList();
//  }
//  Map<String, dynamic> _toMap(Transferencia transferencia) {
//    final Map<String, dynamic> transferenciaMap = {
//      'value': transferencia.valor,
//      'contact': {
//        'name': transferencia.contato.nome,
//        'accountNumber': transferencia.contato.conta
//      }
//    };
//    return transferenciaMap;
//  }

  Future<List<Transferencia>> obterTransferencias() async {
    final Response response = await client
        .get('${Webclient.baseUrl}/transactions')
        .timeout(Duration(seconds: 60));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((json) => Transferencia.fromJson(json)).toList();
  }
  Future<Transferencia> salvarTransferencia(Transferencia transferencia) async {
    final String tranferenciaJson = jsonEncode(transferencia.toJson());

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
    return Transferencia.fromJson(jsonDecode(response.body));
  }
}