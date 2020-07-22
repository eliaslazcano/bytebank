import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/Contato.dart';
import 'package:flutter/material.dart';

class FormularioContato extends StatelessWidget {
  final TextEditingController controllerNome = TextEditingController();
  final TextEditingController controllerConta = TextEditingController();

  void criarContato(BuildContext context) {
    final String nome = controllerNome.text;
    final int conta = int.tryParse(controllerConta.text);
    if (nome != null && conta != null) {
      final Contato contato = Contato(nome, conta);
      Navigator.pop(context, contato); //Recua para a tela anterior (View pai). O 2º param será enviado para ele.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo contato"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              rotulo: "Nome completo",
              controlador: controllerNome,
              keyboard: TextInputType.text,
            ),
            Editor(
              rotulo: "Numero da conta",
              controlador: controllerConta,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.maxFinite, //Aceita numeros double tambem
                child: RaisedButton(
                  child: Text('Criar'),
                  onPressed: () => criarContato(context),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
