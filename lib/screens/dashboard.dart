import 'package:bytebank/components/botao_recurso.dart';
import 'package:bytebank/screens/lista_contatos.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, //Alinhamento vertical
          crossAxisAlignment: CrossAxisAlignment.start, //Alinhamento horizontal
          children: <Widget>[
            Image.asset("images/bytebank_logo.png"),
            BotaoRecurso(
              "Contatos",
              Icons.people,
              ListaContatos()
            )
          ],
        ),
      ),
    );
  }
}
