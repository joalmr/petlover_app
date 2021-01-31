import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget reservaReprogramada(noti) {
  return Container(
    height: 210,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('images/notificacion/fondo2.png'),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10),
          Text(noti['message'],
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            child: Image(
              image: CachedNetworkImageProvider(noti['pet_picture']),
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    ),
  );
}
