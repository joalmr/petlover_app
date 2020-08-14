import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proypet/src2/app/styles/styles.dart';
import 'package:proypet/src2/app/views/components/form_control/button_primary.dart';
import 'package:proypet/src2/app/views/components/form_control/text_from.dart';
import 'package:proypet/src2/app/views/components/transition/fadeView.dart';
import 'package:proypet/src2/app/views/components/wave_clipper.dart';
import 'package:proypet/src2/controllers/auth/forgot_controller.dart';

class ForgotPage extends StatelessWidget {
  const ForgotPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotController>(
        init: ForgotController(),
        builder: (_) {
          return Scaffold(
            appBar: PreferredSize(preferredSize: Size.fromHeight(0), child: AppBar(backgroundColor: colorMain, elevation: 0)),
            body: FadeView(
              child: Stack(
                children: <Widget>[
                  Form(
                    // key: formKey,
                    child: ListView(
                      children: <Widget>[
                        WaveClipperOut(120.0),
                        SizedBox(height: 10.0),
                        Center(
                          child: Text('¿Olvidaste tu contraseña?',
                              style: Theme.of(context).textTheme.headline5.apply(fontWeightDelta: 2).copyWith(fontSize: 24.0)),
                        ),
                        SizedBox(height: 10.0),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Text('Ingresa tu correo electrónico para reestablecer contraseña')),
                        SizedBox(height: 20.0),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: FormularioText(
                              hintText: 'Email',
                              icon: Icons.alternate_email,
                              obscureText: false,
                              onChanged: (value) => _.email = value,
                              textCap: TextCapitalization.none,
                              valorInicial: null,
                              boardType: TextInputType.text,
                            )),
                        SizedBox(height: 30.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Obx(() => buttonPri('Enviar correo electrónico', !_.loading.value ? _.getForgot : null)),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: AppBar(backgroundColor: Colors.transparent, elevation: 0, centerTitle: true),
                  )
                ],
              ),
            ),
          );
        });
  }
}
