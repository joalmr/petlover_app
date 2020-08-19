import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proypet/src2/app/styles/styles.dart';
import 'package:proypet/src2/controllers/veterinaria_controller/filtra_vets_controller.dart';

class ServicioFlat extends StatelessWidget {
  final String texto;
  final int numero;
  ServicioFlat(this.texto, this.numero);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FiltraVetsController>(builder: (_) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: FlatButton(
          child: Text(
            texto,
            style: TextStyle(color: _.listaFiltros.contains(numero) ? Colors.white : colorGreen2),
          ),
          onPressed: () => _.add2List(numero),
          color: _.listaFiltros.contains(numero) ? colorGreen2 : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0),
            side: BorderSide(color: colorGreen2),
          ),
        ),
      );
    });
  }
}
