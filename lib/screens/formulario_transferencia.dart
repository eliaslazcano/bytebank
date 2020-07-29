import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/Contato.dart';
import 'package:bytebank/models/Transferencia.dart';
import 'package:flutter/material.dart';

class FormularioTransferencia extends StatelessWidget {
  final Contato _contato;

  FormularioTransferencia(this._contato);

  final TextEditingController _controllerCampoValor = TextEditingController();

  //Função. Algoritmo para criar uma transferência.
  void _criaTransferencia(BuildContext context) {
    final double valor = double.tryParse(_controllerCampoValor.text); //Se o parse falha, retorna null
    if (valor != null) {
      final transferenciaCriada = Transferencia(_contato, valor);
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
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                _contato.nome,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
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