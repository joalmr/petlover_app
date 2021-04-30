import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:proypet/components/form_control/button_primary.dart';
import 'package:proypet/components/form_control/text_field.dart';
import 'package:proypet/components/transition/fadeViewSafeArea.dart';
import 'package:proypet/config/path_variables.dart';
import 'package:proypet/design/styles/styles.dart';
import 'package:proypet/source/atencion/controller/atencion_calificar_controller.dart';

class AtencionCalifica extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<CalificaAtencionController>(
      init: CalificaAtencionController(),
      builder: (_) {
        return Scaffold(
          backgroundColor: colorMain,
          body: FadeViewSafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    !_.calificado.value
                        ? Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 25),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 50, bottom: 10),
                                      child: Center(
                                        child: ClipRRect(
                                          child: CircleAvatar(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.5),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100)),
                                                child: Image(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          _.vetLogo),
                                                  height: 150,
                                                  width: 150,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            backgroundColor: Colors.white,
                                            radius: 75,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        text: 'Has ganado ',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: colorYellow,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '${_.bonificacion} ',
                                            style: TextStyle(
                                              fontSize: 32,
                                              color: colorYellow,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${_.bonificacion != '1' ? 'puntos' : 'punto'} ',
                                            style: TextStyle(
                                              color: colorYellow,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Text(
                                        _.mensaje,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    RatingBar.builder(
                                      initialRating: 0,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: false,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 2.0),
                                      glow: false,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: colorYellow,
                                      ),
                                      onRatingUpdate: (rating) =>
                                          _.puntuacion(rating),
                                    ),
                                    SizedBox(height: 20),
                                    textfieldArea(
                                      _.inputComentController,
                                      "Ingrese comentario de la atención recibida",
                                      250,
                                      3,
                                    ),
                                    buttonOutLine(
                                      'Calificar',
                                      _.onRate,
                                      Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22.5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Gracias por calificar el establecimiento; sigue reservando, acumula puntos y gana premios \n🌟🎁🐶🐱',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Lottie.asset(
                                      pathLottie('star'),
                                      height: 140,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
                Positioned(
                  top: 10,
                  right: 5,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Get.back(),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
