import 'package:bytebank/components/carregando_centralizado.dart';
import 'package:bytebank/components/item_transferencia.dart';
import 'package:bytebank/components/mensagem_centralizada.dart';
import 'package:bytebank/http/webclients/transferencia_webclient.dart';
import 'package:bytebank/models/Transferencia.dart';
import 'package:bytebank/screens/lista_contatos.dart';
import 'package:flutter/material.dart';

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = List();

  @override
  _ListaTransferenciasState createState() => _ListaTransferenciasState();
}

class _ListaTransferenciasState extends State<ListaTransferencias> {
  final TransferenciaWebClient webclient = TransferenciaWebClient();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Transferencias'),
        ),
        body: FutureBuilder(
          future: webclient.obterTransferencias(),
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
                return CarregandoCentralizado();
                break;
              case ConnectionState.done:
                // Future concluído.
                if (snapshot.hasData) { //Filtra erro da API
                  final List<Transferencia> transferencias = snapshot.data;
                  if (transferencias.isNotEmpty) {
                    return ListView.builder(
                      itemCount: transferencias.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemTransferencia(transferencias[index]);
                      },
                    );
                  }
                }
                return MensagemCentralizada(
                  "Nenhuma transação encontrada",
                  icone: Icons.warning,
                );
                break;
            }
            return MensagemCentralizada("Erro desconhecido");
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Future<Transferencia> future = Navigator.push(context, MaterialPageRoute(builder: (context) => ListaContatos())); //Navega para a View FormularioTransferencia
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