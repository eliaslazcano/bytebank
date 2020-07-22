import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

//StatelessWidget => Não consegue modificar o conteúdo do Widget.
//StatefulWidget  => Consegue modificar o conteúdo do Widget.

//Widget Root
class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
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
