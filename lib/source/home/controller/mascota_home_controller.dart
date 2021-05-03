import 'package:get/get.dart';

class PetHomeController extends GetxController {
  void agregarMascota() {
    _agregarMascotaVoid();
  }

  Future<void> _agregarMascotaVoid() async {
    await Get.toNamed('mascota/agregar');
  }

  void detalleMascota(id) {
    _detalleMascotaVoid(id);
  }

  Future<void> _detalleMascotaVoid(id) async {
    await Get.toNamed('mascota', arguments: id);
  }
}
