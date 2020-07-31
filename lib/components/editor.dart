import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;
  final TextInputType keyboard;
  final double fontSize;

  Editor({this.controlador, this.rotulo, this.dica, this.icone, this.keyboard, this.fontSize}); //Os parametros envolvidos por {} são opcionais

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controlador,
      style: fontSize != null ? TextStyle(fontSize: fontSize) : TextStyle(fontSize: 16),
      keyboardType: keyboard != null ? keyboard : TextInputType.phone,
      decoration: InputDecoration(
        labelText: rotulo,
        hintText: dica,
        icon: icone != null ? Icon(icone) : null,
      ),
    );
  }
}