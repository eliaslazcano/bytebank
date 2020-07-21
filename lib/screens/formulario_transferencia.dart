import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/Transferencia.dart';
import 'package:flutter/material.dart';

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controllerCampoNumeroConta = TextEditingController();
  final TextEditingController _controllerCampoValor = TextEditingController();

  //Função. Algoritmo para criar uma transferência.
  void _criaTransferencia(BuildContext context) {
    final int numeroConta = int.tryParse(_controllerCampoNumeroConta.text);
    final double valor = double.tryParse(_controllerCampoValor.text); //Se o parse falha, retorna null
    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(numeroConta, valor);
      Navigator.pop(context, transferenciaCriada); //Recua para a tela anterior (View pai). O 2º param será enviado para ele.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _controllerCampoNumeroConta,
              rotulo: 'Numero da conta',
              dica: '0000',
            ),
            Editor(
              controlador: _controllerCampoValor,
              rotulo: 'Valor',
              dica: '0.00',
              icone: Icons.monetization_on,
            ),
            RaisedButton(
              child: Text('Confirmar'),
              onPressed: () => _criaTransferencia(context),
            )
          ],
        ),
      ),
    );
  }
}