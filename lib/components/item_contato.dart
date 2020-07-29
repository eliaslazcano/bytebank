import 'package:bytebank/models/Contato.dart';
import 'package:bytebank/screens/formulario_transferencia.dart';
import 'package:flutter/material.dart';

class ItemContato extends StatelessWidget {
  //Propriedades
  final Contato contato;

  //Construtor
  ItemContato(this.contato);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => FormularioTransferencia(contato)));
      },
      child: Card(
        child: ListTile(
          title: Text(
            contato.nome,
            style: TextStyle(fontSize: 24),
          ),
          subtitle: Text(
            contato.conta.toString(),
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
