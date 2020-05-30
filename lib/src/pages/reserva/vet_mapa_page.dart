import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proypet/src/model/establecimiento/establecimiento_model.dart';
import 'package:proypet/src/pages/reserva/vet_detalle_page.dart';
import 'package:proypet/src/shared/appbar_menu.dart';
import 'package:proypet/src/styles/styles.dart';
import 'package:proypet/src/styles/titulos.dart';


class VetMapaPage extends StatefulWidget {
  final establecimientos;
  VetMapaPage({@required this.establecimientos});
  @override
  _VetMapaPageState createState() => _VetMapaPageState(vetLocales: establecimientos);
}

class _VetMapaPageState extends State<VetMapaPage> {
  List<EstablecimientoModel> vetLocales;
  _VetMapaPageState({@required this.vetLocales});
  GoogleMapController _controller;
  List<Marker> allMarkers = [];
  PageController _pageController;
  int prevPage;
  String _mapStyle;
  bool mapToggle = false;
  var currentLocation;
  
  @override
  void initState() {
    //implement initState
    super.initState();

    Geolocator().getCurrentPosition().then((currloc){
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
      });
    });

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });

    vetLocales.forEach((element) {
      allMarkers.add(Marker(
        markerId: MarkerId(element.name),
        draggable: false,
        infoWindow: InfoWindow(
          title: element.name, 
          snippet: '★ ${element.stars} (${element.attentions})',//element.direccion,
          onTap: ()=>Navigator.push(context, MaterialPageRoute(
            builder: (_)=>VetDetallePage(vet: element),
          )),
        ),
        position: LatLng(element.latitude,element.longitude), //element.locationCoords,
        ));
    });
    
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(null,'Mapa veterinarias', null),
      body: mapToggle 
        ? _onBody()
        : LinearProgressIndicator(
          backgroundColor: Colors.grey[200],
        )
    );
  }

  Widget _onBody(){
    return Stack(
      children: <Widget>[
        FadeIn(
          child: Container(
            height: double.infinity,//MediaQuery.of(context).size.height,
            width: double.infinity,//MediaQuery.of(context).size.width,
            child: GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              compassEnabled: true,              
              gestureRecognizers:Set()
              ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
              ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
              ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
              ..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              tiltGesturesEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(vetLocales[0].latitude,vetLocales[0].longitude),//vetLocales[0].locationCoords, 
                zoom: 16.0
              ),
              markers: Set.from(allMarkers),
              onMapCreated: mapCreated,
            )
          ),
        ),
        Positioned(
          bottom: 25.0,
          child: Container(
            height: 200.0,
            width: MediaQuery.of(context).size.width,
            child: mapToggle ? PageView.builder(
              controller: _pageController,
              itemCount: vetLocales.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return _vetShopList(index);
              },
            ) : null
          ),
        )         
      ],
    );
  }
  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }

  _vetShopList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 140.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
        onTap: ()=>Navigator.push(context, MaterialPageRoute(
          builder: (_)=>VetDetallePage(vet: vetLocales[index]),
        )),
        child: 
        Stack(children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0.0, 4.0),
                    blurRadius: 10.0,
                  ),
                ]),
              child: Container(
                decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  child: _contenidoVet(vetLocales[index]),
              )))
        ])
      ),
    );
  }

  _contenidoVet(vetLocales){
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: colorGray1,
        backgroundImage: CachedNetworkImageProvider(vetLocales.logo),
        radius: 25.0,
      ),
      title: Text(
        vetLocales.name,
        maxLines: 2,
        style: tituloH4clasico,
      ),
      subtitle: Text(
        vetLocales.description,
        maxLines: 3,
        style: TextStyle(
            fontSize: sizeH5,
            fontWeight: FontWeight.w300),
      ),
    );
  }
///////////////////////////////////////
  void mapCreated(controller){
    setState(() {
      _controller = controller;
      _controller.setMapStyle(_mapStyle);
    });
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(vetLocales[_pageController.page.toInt()].latitude, vetLocales[_pageController.page.toInt()].longitude), //vetLocales[_pageController.page.toInt()].locationCoords,
      zoom: 16.0,
      bearing: 45.0,
      tilt: 45.0))
    );
  }

}