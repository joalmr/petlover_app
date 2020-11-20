import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proypet/src/app/views/pages/_nav_view/destacados/detalle/detalle_destacado.dart';
import 'package:proypet/src/app/views/pages/_nav_view/veterinarias/reserva/vet_reservar.dart';
import 'package:proypet/src/app/views/pages/_nav_view/veterinarias/vet_detalle/detalle_vet.dart';
import 'package:proypet/src/app/views/pages/atencion/atencion_califica.dart';
import 'package:proypet/src/app/views/pages/mascota/agregar/agregar_mascota.dart';

import 'package:proypet/src/app/views/pages/mascota/historia/detalle_historia.dart';

import 'package:proypet/src/app/views/auth/login_page.dart';
import 'package:proypet/src/app/views/auth/singup_page.dart';
import 'package:proypet/src/app/views/auth/forgot_page.dart';
import 'package:proypet/src/app/views/pages/_nav_bar/navigation_bar.dart';
import 'package:proypet/src/app/views/pages/_nav_view/home/reserva/detalle_reserva.dart';
import 'package:proypet/src/app/views/pages/mascota/detalle/detalle_mascota.dart';

GetStorage box = GetStorage();

List<GetPage> getRutas() {
  return [
    GetPage(
      name: '/',
      page: () => box.hasData('token') && box.hasData('verify')
          ? NavigationBar(currentTabIndex: 0)
          : LoginPage(),
    ),
    //
    GetPage(name: 'login', page: () => LoginPage()),
    GetPage(name: 'registro', page: () => SingupPage()),
    GetPage(name: 'olvidopass', page: () => ForgotPage()),
    //
    GetPage(name: 'navInicio', page: () => NavigationBar(currentTabIndex: 0)),
    GetPage(name: 'navNotifica', page: () => NavigationBar(currentTabIndex: 1)),
    GetPage(name: 'navLista', page: () => NavigationBar(currentTabIndex: 2)),
    // GetPage(name: 'navDestacado', page: () => NavigationBar(currentTabIndex: 3)),
    GetPage(
        name: 'navRecompensa', page: () => NavigationBar(currentTabIndex: 3)),
    //
    GetPage(name: 'agregarmascota', page: () => MascotaAgregarPage()),
    GetPage(name: 'detallemascota', page: () => MascotaDetallePage()),
    GetPage(name: 'detallehistoriamascota', page: () => HistoriaPage()),
    //
    GetPage(name: 'vetdetalle', page: () => VetDetallePage()),
    GetPage(name: 'vetreserva', page: () => DataReserva()),
    //
    GetPage(name: 'detalledestacado', page: () => DetalleDestacadoPage()),
    GetPage(name: 'detallereservado', page: () => DetalleReservado()),

    GetPage(name: 'calificaatencion', page: () => AtencionCalifica()),
  ];
}
