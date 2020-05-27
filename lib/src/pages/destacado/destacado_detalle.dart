import 'package:flutter/material.dart';
import 'package:proypet/src/model/destacado/destacado_model.dart';
import 'package:proypet/src/shared/appbar_menu.dart';
import 'package:proypet/src/styles/titulos.dart';

class DetalleDestacadoPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Destacado destacado = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: appbar(null,'Destacados',null),
      body: _onDestacado(destacado),
    );
  }

  _onDestacado(Destacado destacado) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image(
              fit: BoxFit.cover,
              height: 350,                
              width: double.infinity,
              image: AssetImage(destacado.image)
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(destacado.title, style: tituloH4clasico,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text('Autor: ${destacado.author}', style: TextStyle(color: Colors.black54),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 50.0),
            child: Text(destacado.text, textAlign: TextAlign.justify,  ),
          ),
        ],
      ),
    );
  }
}