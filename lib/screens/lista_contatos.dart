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
          switch(snapshot.connectionState) {
            case ConnectionState.none:
              // Não está em execução/não foi executado.
              break;
            case ConnectionState.active:
              // Future em execução, mas já tem dado disponível (Futures do tipo Stream)
              break;
            case ConnectionState.waiting:
              // Future em execução
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.done:
              // Future concluído.
              final List<Contato> contatos = snapshot.data;
              return ListView.builder(
                itemCount: contatos.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemContato(contatos[index]);
                },
              );
              break;
          }
          return Text('Unknown error');
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
