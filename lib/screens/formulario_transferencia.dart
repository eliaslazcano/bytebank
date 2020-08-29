import 'package:bytebank/components/dialog_transactionAuth.dart';
import 'package:bytebank/components/editor.dart';
import 'package:bytebank/http/webclients/transferencia_webclient.dart';
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
      final transferencia = Transferencia(_contato, valor);
      showDialog(context: context, builder: (context) => TransactionDialog());
      //TransferenciaDao().salvar(transferencia).then((transferenciaSalva) => Navigator.pop(context, transferenciaSalva));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _contato.nome,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  "C: ${_contato.conta} / A: ${_contato.agencia}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Editor(
                  controlador: _controllerCampoValor,
                  rotulo: 'Valor',
                  dica: '0.00',
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Confirmar'),
                    onPressed: () => _criaTransferencia(context),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}