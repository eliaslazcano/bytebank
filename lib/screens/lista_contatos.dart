import 'package:bytebank/components/item_contato.dart';
import 'package:bytebank/models/Contato.dart';
import 'package:bytebank/screens/formulario_contato.dart';
import 'package:flutter/material.dart';

class ListaContatos extends StatefulWidget {
  final List<Contato> _contatos = List();

  @override
  _ListaContatosState createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
      ),
      body: ListView.builder(
        itemCount: widget._contatos.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemContato(widget._contatos[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Future future = Navigator.push(context,
              MaterialPageRoute(builder: (context) => FormularioContato()));
          future.then((contato) {
            setState(() {
              if (contato != null) widget._contatos.add(contato);
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
