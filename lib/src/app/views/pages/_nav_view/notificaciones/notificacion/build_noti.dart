import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proypet/src/data/models/model/notificacion/notificacion_model.dart';

Widget buildNoti(Notificacion noti, funcion) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    child: InkWell(
        onTap: funcion,
        child: Card(
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.end,
                  //   children: [
                  //     ClipRRect(
                  //       borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                  //       child: Image(
                  //         image: CachedNetworkImageProvider(noti.petPicture),
                  //         height: 80,
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //     noti.notificationDate != ''
                  //         ? Text(
                  //             noti.notificationDate,
                  //             style: TextStyle(fontSize: 8, color: Get.textTheme.subtitle2.color.withOpacity(.6)),
                  //           )
                  //         : SizedBox(height: 0)
                  //   ],
                  // ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                    child: Image(
                      image: CachedNetworkImageProvider(noti.petPicture),
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(noti.message),
                          Text(
                            noti.notificationDate,
                            style: TextStyle(fontSize: 8, color: Get.textTheme.subtitle2.color.withOpacity(.6)),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: AspectRatio(
                    aspectRatio: 3 / 2,
                    child: CachedNetworkImage(
                      useOldImageOnUrlChange: false,
                      imageUrl: noti.notificationImg,
                      // height: 200,
                      // width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, text) => Container(height: 200, width: double.maxFinite, child: Center(child: CupertinoActivityIndicator())),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
  );
}
