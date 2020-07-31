import 'package:flutter/material.dart';

class MensagemCentralizada extends StatelessWidget {
  final String mensagem;
  final IconData icone;
  final double iconeTamanho;
  final double fonteTamanho;

  MensagemCentralizada(
    this.mensagem, {
    this.icone,
    this.iconeTamanho = 64,
    this.fonteTamanho = 24
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Visibility(
            child: Icon(
              icone,
              size: iconeTamanho,
            ),
            visible: icone != null,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              mensagem,
              style: TextStyle(
                fontSize: fonteTamanho
              ),
            ),
          )
        ],
      ),
    );
  }
}
