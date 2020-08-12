import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proypet/src/views/components/form_control/button_primary.dart';
import 'package:proypet/src/views/components/form_control/text_from.dart';
import 'package:proypet/src/views/components/snackbar.dart';
import 'package:proypet/src/views/components/transicion/fadeView.dart';

import 'package:proypet/src/views/components/wave_clipper.dart';
import 'package:proypet/src/services/user_provider.dart';
import 'package:proypet/src/styles/styles.dart';

class ForgotPage extends StatefulWidget {
  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final loginProvider = UserProvider();
  String val = "";
  bool enviarClic = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: colorMain,
            elevation: 0,
          )),
      body: FadeView(
        child: Stack(
          children: <Widget>[
            Form(
              key: formKey,
              child: ListView(
                children: <Widget>[
                  WaveClipperOut(120.0),
                  SizedBox(height: 10.0),
                  Center(
                    child: Text('¿Olvidaste tu contraseña?', style: Theme.of(context).textTheme.headline5.apply(fontWeightDelta: 2).copyWith(fontSize: 24.0)),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Ingresa tu dirección de correo electrónico para reestablecer contraseña')),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FormularioText(
                      hintText: 'Email',
                      icon: Icons.alternate_email,
                      obscureText: false,
                      onSaved: (value) => val = value,
                      textCap: TextCapitalization.none,
                      valorInicial: null,
                      boardType: TextInputType.text,
                    ),
                    // textForm('Email', Icons.alternate_email, false, (value)=>val=value, TextCapitalization.none, null,TextInputType.text),
                  ),
                  SizedBox(height: 30.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: buttonPri('Enviar correo electrónico', enviarClic ? _forgot : null),
                  ),
                  SizedBox(height: 20.0),
                ],
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
              ),
            )
          ],
        ),
      ),
    );
  }

  _forgot() async {
    setState(() {
      enviarClic = false;
      formKey.currentState.save();
    });

    if (val.trim() == "") {
      _fnResponse(
        "Ingrese correo electrónico",
        colorRed,
      );
      Timer(Duration(milliseconds: 1500), () {
        setState(() {
          enviarClic = true;
        });
      });
    } else {
      int resp = await loginProvider.forgotPassword(val);

      if (resp == 200) {
        _fnResponse("Se le envío un correo electrónico a la dirección ingresada", colorMain);
        Timer(Duration(milliseconds: 3500), () {
          Get.until((route) => route.isFirst);
          // Navigator.of(context).popUntil((route) => route.isFirst);
        });
      } else if (resp == 205) {
        _fnResponse("Este correo no esta registrado en Proypet", colorRed);
        Timer(Duration(milliseconds: 1500), () {
          setState(() {
            enviarClic = true;
          });
        });
      } else {
        _fnResponse("Error, ejecución denegada", colorRed);
        Timer(Duration(milliseconds: 1500), () {
          setState(() {
            enviarClic = true;
          });
        });
      }
    }
  }

  _fnResponse(
    String texto,
    Color color,
  ) {
    //dynamic fnExecute
    mostrarSnackbar(texto, color);
    // fnExecute;
  }
}
