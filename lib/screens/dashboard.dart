import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        children: <Widget>[
          Image.asset("images/bytebank_logo.png")
        ],
      ),
    );
  }
}
