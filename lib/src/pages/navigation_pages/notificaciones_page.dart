import 'package:flutter/material.dart';
import 'package:proypet/src/pages/shared/appbar_menu.dart';

final List imagen = ['images/elegante1.jpg','images/royal1.jpg'];
final List imagen2 = ['images/royal1.jpg','images/elegante1.jpg'];
class NotificacionesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(leadingH,'Notificaciones',null),
      body: Container(
        child: Center(
          child: Text('No cuenta con notificaciones'),
        ),
      ),
    );
  }
}