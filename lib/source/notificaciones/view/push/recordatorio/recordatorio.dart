import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget recordatorio(noti) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Image(
                image: CachedNetworkImageProvider(noti['pet_picture']),
                height: 65,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${noti['message']}'),
            )),
          ],
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: Image(
              image: CachedNetworkImageProvider(noti['notification_image']),
              height: 140,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              child: Text('Omitir'),
              onPressed: () => Get.back(),
            ),
            TextButton(
                child: Text('Ir'),
                onPressed: () {
                  Get.back();
                  Get.toNamed('nav/notifica');
                }),
          ],
        ),
      ],
    ),
  );
}