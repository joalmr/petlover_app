import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proypet/components/form_control/buttons/btn_primary.dart';
import 'package:proypet/components/form_control/text_from.dart';
import 'package:proypet/components/snackbar.dart';
import 'package:proypet/config/variables_globales.dart';
import 'package:proypet/design/styles/styles.dart';
import 'package:proypet/source/_global/_global_controller.dart';
import 'package:proypet/source/home/domain/controller/home_controller.dart';
import 'package:proypet/source/mascota/model/pet_model.dart';
import 'package:proypet/source/usuario/model/user_model.dart';
import 'package:proypet/source/booking/service/booking_service.dart';
import 'package:proypet/source/usuario/service/user_service.dart';
import 'package:proypet/source/veterinarias/data/model/establecimiento_model.dart';
import 'package:proypet/source/veterinarias/data/model/establecimiento_short_model.dart';
import 'package:proypet/source/veterinarias/data/service/establishment_service.dart';
import 'package:proypet/utils/preferencias_usuario/preferencias_model.dart';
import 'package:proypet/utils/regex.dart';
import 'package:url_launcher/url_launcher.dart';
import 'lista_vets_controller.dart';

class VetDetalleController extends GetxController {
  final userService = new UserService();
  final vetService = new EstablishmentService();
  final bookingService = new BookingService();

  final homeC = Get.find<HomeController>();
  final globalC = Get.find<GlobalController>();
  final vetsC = Get.find<VeterinariasController>();

  Rx<EstablecimientoModel> _vet = EstablecimientoModel().obs;
  set vet(EstablecimientoModel value) => _vet.value = value;
  EstablecimientoModel get vet => _vet.value;

  RxBool reservaClic = true.obs;

  List<MascotaModel2> misMascotas = [];

  RxString _telefono = "".obs;
  RxBool cargando = true.obs;

  set telefono(String value) => _telefono.value = value;
  String get telefono => _telefono.value;

  String vetId;
  String vetInit;

  UserModel2 usuario;

  RxBool favorite = false.obs;

  @override
  void onInit() {
    super.onInit();
    vetInit = Get.arguments;
    traeMascotas();
    usuario = homeC.usuario.value;
    telefono = usuario.phone;
    getVet();
    isFavorite();
  }

  @override
  void onClose() {
    super.onClose();
  }

  isFavorite() {
    if (prefUser.favoritesVets.contains(vetInit)) {
      favorite.value = true;
    } else {
      favorite.value = false;
    }
  }

  setFavorite() {
    PreferenciasModel forStorage = new PreferenciasModel();
    forStorage.favoritesVets = prefUser.favoritesVets;

    if (prefUser.favoritesVets.contains(vetInit)) {
      forStorage.favoritesVets.remove(vetInit);
      favorite.value = false;
    } else {
      forStorage.favoritesVets.add(vetInit);
      favorite.value = true;
    }

    prefUser.storageUser = preferenciasModelToJson(forStorage);
    vetsC.getFavorites();
  }

  getVet() => _getVet(vetInit);
  _getVet(idInit) async {
    vetId = idInit;
    var respVet = await vetService.getVet(vetId);
    vet = respVet['establishment'];
    cargando.value = false;
  }

  bool get hasDelivery {
    //usado en reserva controller
    int existe = 0;
    vet.services.forEach((element) {
      if (element.slug == 'delivery') {
        existe++;
      }
    });
    if (existe != 0) {
      return true;
    }
    return false;
  }

  traeMascotas() => misMascotas =
      homeC.mascotas.where((element) => element.status != 0).toList();

  llamar() => _launchPhone();

  _launchPhone() async {
    var url = 'tel:${vet.phone}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo llamar $url';
    }
  }

  // bool get mascotasCount => misMascotas.length > 0;
  // bool get sinTelefono => telefono.isEmpty; //.isNullOrBlank;

  final formKey = GlobalKey<FormState>();

  reservar() => _reservar();

  List<EstablishmentModelList> vetPremium = [];
  _getPremiumClose() {
    vetPremium = vetsC.vetLocales
        .where((element) => element.premium == true && element.id != vet.id)
        .take(2)
        .toList();
  }

  _reservar() async {
    reservaClic.value = false;
    if (!vet.premium && !vet.available) {
      _getPremiumClose();
      reservaClic.value = true;
      bookingService.tryBooking(vet.id);

      Get.dialog(SimpleDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        children: [
          Text(
              'Hola, disculpa este establecimiento no puede recibir reservas.'),
          SizedBox(height: 3),
          Text('Tenemos estas opciones cerca '),
          SizedBox(height: 10),
          vetPremium.length < 1
              ? Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Sin resultados')))
              : vetPremium.length == 1
                  ? _gotoVet(vetPremium[0])
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _gotoVet(vetPremium[0]),
                        SizedBox(height: 10),
                        _gotoVet(vetPremium[1]),
                      ],
                    ),
          SizedBox(height: 10),
        ],
      ));
    } else {
      if (misMascotas.length > 0) {
        if (telefono != null && telefono.trim() != '') {
          reservaClic.value = true;
          Get.toNamed('vet/reserva');
        } else {
          reservaClic.value = true;
          Get.dialog(AlertDialog(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            content: Container(
                height: 220.0,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Text(
                        'Debe ingresar un número de teléfono',
                        style: Get.textTheme.subtitle2,
                      ),
                      SizedBox(height: 10.0),
                      FormularioText(
                        hintText: 'Ingrese teléfono',
                        icon: Icons.phone,
                        obscureText: false,
                        onChanged: (value) => telefono = value,
                        textCap: TextCapitalization.words,
                        valorInicial: telefono,
                        boardType: TextInputType.phone,
                      ),
                      SizedBox(height: 10.0),
                      btnPrimary(
                        text: "Guardar teléfono",
                        onPressed: _onPhone,
                      ),
                      TextButton(
                        child: Text("Cancelar",
                            style: TextStyle(color: colorMain)),
                        onPressed: () {
                          reservaClic.value = true;
                          Get.back();
                        },
                      )
                    ],
                  ),
                )),
          ));
        }
      } else {
        reservaClic.value = true;
        mostrarSnackbar(
          'No puede generar una reserva, debe agregar una mascota',
          colorRed,
        );
      }
    }
  }

  // bool get telCambio => telefono.isEmpty; //.isNullOrBlank;

  void _onPhone() async {
    if (telefono != null && telefono.trim() != '') {
      bool phone = phoneRegex(telefono);
      if (phone) {
        await userService.editUser(usuario.name, usuario.lastname, telefono);
        homeC.getUsuario();
        usuario = homeC.usuario.value;
        Get.back();
      } else {
        mostrarSnackbar('Número telefónico inválido', colorRed);
      }
    } else {
      mostrarSnackbar('Número telefónico inválido', colorRed);
    }
  }

  Widget _gotoVet(EstablishmentModelList vetPremium) {
    return InkWell(
      onTap: () {
        cargando.value = true;
        Get.back();
        vet = _getVet(vetPremium.id);
        Timer(Duration(milliseconds: 250), () => cargando.value = false);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (vetPremium.slides.length > 0)
              ? Image(
                  image: CachedNetworkImageProvider(vetPremium.slides.first),
                  height: 75)
              : Image(image: AssetImage("images/vet_prueba.jpg"), height: 75),
          SizedBox(height: 3),
          Text(vetPremium.name)
        ],
      ),
    );
  }
}