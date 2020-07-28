import 'package:bytebank/components/item_contato.dart';
import 'package:bytebank/database/app_database.dart';
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
      body: FutureBuilder(
        future: listarContatos(), //O Future que retornará os dados assincronos.
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          final List<Contato> contatos = snapshot.data;
          return ListView.builder(
            itemCount: contatos.length,
            itemBuilder: (BuildContext context, int index) {
              return ItemContato(contatos[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Contato contato = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormularioContato()),
          );
          setState(() {
            if (contato != null) widget._contatos.add(contato); //TODO - Atualizar a lista
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
