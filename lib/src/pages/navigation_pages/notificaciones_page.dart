import 'package:flutter/material.dart';
import 'package:proypet/src/model/notificacion/notificacion_model.dart';
import 'package:proypet/src/pages/reserva/reserva_detalle_page.dart';
import 'package:proypet/src/pages/shared/appbar_menu.dart';
import 'package:proypet/src/providers/notificacion_provider.dart';

final List imagen = ['images/elegante1.jpg','images/royal1.jpg'];
final List imagen2 = ['images/royal1.jpg','images/elegante1.jpg'];
class NotificacionesPage extends StatefulWidget {

  @override
  _NotificacionesPageState createState() => _NotificacionesPageState();
}

class _NotificacionesPageState extends State<NotificacionesPage> {
  NotificacionProvider notificacionProvider = NotificacionProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(leadingH,'Notificaciones',null),
      body: Container(
        child: SingleChildScrollView(
          // padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
          child: _onFuture(),
        ),
      ),
    );
  }

  _onFuture(){
    return FutureBuilder(
      future: notificacionProvider.getNotificacion(),
      builder: (BuildContext context, AsyncSnapshot<NotificacionModel> snapshot) {
        if(!snapshot.hasData){
          return LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
          );
        }
        else{
          List<Notificacion> notification = snapshot.data.notifications;

          if(notification.length < 1){
            return Center(
              child: Text("No tiene notificaciones"),
            );
          }
          else{
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 20.0, ),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: notification.length,
              itemBuilder: (BuildContext context, int index) {
                return _notificacionCase(notification[index]);
              },
            );
          }
        }
      },
    );
  }

  _notificacionCase(Notificacion notificacion){
    switch(notificacion.type) {
      case "ComingBooking":
        return _comingBooking(notificacion);
        break;
      case "NextDate":
        return _nextDate(notificacion);
        break;
      case "Recordatory":
        return _recordatory(notificacion);
        break;
      default:
        return SizedBox(height: 0.0,);
        break;
    }
  }

  _comingBooking(notificacion){
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 5.0,), //horizontal: 20.0
      leading: CircleAvatar(radius: 25.0 ,backgroundImage: NetworkImage(notificacion.petPicture),),
      title: Text(notificacion.message,
        style: TextStyle(color: Colors.black54),),
    );
  }

  _nextDate(notificacion){
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      leading: CircleAvatar(radius: 25.0 ,backgroundImage: NetworkImage(notificacion.petPicture),),
      title: Text(notificacion.message,
        style: TextStyle(color: Colors.black54),),
      onTap: ()=>Navigator.push(
        context,MaterialPageRoute(
          builder: (context) => ReservaDetallePage(vetID: notificacion.options["establishment_id"],),
      )),
    );
  }

  _recordatory(notificacion){
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      leading: CircleAvatar(radius: 25.0 ,backgroundImage: NetworkImage(notificacion.petPicture),),
      title: Text(notificacion.message,
        style: TextStyle(color: Colors.black54),),
      // onTap: ()=>Navigator.pushNamed(context, 'navLista', arguments:{ "filtros":[11] } ),
    );

  }

}

