import 'package:flutter/material.dart';

class BotaoRecurso  extends StatelessWidget {
  final String _text;
  final IconData _icon;
  final Function _widget;

  BotaoRecurso(this._text, this._icon, this._widget);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor, //Cor de fundo,
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => _widget()));
          },
          child: Container(
            height: 100,
            width: 120,
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  _icon,
                  color: Colors.white,
                  size: 40,
                ),
                Text(
                  _text,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
