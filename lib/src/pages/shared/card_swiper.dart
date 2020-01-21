import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:proypet/main.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> imagenes;
  final bool autoplay1;

  CardSwiper({@required this.imagenes,this.autoplay1});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145.0,
      width: double.infinity,
      child: Swiper(
        autoplay: autoplay1,
        itemBuilder: (BuildContext context, int index){
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(imagenes[index])
              )
            ),
          );
        },
        itemCount: imagenes.length,
        pagination: new SwiperPagination(
          builder: new DotSwiperPaginationBuilder(
            activeColor: colorMain,
          )
        ),
      ),
    );
  }

  getImagen(){

  }
}