import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:proypet/config/global_variables.dart';
import 'package:proypet/src/app/styles/styles.dart';
import 'package:proypet/src/app/views/components/navegadores/appbar.dart';
import 'package:proypet/src/controllers/bonus_pet/bonus_controller.dart';

class PuntosGanados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<BonusController>(
      init: BonusController(),
      builder: (_) {
        return Scaffold(
          appBar: appBar(
            texto: 'Puntos ganados',
            acc: null,
          ),
          body: _.cargando.value
              ? Center(child: CupertinoActivityIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //TODO: quitar appPruebas cuando ya este para produccion
                    appPruebas
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Card(
                                child: InkWell(
                                  onTap: () => Get.toNamed('canjearpuntos'),
                                  borderRadius: borderRadius,
                                  child: Container(
                                    width: 120,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: Column(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.cartPlus,
                                          color: colorMain,
                                        ),
                                        Text('Canjear Puntos'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                child: InkWell(
                                  onTap: () => Get.toNamed('sorteopuntos'),
                                  borderRadius: borderRadius,
                                  child: Container(
                                    width: 120,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: Column(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.gifts,
                                          color: colorMain,
                                        ),
                                        Text('Sorteo'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SizedBox(height: 0),
                    FadeIn(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5),
                        child: Text('Últimos puntos ganados',
                            style: Get.textTheme.subtitle2
                                .apply(fontWeightDelta: 2)),
                      ),
                    ),
                    Expanded(
                      child: _.bonificados.length < 1
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 0),
                                child: Text("No tienes puntos ganados"),
                              ),
                            )
                          : ListView.builder(
                              itemCount: _.bonificados.length,
                              itemBuilder: (BuildContext context, int index) {
                                final bonificado = _.bonificados[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0),
                                  child: ListTile(
                                    title: Text(
                                      '${bonificado.establishmentName}',
                                      style: Get.textTheme.subtitle2,
                                      maxLines: 2,
                                    ),
                                    trailing: CircleAvatar(
                                      backgroundColor: colorMain,
                                      foregroundColor: colorGray2,
                                      child: Text(
                                        '+${bonificado.points}',
                                        style: TextStyle(
                                          fontSize: sizeSmallx2,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
