import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proypet/src/app/views/pages/_nav_view/veterinarias/reserva/data/dataDelivery.dart';
import 'package:proypet/src/app/styles/styles.dart';
import 'package:proypet/src/app/components/appbar_menu.dart';
import 'package:proypet/src/app/components/form_control/button_primary.dart';
import 'package:proypet/src/app/components/form_control/ddl_control.dart';
import 'package:proypet/src/app/views/pages/_nav_view/veterinarias/reserva/components/direccion_reserva.dart';
import 'package:proypet/src/app/views/pages/_nav_view/veterinarias/reserva/components/fecha.dart';
import 'package:proypet/src/app/views/pages/_nav_view/veterinarias/reserva/components/servicio_dato.dart';
import 'package:proypet/src/controllers/veterinaria_controller/reserva_vet_controller.dart';
import 'components/mapa_reserva.dart';

class DataReserva extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<ReservaVetController>(
        init: ReservaVetController(),
        builder: (_) {
          return Scaffold(
            appBar: appbar(null, 'Reservar servicio', null),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _.vet.name,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2.5),
                      Text('Mascota'),
                      SizedBox(height: .5),
                      ddlFutureImg(context, _.mascotaId, _.misMascotas, (opt) {
                        _.mascotaId = opt.toString();
                      })
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 0),
                  child: Text(
                    'Servicio: ${_.textoServicios}',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 0),
                  child: Text(
                    'Fecha: ${_.fechaTimeAt.substring(0, 16)}',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
                SizedBox(height: 0),
                Expanded(
                  child: Form(
                    child: Stepper(
                      currentStep: _.stepVal,
                      steps: [
                        Step(
                          isActive: _.stepVal > 0 ? true : false,
                          state: _.stepVal > 0
                              ? StepState.complete
                              : StepState.disabled,
                          title: Text('Seleccione servicio'),
                          content: Container(
                            width: double.maxFinite,
                            child: Wrap(
                              children: _.servicioReservaLista
                                  .map((item) => MisServicioReserva(item))
                                  .toList()
                                  .cast<Widget>(),
                            ),
                          ),
                        ),
                        Step(
                          isActive: _.stepVal > 1 ? true : false,
                          state: _.stepVal > 1
                              ? StepState.complete
                              : StepState.disabled,
                          title: Text('Seleccione fecha'),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Fecha'),
                              SizedBox(height: .5),
                              crearFecha(context),
                              SizedBox(height: 10.0),
                              Text('Hora'),
                              SizedBox(height: .5),
                              TextField(
                                enableInteractiveSelection: false,
                                controller: _.inputHoraController,
                                onTap: () => _.pickTime(context),
                                cursorColor: colorMain,
                                decoration: InputDecoration(
                                  hintText: 'Hora de atención',
                                  prefixIcon:
                                      Icon(Icons.access_time, color: colorMain),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Step(
                          title: Text('Finalizar'),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _.hasDelivery
                                  ? Padding(
                                      padding: EdgeInsets.only(bottom: .5),
                                      child: Text('Movilidad'),
                                    )
                                  : SizedBox(height: 0.0),
                              _.hasDelivery
                                  ? ddlMain(
                                      context,
                                      _.deliveryId,
                                      deliveryList,
                                      (opt) {
                                        _.deliveryId = opt.toString();
                                      },
                                    )
                                  : SizedBox(height: 0.0),
                              (_.hasDelivery && _.deliveryId != "1")
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 5.0),
                                        autoDireccion(),
                                        SizedBox(height: 5.0),
                                        Container(
                                          height: 150.0,
                                          width: double.infinity,
                                          child: MapaReserva(),
                                        ),
                                        SizedBox(height: 10.0),
                                      ],
                                    )
                                  : SizedBox(height: 0.0),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Observación'),
                                  SizedBox(height: .5),
                                  TextField(
                                    enableInteractiveSelection: false,
                                    controller: _.inputObservacioController,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    keyboardType: TextInputType.multiline,
                                    cursorColor: colorMain,
                                    decoration: InputDecoration(
                                        hintText:
                                            'Ingrese observación (opcional)'),
                                    onChanged: (value) => _.observacion = value,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      text:
                                          '*Si seleccionó ', // default text style
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Otro servicio',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                            text:
                                                ', especifíquelo en observaciones',
                                            style: TextStyle()),
                                      ],
                                    ),
                                    style: TextStyle(fontSize: sizeSmallx1),
                                  ),
                                  SizedBox(height: 30.0),
                                  _.servicioReservaLista.length > 0
                                      ? buttonPri(
                                          'Confirmar reserva',
                                          _.actBtn.value
                                              ? _.reservarAtencion
                                              : null)
                                      : buttonPri('Confirmar reserva', () {},
                                          cargando: true),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                      onStepContinue: () {
                        if (_.stepVal + 1 >= 3) return;
                        _.stepVal++;
                      },
                      onStepCancel: () {
                        if (_.stepVal - 1 < 0) return;
                        _.stepVal--;
                      },
                      controlsBuilder: (BuildContext context,
                          {VoidCallback onStepContinue,
                          VoidCallback onStepCancel}) {
                        _.stepContinue = onStepContinue;
                        _.stepCancel = onStepCancel;
                        return SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buttonFlat(
                        'Atras',
                        _.stepVal == 0 ? null : () => _.stepCancel(),
                        _.stepVal == 0 ? colorGray3 : colorMain,
                      ),
                      buttonFlat(
                        'Siguiente',
                        _.stepVal == 2 ? null : () => _.stepContinue(),
                        _.stepVal == 2 ? colorGray3 : colorMain,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
