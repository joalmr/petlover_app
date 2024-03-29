import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proypet/src/app/views/pages/update_page.dart';
import 'package:proypet/src/controllers/_push_controller.dart';
import 'package:proypet/src/data/services/auth/auth_service.dart';
import 'package:proypet/src/data/services/update_service.dart';
import 'package:proypet/src/utils/preferencias_usuario/preferencias_usuario.dart';

class GlobalController extends GetxController {
  final repository = AuthService();
  final updateApp = UpdateService();

  final _prefs = new PreferenciasUsuario();
  final pushController = PushController();

  RxString _ubicacion = ''.obs;
  set ubicacion(String value) => _ubicacion.value = value;
  String get ubicacion => _ubicacion.value;

  bool get hasToken => _prefs.token != null && _prefs.token.trim() != "";
  bool get isVerify => _prefs.verify != null && _prefs.verify.trim() != "";

  @override
  void onInit() {
    super.onInit();
    ubicacion = _prefs.ubicacion ?? '';
    getInit();
  }

  getInit() async {
    bool needUpdate = await updateApp.setAppUpdate();

    if (needUpdate) {
      // Get.toNamed('update');
      showDialog(
        context: Get.context,
        barrierDismissible: false,
        useSafeArea: true,
        child: AlertDialog(
          scrollable: true,
          content: updateView(),
        ),
      );
    } else {
      getTema();
      evaluaLogin();
    }
  }

  getTema() {
    if (_prefs.themeMode != null) {
      if (_prefs.themeMode == 'claro')
        Get.changeThemeMode(ThemeMode.light);
      else
        Get.changeThemeMode(ThemeMode.dark);
    }
  }

  evaluaLogin() {
    if (hasToken) {
      if (!isVerify)
        repository.logOut();
      else
        pushController.firebase();
    }
  }
}
