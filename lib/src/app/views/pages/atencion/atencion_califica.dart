import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:proypet/src/app/styles/styles.dart';
import 'package:proypet/src/app/views/components/form_control/button_primary.dart';
import 'package:proypet/src/app/views/components/form_control/text_field.dart';
import 'package:proypet/src/app/views/components/transition/fadeViewSafeArea.dart';
import 'package:proypet/src/controllers/atencion_controller/atencion_controller.dart';

class AtencionCalifica extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<AtencionController>(
      // init: CalificaAtencionController(),
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
                                                          _.petImage),
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
                                    SizedBox(height: 20),
                                    Text(
                                      _.mensaje,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 20),
                                    RatingBar(
                                      initialRating: 0,
                                      minRating: 0,
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
                                    SizedBox(height: 10),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                  'Gracias por calificar el establecimiento; sigue reservando, acumula puntos y gana premios \n🌟🎁🐶🐱',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
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
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Lottie.asset('images/lottie/star.json', height: 256),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
