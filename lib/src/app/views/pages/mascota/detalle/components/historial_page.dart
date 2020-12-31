import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proypet/src/app/views/components/appbar_menu.dart';
import 'package:proypet/src/controllers/mascota_controller/detalle_mascota_controller.dart';

import 'tab_lista_historia.dart';

class HistorialMascota extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MascotaDetalleController>(
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: appbar(null, 'Historial de ${_.pet.name}', null),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: listaHistorialTab(_.history.toList()),
          ),
        );
      },
    );
  }
}
