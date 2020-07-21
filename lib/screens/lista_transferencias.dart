import 'package:bytebank/components/item_transferencia.dart';
import 'package:bytebank/models/Transferencia.dart';
import 'package:bytebank/screens/formulario_transferencia.dart';
import 'package:flutter/material.dart';

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = List();

  @override
  _ListaTransferenciasState createState() => _ListaTransferenciasState();
}

class _ListaTransferenciasState extends State<ListaTransferencias> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Transferencias'),
        ),
        body: ListView.builder(
          itemCount: widget._transferencias.length,
          itemBuilder: (BuildContext context, int index) {
            final Transferencia transferencia = widget._transferencias[index];
            return ItemTransferencia(transferencia);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Future<Transferencia> future = Navigator.push(context, MaterialPageRoute(builder: (context) => FormularioTransferencia())); //Navega para a View FormularioTransferencia
            future.then((transferenciaRecebida) {
              //Callback invocado quando o usuário recuar da tela FormularioTransferencia para ListaTransferencias
              setState(() { //setState() notifica o Framework que o Widget vai receber atualização visual, a função passada é invocada antes da renderização.
                if(transferenciaRecebida != null) widget._transferencias.add(transferenciaRecebida);
              });
            });
          },
        ));
  }
}