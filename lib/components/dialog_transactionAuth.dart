import 'package:flutter/material.dart';

class TransactionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Autenticação'),
      content: TextField(
        obscureText: true,
        maxLength: 4,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 64,
          letterSpacing: 16,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder()
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () => { print('cancelar') },
          child: Text('Cancel'),
        ),
        FlatButton(
          onPressed: () => { print('confirmar') },
          child: Text('Confirm'),
        )
      ],
    );
  }
}
