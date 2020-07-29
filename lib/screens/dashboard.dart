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
            Material(
              color: Theme.of(context).primaryColor, //Cor de fundo
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListaContatos()));
                },
                child: Container(
                  height: 100,
                  width: 120,
                  padding: EdgeInsets.all(8),
                  child: Column( // Filhos
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.people,
                        color: Colors.white,
                        size: 48,
                      ),
                      Text(
                        "Contatos",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
