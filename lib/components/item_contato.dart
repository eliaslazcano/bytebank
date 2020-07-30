import 'package:bytebank/models/Contato.dart';
import 'package:bytebank/models/Transferencia.dart';
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
      onTap: () async {
        Transferencia transferencia = await Navigator.push(context, MaterialPageRoute(builder: (context) => FormularioTransferencia(contato)));
        if (transferencia != null) Navigator.pop(context);
      },
      child: Card(
        child: ListTile(
          title: Text(
            contato.nome,
            style: TextStyle(fontSize: 24),
          ),
          subtitle: Text(
            "A: ${contato.agencia} C: ${contato.conta}",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
