import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proypet/src/app/styles/styles.dart';
import 'package:proypet/src/app/components/appbar_menu.dart';
import 'package:proypet/src/app/components/form_control/button_primary.dart';
import 'package:proypet/src/app/components/form_control/text_from.dart';
import 'package:proypet/src/controllers/usuario_controller/solicita_vet_controller.dart';

class SolicitaVetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<SolicitaVetController>(
        init: SolicitaVetController(),
        builder: (_) {
          return Scaffold(
            appBar: appbar(null, 'Solicitar Veterinaria', null),
            body: _.envia.value
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/cat_dog/invitation.png'),
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          'Gracias por solicitar tu veterinaria',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          'Nos contactarémos',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      buttonOutLine('Volver', () => Get.back(), colorMain),
                    ],
                  )
                : ListView(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    children: [
                      FormularioText(
                        labelText: 'Nombre de veterinaria',
                        textCap: TextCapitalization.sentences,
                        onChanged: (value) => _.nombre = value,
                      ),
                      FormularioText(
                        labelText: 'Distrito',
                        textCap: TextCapitalization.sentences,
                        onChanged: (value) => _.distrito = value,
                      ),
                      FormularioText(
                        labelText: 'Teléfono',
                        boardType: TextInputType.phone,
                        hintText: '(Opcional)',
                        onChanged: (value) => _.telefono = value,
                      ),
                      SizedBox(height: 10),
                      buttonPri('Enviar', _.enviarSolicitud),
                    ],
                  ),
          );
        });
  }
}
