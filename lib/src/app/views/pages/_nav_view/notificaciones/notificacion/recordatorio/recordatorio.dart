import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proypet/src/controllers/veterinaria_controller/filtra_vets_controller.dart';
import 'package:proypet/src/data/models/notification/notificacion_model.dart';
import 'package:proypet/src/utils/icons_map.dart';

import '../build_noti.dart';

final filtros = Get.find<FiltraVetsController>();

Widget recordatorio(Notificacion notification) {
  return buildNoti(
      notification, () => _fnRecordatorio(notification.options["slug"]));
}

_fnRecordatorio(String slug) {
  filtros.listaFiltros.clear();
  filtros.listaFiltros.addAll([slugNum[slug]]);
  filtros.filtrar();
}
