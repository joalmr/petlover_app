import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proypet/src/models/establecimiento/establecimiento_model.dart';
import 'package:proypet/src/models/login/user_model.dart';
import 'package:proypet/src/models/mascota/mascota_model.dart';
import 'package:proypet/src/providers/establecimiento_provider.dart';
import 'package:proypet/src/providers/mascota_provider.dart';
import 'package:proypet/src/providers/user_provider.dart';
import 'package:proypet/src/views/components/card_swiper.dart';
import 'package:proypet/src/views/components/form_control/button_primary.dart';
import 'package:proypet/src/views/components/form_control/text_from.dart';
import 'package:proypet/src/views/components/modal_bottom.dart';
import 'package:proypet/src/views/components/snackbar.dart';
import 'package:proypet/src/views/components/transicion/fadeView.dart';

import 'package:proypet/src/styles/styles.dart';
import 'package:proypet/src/utils/regex.dart';
import 'package:proypet/src/views/pages/viewVeterinarias/detalleView/tabsDetalle/view_general.dart';
import 'package:proypet/src/views/pages/viewVeterinarias/reservaView/reserva_data.dart';
import 'package:url_launcher/url_launcher.dart';

import 'tabsDetalle/view_comentario.dart';
import 'tabsDetalle/view_horario.dart';
import 'tabsDetalle/view_precio.dart';

class VetDetallePage extends StatefulWidget {
  // final String vetID;
  final EstablecimientoModel vet;
  VetDetallePage({this.vet});
  @override
  _VetDetallePageState createState() => _VetDetallePageState(vet: vet);
}

class _VetDetallePageState extends State<VetDetallePage> {
  // String vetID;
  EstablecimientoModel vet;
  _VetDetallePageState({this.vet});
  final establecimientoProvider = EstablecimientoProvider();
  final mascotaProvider = MascotaProvider();
  final userProvider = UserProvider();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  User user = User(); //
  List<MascotaModel> misMascotas;
  Modal modal = new Modal();
  bool delivery = false;
  String telefono = "";
  bool reservarClic = true;

  @override
  void initState() {
    List<Service> servicios = vet.services;
    servicios.forEach((element) {
      if (element.slug == "delivery") {
        delivery = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: FadeView(
        child: _onStack(vet),
      ),
    );
  }

  Widget _onStack(vet) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
        ),
        Stack(
          children: <Widget>[
            Container(
              height: 260.0,
              width: double.infinity,
              child: (vet.slides.length > 0)
                  ? _swiperVets(vet.slides, true)
                  : _swiperVets(["images/vet_prueba.jpg"], false),
            ),
            Positioned(
              right: 7.5,
              bottom: 9.5,
              child: Container(
                height: 55.0,
                width: 55.0,
                decoration: BoxDecoration(
                  color: colorGray1,
                  borderRadius: BorderRadius.circular(100.0),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(vet.logo),
                      fit: BoxFit.cover),
                ),
              ),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 260.0, bottom: 60.0),
          child: _onDetail(vet),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: <Widget>[
                SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).backgroundColor,
                    child: Icon(
                      Icons.phone,
                      color: colorMain,
                    ),
                    onPressed: _launchPhone,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.725,
                  child: buttonPri(
                      'Reservar servicio', reservarClic ? _reservar : null),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text("", style: Theme.of(context).textTheme.subtitle1),
          ),
        ),
      ],
    );
  }

  Widget _onDetail(EstablecimientoModel localVet) {
    return DefaultTabController(
      length: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Container(
              width: MediaQuery.of(context).size.width - 0.0,
              // height: MediaQuery.of(context).size.height * 0.1 ,
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${localVet.distance}km de distancia',
                      style: TextStyle(fontSize: sizeSmallx2),
                    ),
                    Text(localVet.name, //nombreVet(0),
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .apply(fontWeightDelta: 2)),
                  ],
                ),
                subtitle: Text('${localVet.address} ',
                    style: TextStyle(fontSize: sizeSmallx1)),
                trailing: Stack(
                  children: <Widget>[
                    Container(height: 56.0, width: 60.0),
                    Container(
                      height: 50.0,
                      width: 50.0,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          color: colorYellow),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.star, color: Colors.white, size: 12.0),
                            // SizedBox(width: 5.0),
                            Text(
                              localVet.stars.toString(),
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child: Tooltip(
                        message: 'Atenciones',
                        child: Container(
                          height: 25.0,
                          width: 25.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: colorMain,
                          ),
                          child: Center(
                            child: Text(
                              localVet.attentions.toString(),
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          TabBar(
            indicatorColor: colorMain,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            labelColor: colorMain,
            unselectedLabelColor: Theme.of(context).textTheme.subtitle2.color,
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            isScrollable: true,
            tabs: [
              Tab(text: "General"),
              Tab(text: "Precios"),
              Tab(text: "Horarios"),
              Tab(text: "Comentarios"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                ViewGeneral(localVet: localVet),
                ViewPrecio(localVet: localVet),
                ViewHorario(localVet: localVet),
                ViewComentario(idVet: localVet.id),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _swiperVets(imagen, bool urlBool) {
    return CardSwiper(
      imagenes: imagen,
      urlBool: urlBool,
      height: 145.0,
    );
  }

  _launchPhone() async {
    var url = 'tel:${vet.phone}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo llamar $url';
    }
  }

  _reservar() async {
    setState(() {
      reservarClic = false;
    });

    misMascotas = await mascotaProvider.getPets();
    misMascotas = misMascotas.where((x) => x.status != 0).toList();
    // modal.mainModal(context,DataReserva(establecimientoID: widget.idvet, misMascotas: misMascotas, mascotaID: misMascotas[0].id));
    if (misMascotas.length > 0) {
      var usuario = await userProvider.getUser();
      user = usuario.user;

      if (user.phone == null || user.phone.trim() == "") {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => FadeIn(
            child: AlertDialog(
              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              content: Container(
                  height: 200.0,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('Debe ingresar un número de teléfono',
                            style: Theme.of(context).textTheme.subtitle2),
                        SizedBox(
                          height: 10.0,
                        ),
                        FormularioText(
                          hintText: 'Ingrese teléfono',
                          icon: Icons.phone,
                          obscureText: false,
                          onSaved: (value) => user.phone = value,
                          textCap: TextCapitalization.words,
                          valorInicial: user.phone,
                          boardType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        buttonPri("Guardar teléfono", _onPhone),
                        FlatButton(
                          child: Text(
                            "Cancelar",
                            style: TextStyle(color: colorMain),
                          ),
                          onPressed: _cancelar,
                        )
                      ],
                    ),
                  )),
            ),
          ),
        );
      } else {
        setState(() {
          reservarClic = true;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DataReserva(
              establecimientoID: vet.id,
              misMascotas: misMascotas,
              mascotaID: misMascotas[0].id,
              establecimientoName: vet.name,
              delivery: delivery,
            ),
          ),
        );
      }
    } else {
      setState(() {
        reservarClic = true;
      });
      mostrarSnackbar('No puede generar una reserva, debe agregar una mascota',
          colorRed, scaffoldKey);
    }
  }

  void _onPhone() async {
    setState(() {
      reservarClic = true;
      formKey.currentState.save();
    });

    bool phone = phoneRegex(user.phone);
    if (phone) {
      await userProvider.editUser(user); //
      Navigator.pop(context);
    } else {
      mostrarSnackbar('Número telefónico inválido', colorRed, scaffoldKey);
    }
  }

  _cancelar() {
    setState(() {
      reservarClic = true;
    });
    Navigator.pop(context);
  }
}
