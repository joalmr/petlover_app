import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:proypet/src/pages/shared/styles/styles.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> imagenes;
  //final bool autoplay1;
  final double radius;
  final double height;
  final double scale;

  CardSwiper({@required this.imagenes,this.height,this.radius=0.0,this.scale=1.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      child: Swiper(
        itemBuilder: (BuildContext context, int index){
          return ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Image(
              image: AssetImage(imagenes[index]),
              fit: BoxFit.cover,
            )
          );
        },
        // viewportFraction: 0.99,
        scale: scale,                        
        itemCount: imagenes.length,
        pagination: new SwiperPagination(
          builder: new DotSwiperPaginationBuilder(
            activeColor: colorMain,
          )
        ),
      ),
    );
  }
}