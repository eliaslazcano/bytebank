import 'dart:convert';
import 'package:bytebank/http/interceptor.dart';
import 'package:bytebank/models/Contato.dart';
import 'package:bytebank/models/Transferencia.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart';

//URL base para as requisições
const String host = "http://localhost:8080";

//Realiza uma requisição GET.
Future<void> requisicaoGet() async {
  final Response response = await get('$host/transactions');
  print(response.body);
}

//Realiza uma requisição GET com interceptador.
Future<List<Transferencia>> requisicaoGetComInterceptor() async {
  final Client client = HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
  final Response response = await client.get('$host/transactions');

  //Adapta o JSON para nossos objetos modelados.
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