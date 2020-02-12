import 'package:flutter/material.dart';
import 'package:proypet/main.dart';
import 'package:proypet/src/pages/shared/appbar_menu.dart';

class DestacadosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar2(
        leadingH,
        titleH,
        <Widget>[
          IconButton(
            icon: Icon(Icons.dashboard),
            onPressed: (){},
          )
        ]
      ),
      body: Container(
        child: Center(
          child: Text('Destacados'),
        ),
      ),
    );
  }
}