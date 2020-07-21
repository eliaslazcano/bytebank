import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

//StatelessWidget => Não consegue modificar o conteúdo do Widget.
//StatefulWidget  => Consegue modificar o conteúdo do Widget.

//Widget Root
class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListaTransferencias(),
      theme: ThemeData(
        primaryColor: Colors.green[900], // https://material.io/resources/color
        accentColor: Colors.blue[700], //Secondary Color
        buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary),
      ),
    );
  }
}

//View ListaTransferencias
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

//Component ItemTransferencia
class ItemTransferencia extends StatelessWidget {
  final Transferencia transferencia;

  ItemTransferencia(this.transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(transferencia.valor.toString()),
        subtitle: Text(transferencia.numeroConta.toString()),
      ),
    );
  }
}

//View FormularioTransferencia
class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controllerCampoNumeroConta = TextEditingController();
  final TextEditingController _controllerCampoValor = TextEditingController();

  //Função. Algoritmo para criar uma transferência.
  void _criaTransferencia(BuildContext context) {
    final int numeroConta = int.tryParse(_controllerCampoNumeroConta.text);
    final double valor = double.tryParse(_controllerCampoValor.text); //Se o parse falha, retorna null
    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(numeroConta, valor);
      Navigator.pop(context, transferenciaCriada); //Recua para a tela anterior (View pai). O 2º param será enviado para ele.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _controllerCampoNumeroConta,
              rotulo: 'Numero da conta',
              dica: '0000',
            ),
            Editor(
              controlador: _controllerCampoValor,
              rotulo: 'Valor',
              dica: '0.00',
              icone: Icons.monetization_on,
            ),
            RaisedButton(
              child: Text('Confirmar'),
              onPressed: () => _criaTransferencia(context),
            )
          ],
        ),
      ),
    );
  }
}

//Component Editor (Input TextField)
class Editor extends StatelessWidget {
  TextEditingController controlador;
  String rotulo;
  String dica;
  IconData icone;

  Editor({this.controlador, this.rotulo, this.dica, this.icone}); //Os parametros envolvidos por {} são opcionais

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 16),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: rotulo,
          hintText: dica,
          icon: icone != null ? Icon(icone) : null,
        ),
      ),
    );
  }
}

//Classe, modelo para objetos.
class Transferencia {
  final int numeroConta;
  final double valor;

  Transferencia(this.numeroConta, this.valor);

  @override
  String toString() {
    return 'Transferencia{numeroConta: $numeroConta, valor: $valor}';
  }
}