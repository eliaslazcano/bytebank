import 'package:bytebank/http/interceptor.dart';
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
Future<void> requisicaoGetComInterceptor() async {
  final Client client = HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
  final Response response = await client.get('$host/transactions');
  print(response.body);
}