import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proypet/config/global_variables.dart';
import 'package:proypet/source/_global/_global_controller.dart';
import 'package:proypet/source/veterinarias/model/establecimiento_short_model.dart';
import 'package:proypet/source/veterinarias/service/establishment_service.dart';

import 'filtra_vets_controller.dart';

class VeterinariasController extends GetxController {
  final vetService = EstablishmentService();

  RxList<EstablishmentModelList> vetLocales = <EstablishmentModelList>[].obs;
  RxList<EstablishmentModelList> temp = <EstablishmentModelList>[].obs;
  List<int> listaFiltros = [];
  RxInt respVets = 0.obs;
  RxBool loading = true.obs;

  final global = Get.find<GlobalController>();

  bool ordena = false;

  ScrollController scrollController = new ScrollController();

  @override
  void onInit() {
    super.onInit();

    if (prefUser.hasToken()) {
      getVets();
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future refresh() => _refresh();

  Future<Null> _refresh() async {
    await Future.delayed(Duration(milliseconds: 2));
    getVets();
    ordena = false;
    return null;
  }

  getVets() => _getVets();

  Future<void> _getVets() async {
    loading.value = true;
    var resp = await vetService.getVets(listaFiltros);
    List<EstablishmentModelList> listaVets = resp['establecimientos'];
    respVets.value = resp['code']; // == 200
    if (respVets.value == 200) {
      vetLocales.clear();
      vetLocales.addAll(listaVets);

      temp.clear();
      temp.addAll(listaVets);
    }
    loading.value = false;
  }

  orderVets() {
    ordena = !ordena;
    if (ordena) {
      vetLocales.sort();
    } else {
      vetLocales.clear();
      vetLocales.addAll(temp);
    }
  }

  bool get gps => respVets.value == 200;

  filtra() {
    final f = Get.find<FiltraVetsController>();
    f.filtrar();
  }
}
